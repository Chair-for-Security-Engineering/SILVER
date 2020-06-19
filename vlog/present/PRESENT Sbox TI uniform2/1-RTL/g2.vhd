library IEEE;
use IEEE.std_logic_1164.all;

entity g2BOOM is
	Port ( x : in  STD_LOGIC_VECTOR (7 downto 0);
	       y : out  STD_LOGIC_VECTOR (3 downto 0));
end entity g2BOOM;

architecture circ_arch of g2BOOM is
   signal t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20, t21, t22, t23, t24, t25, t26, t27, t28, t29, t30, t31, t32, t33, t34, t35, t36, t37, t38, t39, t40, t41, t42, t43, t44, t45, t46, t47, t48, t49, t50, t51 : std_logic;
   signal n_x0, n_x1, n_x2, n_x3, n_x4, n_x5, n_x6, n_x7 : std_logic;
  	signal x0,x1,x2,x3,x4,x5,x6,x7 : std_logic;
	 signal y0,y1,y2,y3 : std_logic;

begin 
  
x0 <= x(7);
x1 <= x(6);
x2 <= x(5);
x3 <= x(4);
x4 <= x(3);
x5 <= x(2);
x6 <= x(1);
x7 <= x(0);

y <= y0&y1&y2&y3;


   n_x0 <= not x0;
   n_x1 <= not x1;
   n_x2 <= not x2;
   n_x3 <= not x3;
   n_x4 <= not x4;
   n_x5 <= not x5;
   n_x6 <= not x6;
   n_x7 <= not x7;

   t0 <= x1 and x2 and x5 and x6 and n_x7;
   t1 <= n_x1 and n_x2 and n_x3 and x4 and n_x5 and x7;
   t2 <= x1 and x2 and n_x3 and x4 and n_x5 and x7;
   t3 <= n_x1 and n_x2 and x5 and x6 and n_x7;
   t4 <= n_x1 and x2 and n_x4 and x5 and x6 and x7;
   t5 <= n_x1 and n_x2 and x3 and x4 and n_x6 and x7;
   t6 <= x1 and x2 and x3 and x4 and n_x6 and x7;
   t7 <= n_x0 and n_x1 and x4 and x5 and n_x7;
   t8 <= n_x1 and x2 and x4 and n_x5 and n_x6 and n_x7;
   t9 <= x1 and n_x2 and x4 and n_x5 and n_x6 and n_x7;
   t10 <= x0 and x2 and x4 and x6 and n_x7;
   t11 <= n_x0 and n_x2 and n_x4 and n_x6 and x7;
   t12 <= x1 and n_x2 and n_x4 and x5 and x6 and x7;
   t13 <= n_x0 and x1 and n_x4 and n_x5 and x6 and n_x7;
   t14 <= x0 and n_x2 and n_x4 and x5 and n_x6 and n_x7;
   t15 <= n_x0 and x2 and x4 and n_x5 and x6 and x7;
   t16 <= n_x1 and x2 and n_x3 and n_x4 and n_x5 and x7;
   t17 <= n_x1 and x2 and x3 and n_x4 and n_x6 and x7;
   t18 <= n_x0 and n_x2 and x4 and x6 and n_x7;
   t19 <= x0 and n_x1 and x4 and x5 and n_x6 and x7;
   t20 <= x0 and x1 and n_x4 and n_x5 and x7;
   t21 <= n_x1 and n_x2 and x4 and n_x5 and n_x6 and x7;
   t22 <= x1 and x2 and n_x3 and n_x4 and x5 and x7;
   t23 <= x1 and n_x2 and x3 and x4 and x6 and x7;
   t24 <= x1 and n_x2 and n_x3 and n_x4 and n_x5 and x7;
   t25 <= n_x1 and n_x2 and x3 and n_x4 and x6 and x7;
   t26 <= x1 and n_x2 and n_x3 and x4 and x5 and x7;
   t27 <= x1 and x2 and x3 and n_x4 and x6 and x7;
   t28 <= n_x1 and n_x2 and n_x3 and n_x4 and x5 and x7;
   t29 <= x1 and n_x2 and x3 and n_x4 and n_x6 and x7;
   t30 <= x0 and x1 and x4 and x5 and n_x7;
   t31 <= n_x0 and n_x1 and n_x4 and n_x5 and x7;
   t32 <= x0 and x2 and n_x4 and n_x6 and x7;
   t33 <= n_x1 and x2 and n_x3 and x4 and x5 and x7;
   t34 <= n_x1 and x2 and x3 and x4 and x6 and x7;
   t35 <= x0 and n_x2 and x4 and n_x5 and x6 and x7;
   t36 <= x1 and x2 and n_x5 and n_x6 and x7;
   t37 <= x0 and n_x1 and n_x4 and n_x5 and x6 and n_x7;
   t38 <= n_x0 and x2 and n_x4 and x5 and n_x6 and n_x7;
   t39 <= n_x0 and x1 and x4 and x5 and n_x6 and x7;
   t40 <= n_x4 and n_x5 and n_x6 and x7;
   t41 <= x3 and n_x4 and x5 and n_x7;
   t42 <= n_x3 and x4 and n_x6 and n_x7;
   t43 <= n_x3 and n_x4 and x6 and n_x7;
   t44 <= x3 and x4 and n_x5 and n_x7;
   t45 <= n_x5 and n_x6 and x7;
   t46 <= x5 and n_x6 and n_x7;
   t47 <= n_x5 and x6 and n_x7;
   t48 <= x5 and x6 and x7;
   t49 <= x4 and x5 and x6 and n_x7;
   t50 <= x5 and n_x6;
   t51 <= n_x5 and x6;

   y0 <= t45 or t46 or t47 or t48;
   y1 <= t50 or t51;
   y2 <= t1 or t2 or t5 or t6 or t16 or t17 or t21 or t22 or t23 or t24 or t25 or t26 or t27 or t28 or t29 or t33 or t34 or t41 or t42 or t43 or t44;
   y3 <= t0 or t3 or t4 or t7 or t8 or t9 or t10 or t11 or t12 or t13 or t14 or t15 or t18 or t19 or t20 or t21 or t30 or t31 or t32 or t35 or t36 or t37 or t38 or t39 or t40 or t49;
end circ_arch;
