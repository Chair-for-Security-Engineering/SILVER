/*
 * -----------------------------------------------------------------
 * COMPANY : Ruhr-Universität Bochum, Chair for Security Engineering
 * AUTHOR  : Pascal Sasdrich (pascal.sasdrich@rub.de)
 * DOCUMENT: https://eprint.iacr.org/2020/634.pdf
 * -----------------------------------------------------------------
 *
 * Copyright (c) 2020, Pascal Sasdrich
 *
 * All rights reserved.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTERS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Please see license.rtf and README for license and further instructions.
 */

#ifndef SYLVAN_EXTENSION_H
#define SYLVAN_EXTENSION_H

#include <sylvan.h>
#include <sylvan_stats.h>
#include <sylvan_cache.h>
#include <math.h>

using namespace sylvan;

static const uint64_t CACHE_BDD_SATCOUNTLN			= (31LL<<40);
static const uint64_t CACHE_BDD_SINGPROB			= (32LL<<40);
static const uint64_t CACHE_BDD_COMBPROB			= (33LL<<40);
static const uint64_t CACHE_BDD_STATINDEP			= (34LL<<40);

TASK_2(double, mtbdd_satcountln, MTBDD, dd, size_t, nvars)
{
    if (mtbdd_isleaf(dd)) {
        if (dd == mtbdd_false) return -1.0;
        return nvars;
    }

    /* Perhaps execute garbage collection */
    sylvan_gc_test();

    union {
        double d;
        uint64_t s;
    } hack;

    /* Consult cache */
    if (cache_get3(CACHE_BDD_SATCOUNTLN, dd, 0, nvars, &hack.s)) {
        return hack.d;
    }

    SPAWN(mtbdd_satcountln, mtbdd_gethigh(dd), nvars-1);
    double low = CALL(mtbdd_satcountln, mtbdd_getlow(dd), nvars-1);
    double high = SYNC(mtbdd_satcountln);
    
    if (low < 0.0)
        hack.d = high;
    else if (high < 0.0)
        hack.d = low;
    else if (low < high)
        hack.d = high + log1p(pow(2.0,low-high)) / M_LN2;
    else
        hack.d = low + log1p(pow(2.0,high-low)) / M_LN2;

    cache_put3(CACHE_BDD_SATCOUNTLN, dd, 0, nvars, hack.s);

    return hack.d;
}
#define mtbdd_satcountln(dd, nvars) CALL(mtbdd_satcountln, dd, nvars)

TASK_2(double, mtbdd_singprobability, MTBDD, dd, size_t, nvars)
{
    /* Trivial cases */
    if (mtbdd_isleaf(dd)) return (dd == mtbdd_true);

    /* Perhaps execute garbage collection */
    sylvan_gc_test();
    
    union {
        double d;
        uint64_t s;
    } hack;	
    
    /* Consult cache */
    if (cache_get3(CACHE_BDD_SINGPROB, dd, 0, nvars, &hack.s)) {
        return hack.d;
    }

    SPAWN(mtbdd_singprobability, mtbdd_gethigh(dd), nvars-1);
    double low  = CALL(mtbdd_singprobability, mtbdd_getlow(dd), nvars-1);
    double high = SYNC(mtbdd_singprobability);
    hack.d = 0.5 * (low + high);

    cache_put3(CACHE_BDD_SINGPROB, dd, 0, nvars, hack.s);
    
    return hack.d;
}
#define mtbdd_singprobability(dd, nvars) CALL(mtbdd_singprobability, dd, nvars)

TASK_4(double, mtbdd_combprobability, MTBDD, dd1, size_t, nvars1, MTBDD, dd2, size_t, nvars2)
{
    /* Perhaps execute garbage collection */
    sylvan_gc_test();
    
    union {
        double d;
        uint64_t s;
    } hack;	
    
    /* Consult cache */
    if (cache_get3(CACHE_BDD_COMBPROB, dd1, dd2, 0, &hack.s)) {
        return hack.d;
    }
    
    if (mtbdd_getvar(dd1) >  mtbdd_getvar(dd2)) {
        hack.d = CALL(mtbdd_combprobability, dd2, nvars2, dd1, nvars1);
    } else if (mtbdd_isleaf(dd2)) {
        hack.d = (dd1 == mtbdd_true) & (dd2 == mtbdd_true);
    } else if (mtbdd_isleaf(dd1)) {
        hack.d = (dd1 == mtbdd_true) ? pow(2.0, mtbdd_satcountln(dd2, nvars2) - nvars2) : 0.0;
    } else if (dd1 == dd2) {
        hack.d = pow(2.0, mtbdd_satcountln(dd1, nvars1) - nvars1);
    } else if (mtbdd_getvar(dd1) == mtbdd_getvar(dd2)) {		
        SPAWN(mtbdd_combprobability, mtbdd_gethigh(dd1), nvars1-1, mtbdd_gethigh(dd2), nvars2-1);
        double low  = CALL(mtbdd_combprobability, mtbdd_getlow(dd1), nvars1-1, mtbdd_getlow(dd2), nvars2-1);
        double high = SYNC(mtbdd_combprobability);
        hack.d = 0.5 * (low + high);
    } else {
        SPAWN(mtbdd_combprobability, mtbdd_gethigh(dd1), nvars1-1, dd2, nvars2);
        double low  = CALL(mtbdd_combprobability, mtbdd_getlow(dd1), nvars1-1, dd2, nvars2);
        double high = SYNC(mtbdd_combprobability);		
        hack.d = 0.5 * (low + high);
    }
    
    cache_put3(CACHE_BDD_COMBPROB, dd1, dd2, 0, hack.s);
    
    return hack.d;
}
#define mtbdd_combprobability(dd1, nvars1, dd2, nvars2) CALL(mtbdd_combprobability, dd1, nvars1, dd2, nvars2)

TASK_4(int, mtbdd_statindependence, MTBDD, dd1, size_t, nvars1, MTBDD, dd2, size_t, nvars2)
{
    /* Perhaps execute garbage collection */
    sylvan_gc_test();
    
    union {
        int b;
        uint64_t s;
    } hack;	
    
    /* Consult cache */
    if (cache_get3(CACHE_BDD_STATINDEP, dd1, dd2, 0, &hack.s)) {
        return hack.b;
    }
    
    SPAWN(mtbdd_singprobability, dd1, nvars1);
    SPAWN(mtbdd_singprobability, dd2, nvars2);
    
    double single1  = SYNC(mtbdd_singprobability);
    double single2  = SYNC(mtbdd_singprobability);
    double combined = CALL(mtbdd_combprobability, dd1, nvars1, dd2, nvars2);

    hack.b = fabs(combined - (single1 * single2)) < 0.000001;
    
    cache_put3(CACHE_BDD_STATINDEP, dd1, dd2, 0, hack.s);
    
    return hack.b;
}
#define mtbdd_statindep(dd1, nvars1, dd2, nvars2) CALL(mtbdd_statindependence, dd1, nvars1, dd2, nvars2)

#endif // SYLVAN_EXTENSION_H