//////////////////////////////////////////////////////////////////////////////////
// COMPANY:		Ruhr University Bochum
// AUTHOR:		Amir Moradi (for the paper: https://eprint.iacr.org/2020/634 )
//////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, Amir Moradi
// All rights reserved.
//
// BSD-3-Clause License
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the copyright holder, their organization nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTERS BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include "stdio.h"
// #include "conio.h"
#include "stdlib.h"
#include "string.h"
#include "ctype.h"
#include "math.h"

#define Parser_With_GND_and_VDD  0

#define Parser_Max_Name_Length 500

#define Parser_CellType_Gate     0
#define Parser_CellType_Reg      1

#define Parser_CellType_Type_Buffer   1
#define Parser_CellType_Type_Mux      2

#define Parser_SignalType_input  0
#define Parser_SignalType_output 1
#define Parser_SignalType_wire   2

#define Parser_Task_find_module_type   0
#define Parser_Task_find_module_name   1
#define Parser_Task_find_open_bracket  2
#define Parser_Task_find_point         3
#define Parser_Task_find_IO_port       4
#define Parser_Task_find_signal_name   5
#define Parser_Task_find_close_bracket 6
#define Parser_Task_find_comma         7

struct Parser_CellTypeStruct {
	char	GateOrReg;
	char	NumberOfCases;
	char**	Cases;
	char*	CustomName;
	char	Type;
	char	NumberOfInputs;
	char**	Inputs;
	char	NumberOfOutputs;
	char**	Outputs;
};


struct Parser_CellStruct {
	int		Type;
	char*	Name;
	short	Depth;
	short   Cycle;
	char	NumberOfInputs;
	int*	Inputs;
	char	NumberOfOutputs;
	int*	Outputs;
	int*	RegValueIndexes;
	char	Deleted;
};

struct Parser_SignalStruct {
	char*	Name;
	char	Type;
	short	Depth;
	int		Output;
	int		NumberOfInputs;
	int*	Inputs;
	char**	Attribute;
	int		NumberOfAttributeCycles;
	char	Deleted;
};

struct Parser_LibraryStruct {
	Parser_CellTypeStruct**	CellTypes = NULL;
	int						NumberOfCellTypes;
};

struct Parser_CircuitStruct {
	Parser_SignalStruct**	Signals = NULL;
	int						NumberOfSignals;
	int						NumberOfConstants;
	int*					Inputs = NULL;
	int*					Outputs = NULL;
	int						NumberOfInputs;
	int						NumberOfOutputs;

	Parser_CellStruct**		Cells = NULL;
	int						NumberOfCells;
	int*					Gates = NULL;
	int*					Regs = NULL;
	int						NumberOfGates;
	int						NumberOfRegs;
	int						ClockSignalIndex = -1;

	short					MaxDepth = 0;
	int**					CellsInDepth = NULL;
	int*					NumberOfCellsInDepth = NULL;

	short					MaxCycles = 0;

	int*					TransitionList[2] = { NULL, NULL };
	int						NumberOfTransitions = 0;

	int**					CycleTransitionList[2] = { NULL, NULL };
	int*					NumberOfCycleTransitions = NULL;
};

//***************************************************************************************

int StrReplaceChar(char *Str, char ch_source, char ch_destination)
{
	int i, j;

	j = 0;
	for (i = 0;i < strlen(Str);i++)
		if (Str[i] == ch_source)
		{
			Str[i] = ch_destination;
			j++;
		}

	return (j);
}

//***************************************************************************************

void StrLowerCase(char *Str)
{
	int i;

	for (i = 0;i < strlen(Str);i++)
		Str[i] == tolower(Str[i]);
}

//***************************************************************************************

void ReadNonCommentFromFile(FILE* FileHeader, char* Str, const char* CommentSyntax)
{
	int  l;
	char ch;

	l = (int)strlen(CommentSyntax);
	do {
		int res = fscanf(FileHeader, "%s", Str);
		if (!memcmp(CommentSyntax, Str, l))
		{
			do ch = fgetc(FileHeader);
			while ((ch != '\n') && (ch != '\r') && (!feof(FileHeader)));
		}
	} while ((!memcmp(CommentSyntax, Str, l)) && (!feof(FileHeader)));

	if (feof(FileHeader))
		Str[0] = 0;
}

//***************************************************************************************

void fReadaWord(FILE* F, char* Buffer, char* Attribute)
{
	static char Lastch = 0;
	char		ch;
	int			i = 0;
	int			j = 0;

	if (Attribute)
		Attribute[0] = 0;

	while ((!feof(F)) || Lastch)
	{
		if (Lastch)
			ch = Lastch;
		else
			ch = fgetc(F);

		if ((!feof(F)) || Lastch)
		{
			Lastch = 0;
			if ((ch == 32) || (ch == 13) || (ch == 10) || (ch == 9))
			{
				if (i)
					break;
			}
			else if ((ch == '(') || (ch == ')'))
			{
				if (i)
				{
					Lastch = ch;
					break;
				}
				else
				{
					Buffer[i++] = ch;

					if (ch == '(')
					{
						ch = fgetc(F);
						if (ch == '*')
						{
							while (!feof(F))
							{
								ch = fgetc(F);
								if ((Buffer[i] == '*') && (ch == ')'))
									break;
								else
								{
									Buffer[i] = ch;
									if (Attribute)
										Attribute[j++] = ch;
								}
							}

							if (!feof(F))
							{
								i--;
								j--;
							}
						}
						else
						{
							Lastch = ch;
							break;
						}
					}
					else
						break;
				}
			}
			else if ((ch == '/') && i)
			{
				if (Buffer[i - 1] == '/') // start of the comment "//"
				{
					i--;

					while (!feof(F))
					{
						ch = fgetc(F);
						if ((ch == '\n') || (ch == '\r'))
							break;
					}
				}
			}
			else if ((ch == '*') && i)
			{
				if (Buffer[i - 1] == '/') // start of the comment "/*"
				{
					i--;

					while (!feof(F))
					{
						ch = fgetc(F);
						if ((Buffer[i] == '*') && (ch == '/'))
							break;
						else
							Buffer[i] = ch;
					}
				}
				else if (Buffer[i - 1] == '(') // start of the attribute "(*"
				{
					i--;

					while (!feof(F))
					{
						ch = fgetc(F);
						if ((Buffer[i] == '*') && (ch == ')'))
							break;
						else
						{
							Buffer[i] = ch;
							if (Attribute)
								Attribute[j++] = ch;
						}
					}

					if (!feof(F))
						j--;
				}
			}
			else
				Buffer[i++] = ch;
		}
	}

	Buffer[i] = 0;
	if (Attribute)
		Attribute[j] = 0;
	return;
}

//***************************************************************************************

int ReadLibrryFile(char* LibraryFileName, char* LibraryName, Parser_LibraryStruct* Library)
{
	FILE *LibraryFile;
	char *Str1 = (char *)malloc(Parser_Max_Name_Length * sizeof(char));
	char ch;
	int  i, j;
	char LibraryRead = 0;
	Parser_CellTypeStruct** TempCellTypes;

	Library->NumberOfCellTypes = 0;
	LibraryFile = fopen(LibraryFileName, "rt");

	if (LibraryFile == NULL)
	{
		printf("library file ""%s"" not found\n", LibraryFileName);
		free(Str1);
		return 1;
	}

	while ((!LibraryRead) && (!feof(LibraryFile)))
	{
		Str1[0] = 0;
		while (strcmp(Str1, "Library") && (!feof(LibraryFile)))
			ReadNonCommentFromFile(LibraryFile, Str1, "%");

		if (!feof(LibraryFile))
		{
			ReadNonCommentFromFile(LibraryFile, Str1, "%");
			if (!strcmp(Str1, LibraryName))
			{
				ReadNonCommentFromFile(LibraryFile, Str1, "%");

				while (strcmp(Str1, "Library") && (!feof(LibraryFile)))
				{
					TempCellTypes = (Parser_CellTypeStruct **)malloc((Library->NumberOfCellTypes + 1) * sizeof(Parser_CellTypeStruct *));
					memcpy(TempCellTypes, Library->CellTypes, Library->NumberOfCellTypes * sizeof(Parser_CellTypeStruct *));
					free(Library->CellTypes);
					Library->CellTypes = TempCellTypes;

					Library->CellTypes[Library->NumberOfCellTypes] = (Parser_CellTypeStruct *)malloc(sizeof(Parser_CellTypeStruct));
					if (!strcmp(Str1, "Gate"))
						Library->CellTypes[Library->NumberOfCellTypes]->GateOrReg = Parser_CellType_Gate;
					else if (!strcmp(Str1, "Reg"))
						Library->CellTypes[Library->NumberOfCellTypes]->GateOrReg = Parser_CellType_Reg;
					else
					{
						printf("CellType ""%s"" in library not known\n", Str1);
						fclose(LibraryFile);
						free(Str1);
						return 1;
					}

					ReadNonCommentFromFile(LibraryFile, Str1, "%");
					Library->CellTypes[Library->NumberOfCellTypes]->NumberOfCases = atoi(Str1);
					Library->CellTypes[Library->NumberOfCellTypes]->Cases = (char **)malloc(Library->CellTypes[Library->NumberOfCellTypes]->NumberOfCases * sizeof(char *));

					for (i = 0;i < Library->CellTypes[Library->NumberOfCellTypes]->NumberOfCases;i++)
					{
						ReadNonCommentFromFile(LibraryFile, Str1, "%");
						Library->CellTypes[Library->NumberOfCellTypes]->Cases[i] = (char *)malloc(strlen(Str1) + 1);
						strcpy(Library->CellTypes[Library->NumberOfCellTypes]->Cases[i], Str1);
					}

					ReadNonCommentFromFile(LibraryFile, Str1, "%");
					Library->CellTypes[Library->NumberOfCellTypes]->CustomName = (char *)malloc(strlen(Str1) + 1);
					strcpy(Library->CellTypes[Library->NumberOfCellTypes]->CustomName, Str1);

					Library->CellTypes[Library->NumberOfCellTypes]->Type = 0;
					if (strstr(Str1, "buf") == Str1)
						Library->CellTypes[Library->NumberOfCellTypes]->Type |= Parser_CellType_Type_Buffer;

					if (strstr(Str1, "mux") == Str1)
						Library->CellTypes[Library->NumberOfCellTypes]->Type |= Parser_CellType_Type_Mux;

					ReadNonCommentFromFile(LibraryFile, Str1, "%");
					Library->CellTypes[Library->NumberOfCellTypes]->NumberOfInputs = atoi(Str1);
					Library->CellTypes[Library->NumberOfCellTypes]->Inputs = (char **)malloc(Library->CellTypes[Library->NumberOfCellTypes]->NumberOfInputs * sizeof(char *));

					for (i = 0;i < Library->CellTypes[Library->NumberOfCellTypes]->NumberOfInputs;i++)
					{
						ReadNonCommentFromFile(LibraryFile, Str1, "%");
						Library->CellTypes[Library->NumberOfCellTypes]->Inputs[i] = (char *)malloc(strlen(Str1) + 1);
						strcpy(Library->CellTypes[Library->NumberOfCellTypes]->Inputs[i], Str1);
					}

					ReadNonCommentFromFile(LibraryFile, Str1, "%");
					Library->CellTypes[Library->NumberOfCellTypes]->NumberOfOutputs = atoi(Str1);
					Library->CellTypes[Library->NumberOfCellTypes]->Outputs = (char **)malloc(Library->CellTypes[Library->NumberOfCellTypes]->NumberOfOutputs * sizeof(char *));

					for (i = 0;i < Library->CellTypes[Library->NumberOfCellTypes]->NumberOfOutputs;i++)
					{
						ReadNonCommentFromFile(LibraryFile, Str1, "%");
						Library->CellTypes[Library->NumberOfCellTypes]->Outputs[i] = (char *)malloc(strlen(Str1) + 1);
						strcpy(Library->CellTypes[Library->NumberOfCellTypes]->Outputs[i], Str1);
					}

					Library->NumberOfCellTypes++;
					ReadNonCommentFromFile(LibraryFile, Str1, "%");
				}

				LibraryRead = 1;
			}
		}
	}

	fclose(LibraryFile);
	free(Str1);

	if (!LibraryRead)
	{
		printf("Library could not be found\n");
		return 1;
	}

	return 0;
}

//***************************************************************************************

int ProcessSubAttribute(char* SubAttributeText, char*** &NewAttributes, int* &NumberOfNewAttributes, int &NumberOfNewAttributesCycles)
{
	int		i;
	char*	ptr;
	char	ch;
	int		j;
	int		k;
	int		l;
	char*	Str1;
	char*	Str2;
	char*	Str3;
	char*	Str4;
	int		VariableIndex1;
	int		VariableIndex2;
	int		VariableIndex;
	int		ShareIndex1;
	int		ShareIndex2;
	int		ShareIndex;
	int		VariableIndexUpwards;
	int		ShareIndexUpwards;
	char**	Buffer_char;
	char***	Buffer_char2;
	int*	Buffer_int;
	int		Cycle;

	Buffer_char2 = (char***)malloc((NumberOfNewAttributesCycles + 1) * sizeof(char**));
	memcpy(Buffer_char2, NewAttributes, NumberOfNewAttributesCycles * sizeof(char**));
	free(NewAttributes);
	NewAttributes = Buffer_char2;
	NewAttributes[NumberOfNewAttributesCycles] = NULL;

	Buffer_int = (int*)malloc((NumberOfNewAttributesCycles + 1) * sizeof(int));
	memcpy(Buffer_int, NumberOfNewAttributes, NumberOfNewAttributesCycles * sizeof(int));
	free(NumberOfNewAttributes);
	NumberOfNewAttributes = Buffer_int;
	NumberOfNewAttributes[NumberOfNewAttributesCycles] = 0;

	Cycle = NumberOfNewAttributesCycles;
	NumberOfNewAttributesCycles++;

	Str1 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));
	Str2 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));
	Str3 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));
	Str4 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));

	ptr = SubAttributeText - 1;

	do {
		i = 0;
		VariableIndex1 = -1;
		VariableIndex2 = -1;
		ShareIndex1 = -1;
		ShareIndex2 = -1;
		Str1[0] = 0;
		Str2[0] = 0;

		do {
			ptr++;
			ch = *ptr;

			if ((ch == '[') && (!i))
			{
				// do nothing
			}
			else if (ch == ':')
			{
				if (Str2[0] || (VariableIndex1 != -1))
					ShareIndex1 = atoi(Str1);
				else
					VariableIndex1 = atoi(Str1);
				i = 0;
			}
			else if (ch == ']')
			{
				if (Str2[0] || (VariableIndex2 != -1))
					ShareIndex2 = atoi(Str1);
				else
					VariableIndex2 = atoi(Str1);
				i = 0;
			}
			else if (ch == '_')
			{
				Str1[i] = 0;
				strcpy(Str2, Str1);
				i = 0;
			}
			else if ((ch == ',') || (ch == 0))
			{
				if ((VariableIndex1 != -1) && (ShareIndex1 != -1))
				{
					printf("given attribute is not valid: %s\n", SubAttributeText);
					free(Str1);
					free(Str2);
					free(Str3);
					free(Str4);
					return(1);
				}

				VariableIndex = atoi(Str2);
				ShareIndex = atoi(Str1);
				VariableIndexUpwards = (VariableIndex1 < VariableIndex2) ? 1 : -1;
				ShareIndexUpwards = (ShareIndex1 < ShareIndex2) ? 1 : -1;

				for (j = VariableIndex1;((VariableIndexUpwards == 1) && (j <= VariableIndex2)) || ((VariableIndexUpwards == -1) && (j >= VariableIndex2)); j += VariableIndexUpwards)
				{
					if (VariableIndex1 != -1)
						sprintf(Str3, "%d_", j);
					else
					{
						if (strstr(Str1, "refresh"))
						{
							l = atoi(&Str1[7]);
							sprintf(Str3, "ref%d", l);
						}
						else if (strstr(Str1, "control"))
							strcpy(Str3, "con");
						else if (strstr(Str1, "clock"))
							strcpy(Str3, "clk");
						else
							sprintf(Str3, "%d_", VariableIndex);
					}

					for (k = ShareIndex1;((ShareIndexUpwards == 1) && (k <= ShareIndex2)) || ((ShareIndexUpwards == -1) && (k >= ShareIndex2)); k += ShareIndexUpwards)
					{
						if (ShareIndex1 != -1)
							sprintf(Str4, "%s%d", Str3, k);
						else
						{
							if (strstr(Str1, "refresh") || strstr(Str1, "control") || strstr(Str1, "clock"))
								strcpy(Str4, Str3);
							else
								sprintf(Str4, "%s%d", Str3, ShareIndex);
						}

						Buffer_char = (char**)malloc((NumberOfNewAttributes[Cycle] + 1) * sizeof(char*));
						memcpy(Buffer_char, NewAttributes[Cycle], NumberOfNewAttributes[Cycle] * sizeof(char*));
						free(NewAttributes[Cycle]);
						NewAttributes[Cycle] = Buffer_char;

						NewAttributes[Cycle][NumberOfNewAttributes[Cycle]] = (char*)malloc((strlen(Str4) + 1) * sizeof(char));
						strcpy(NewAttributes[Cycle][NumberOfNewAttributes[Cycle]], Str4);
						NumberOfNewAttributes[Cycle]++;
					}
				}
			}
			else if ((ch != ' ') && (ch != '\n') && (ch != '\t') && (ch != '\r'))
			{
				Str1[i++] = ch;
				Str1[i] = 0;
			}
		} while ((ch != '\"') && (ch != ',') && ch);
	} while (ch);


	free(Str1);
	free(Str2);
	free(Str3);
	free(Str4);
	return(0);
}


//***************************************************************************************

int ProcessAttribute(char* AttributeText, char*** &NewAttributes, int* &NumberOfNewAttributes, int &NumberOfNewAttributesCycles)
{
	char	ch;
	int		Cycle;
	int		i, j;
	char*	ptr;
	char*	Str1;
	char*	Str2;

	for (Cycle = 0;Cycle < NumberOfNewAttributesCycles;Cycle++)
	{
		for (i = 0;i < NumberOfNewAttributes[Cycle];i++)
			free(NewAttributes[Cycle][i]);
		free(NewAttributes[Cycle]);
	}
	free(NumberOfNewAttributes);
	free(NewAttributes);
	NumberOfNewAttributes = NULL;
	NewAttributes = NULL;
	NumberOfNewAttributesCycles = 0;

	Str1 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));
	Str2 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));

	ptr = strstr(AttributeText, "SILVER");
	if (ptr)
	{
		ptr += strlen("SILVER");

		while ((*ptr == ' ') && (*ptr)) // skipping space ' '
			ptr++;

		if (*ptr == '=')  // the next one must be '='
		{
			ptr++;
			while ((*ptr == ' ') && (*ptr)) // skipping space ' '
				ptr++;

			if (*ptr == '\"')  // the next one must be '"'
			{
				ptr++;
				strcpy(Str1, ptr);

				i = 0;
				while ((Str1[i] != '\"') && (Str1[i]))
					i++;
				Str1[i] = 0;

				j = 0;
				ptr = Str1 - 1;
				do
				{
					ptr++;
					ch = *ptr;

					if (ch == '{')
						j = 0;
					else if ((ch == '}') || (ch == 0))
					{
						if (j)
						{
							if (j != -1)
							{
								Str2[j] = 0;
								ProcessSubAttribute(Str2, NewAttributes, NumberOfNewAttributes, NumberOfNewAttributesCycles);
								j = -1;
							}
						}
						else
						{
							printf("given attribute is not valid: %s\n", AttributeText);
							free(Str1);
							free(Str2);
							return(1);
						}
					}
					else if (ch == ',')
					{
						if (j != -1)
							Str2[j++] = ch;
					}
					else if (ch != ' ')
						Str2[j++] = ch;
				} while (ch);
							   				 			  			  			 
			}
		}
	}

	free(Str1);
	free(Str2);
	return(0);
}

//***************************************************************************************

int ReadDesignFile(char* InputVerilogFileName, char* MainModuleName,
	Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit, unsigned char WithAttributes)
{
	FILE*			DesignFile;
	char			finished;
	char			ReadSignalsFinished;
	int				CellTypeIndex;
	int				CaseIndex;
	char*			Str1 = (char *)malloc(Parser_Max_Name_Length * sizeof(char));
	char*			Str2 = (char *)malloc(Parser_Max_Name_Length * sizeof(char));
	char			ch;
	int				i, j;
	int				MyNumberofIO;
	int				CurrentIO;
	int				InputIndex;
	int				OutputIndex;
	int				SignalIndex;
	int*			Buffer_int;
	int				Index1, Index2, IndexUpwards;
	Parser_SignalStruct**	TempSignals;
	int*			TempInputs;
	int*			TempOutputs;
	Parser_CellStruct**	TempCells;
	int*			TempGates;
	int*			TempRegs;
	char***			NewAttributes = NULL;
	int*			NumberOfNewAttributes = NULL;
	int 			NumberOfNewAttributesCycles = 0;
	int*			NewAttributeIndex = NULL;
	int				TempAttributeIndex;
	char***			InputAttributes = NULL;
	int*			NumberOfInputAttributes = NULL;
	int				NumberOfInputAttributesCycles = 0;
	char***			OutputAttributes = NULL;
	int*			NumberOfOutputAttributes = NULL;
	int				NumberOfOutputAttributesCycles = 0;
	char**			Buffer_char;
	char***			Buffer_char2;
	int				Cycle;

	Circuit->NumberOfSignals = 0;
	Circuit->NumberOfOutputs = 0;
	Circuit->NumberOfInputs = 0;

	char *Phrase		= (char *)malloc(Parser_Max_Name_Length * sizeof(char));
	char *AttributeText = (char *)malloc(Parser_Max_Name_Length * sizeof(char));
	char Task;
	char IO_port_found;

	Circuit->NumberOfCells = 0;
	Circuit->NumberOfGates = 0;
	Circuit->NumberOfRegs = 0;

	// --------- adding 0 and 1 Circuit->Signals --------------

	Circuit->NumberOfSignals = 6;
	Circuit->NumberOfConstants = Circuit->NumberOfSignals;
	Circuit->Signals = (Parser_SignalStruct **)malloc(Circuit->NumberOfSignals * sizeof(Parser_SignalStruct *));

	Circuit->Signals[0] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[0]->Name = (char *)malloc(strlen("1'b0") + 1);
	strcpy(Circuit->Signals[0]->Name, "1'b0");
	Circuit->Signals[0]->Type = Parser_SignalType_wire;
	Circuit->Signals[0]->NumberOfInputs = 0;
	Circuit->Signals[0]->Inputs = NULL;
	Circuit->Signals[0]->Output = -1;
	Circuit->Signals[0]->Depth = 0;
	Circuit->Signals[0]->NumberOfAttributeCycles = 1;
	Circuit->Signals[0]->Attribute = (char**)malloc(1 * sizeof(char*));
	Circuit->Signals[0]->Attribute[0] = (char*)calloc(1, sizeof(char));

	Circuit->Signals[1] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[1]->Name = (char *)malloc(strlen("1'b1") + 1);
	strcpy(Circuit->Signals[1]->Name, "1'b1");
	Circuit->Signals[1]->Type = Parser_SignalType_wire;
	Circuit->Signals[1]->NumberOfInputs = 0;
	Circuit->Signals[1]->Inputs = NULL;
	Circuit->Signals[1]->Output = -1;
	Circuit->Signals[1]->Depth = 0;
	Circuit->Signals[1]->NumberOfAttributeCycles = 1;
	Circuit->Signals[1]->Attribute = (char**)malloc(1 * sizeof(char*));
	Circuit->Signals[1]->Attribute[0] = (char*)calloc(1, sizeof(char));

	Circuit->Signals[2] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[2]->Name = (char *)malloc(strlen("1'h0") + 1);
	strcpy(Circuit->Signals[2]->Name, "1'h0");
	Circuit->Signals[2]->Type = Parser_SignalType_wire;
	Circuit->Signals[2]->NumberOfInputs = 0;
	Circuit->Signals[2]->Inputs = NULL;
	Circuit->Signals[2]->Output = -1;
	Circuit->Signals[2]->Depth = 0;
	Circuit->Signals[2]->NumberOfAttributeCycles = 1;
	Circuit->Signals[2]->Attribute = (char**)malloc(1 * sizeof(char*));
	Circuit->Signals[2]->Attribute[0] = (char*)calloc(1, sizeof(char));

	Circuit->Signals[3] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[3]->Name = (char *)malloc(strlen("1'h1") + 1);
	strcpy(Circuit->Signals[3]->Name, "1'h1");
	Circuit->Signals[3]->Type = Parser_SignalType_wire;
	Circuit->Signals[3]->NumberOfInputs = 0;
	Circuit->Signals[3]->Inputs = NULL;
	Circuit->Signals[3]->Output = -1;
	Circuit->Signals[3]->Depth = 0;
	Circuit->Signals[3]->NumberOfAttributeCycles = 1;
	Circuit->Signals[3]->Attribute = (char**)malloc(1 * sizeof(char*));
	Circuit->Signals[3]->Attribute[0] = (char*)calloc(1, sizeof(char));

	Circuit->Signals[4] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[4]->Name = (char *)malloc(strlen("1'bx") + 1);
	strcpy(Circuit->Signals[4]->Name, "1'bx");
	Circuit->Signals[4]->Type = Parser_SignalType_wire;
	Circuit->Signals[4]->NumberOfInputs = 0;
	Circuit->Signals[4]->Inputs = NULL;
	Circuit->Signals[4]->Output = -1;
	Circuit->Signals[4]->Depth = 0;
	Circuit->Signals[4]->NumberOfAttributeCycles = 1;
	Circuit->Signals[4]->Attribute = (char**)malloc(1 * sizeof(char*));
	Circuit->Signals[4]->Attribute[0] = (char*)calloc(1, sizeof(char));

	Circuit->Signals[5] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[5]->Name = (char *)malloc(strlen("1'hx") + 1);
	strcpy(Circuit->Signals[5]->Name, "1'hx");
	Circuit->Signals[5]->Type = Parser_SignalType_wire;
	Circuit->Signals[5]->NumberOfInputs = 0;
	Circuit->Signals[5]->Inputs = NULL;
	Circuit->Signals[5]->Output = -1;
	Circuit->Signals[5]->Depth = 0;
	Circuit->Signals[5]->NumberOfAttributeCycles = 1;
	Circuit->Signals[5]->Attribute = (char**)malloc(1 * sizeof(char*));
	Circuit->Signals[5]->Attribute[0] = (char*)calloc(1, sizeof(char));

	//---------------------------------------------------------------------------------------------//
	//------------------- reading the Circuit->Signals from the design file --------------------------------//

	DesignFile = fopen(InputVerilogFileName, "rt");

	if (DesignFile == NULL)
	{
		printf("design file ""%s"" not found\n", InputVerilogFileName);
		free(Str1);
		free(Str2);
		free(Phrase);
		free(AttributeText);
		return 1;
	}

	finished = 0;
	ReadSignalsFinished = 0;

	do {
		do {
			fReadaWord(DesignFile, Str1, NULL);
		} while ((!feof(DesignFile)) && strcmp(Str1, "module"));

		if (!feof(DesignFile))
		{
			fReadaWord(DesignFile, Str1, NULL);
			if (strcmp(Str1, MainModuleName))
			{
				do {
					fReadaWord(DesignFile, Str1, NULL);
				} while ((!feof(DesignFile)) && strcmp(Str1, "endmodule"));
			}
			else
			{
				do {
					fReadaWord(DesignFile, Str1, NULL);
					ch = Str1[strlen(Str1) - 1];
				} while ((ch != ';') && (!feof(DesignFile)));  // ignoring the entire list of input/output ports

				while ((!ReadSignalsFinished) && (!feof(DesignFile)))
				{
					fReadaWord(DesignFile, Str1, AttributeText);

					if ((!strcmp(Str1, "input")) || (!strcmp(Str1, "output")) || (!strcmp(Str1, "wire")))
					{
						if (ProcessAttribute(AttributeText, NewAttributes, NumberOfNewAttributes, NumberOfNewAttributesCycles))
						{
							printf("processing the attribute %s failed\n", AttributeText);
							fclose(DesignFile);
							free(Str1);
							free(Str2);
							free(Phrase);
							free(AttributeText);
							return 1;
						}

						strcpy(Phrase, Str1);
						i = 0;
						Index1 = -1;
						Index2 = -1;

						do {
							ch = fgetc(DesignFile);

							if ((ch == '[') && (!i))
							{
								// do nothing
							}
							else if (ch == ':')
							{
								Index1 = atoi(Str1);
								i = 0;
							}
							else if ((ch == ']') && (Str1[0] != '\\'))
							{
								Index2 = atoi(Str1);
								i = 0;
							}
							else if ((ch == ',') || (ch == ';'))
							{
								free(NewAttributeIndex);
								NewAttributeIndex = (int*)calloc(NumberOfNewAttributesCycles, sizeof(int));

								IndexUpwards = (Index1 < Index2) ? 1 : -1;

								for (j = Index1;((IndexUpwards == 1) && (j <= Index2)) || ((IndexUpwards == -1) && (j >= Index2)); j += IndexUpwards)
								{
									if (Index1 != -1)
										sprintf(Str2, "%s[%d]", Str1, j);
									else
										sprintf(Str2, "%s", Str1);

									TempSignals = (Parser_SignalStruct **)malloc((Circuit->NumberOfSignals + 1) * sizeof(Parser_SignalStruct *));
									memcpy(TempSignals, Circuit->Signals, Circuit->NumberOfSignals * sizeof(Parser_SignalStruct *));
									free(Circuit->Signals);
									Circuit->Signals = TempSignals;

									Circuit->Signals[Circuit->NumberOfSignals] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
									Circuit->Signals[Circuit->NumberOfSignals]->Name = (char *)malloc(strlen(Str2) + 1);
									strcpy(Circuit->Signals[Circuit->NumberOfSignals]->Name, Str2);
									Circuit->Signals[Circuit->NumberOfSignals]->NumberOfInputs = 0;
									Circuit->Signals[Circuit->NumberOfSignals]->Inputs = NULL;
									Circuit->Signals[Circuit->NumberOfSignals]->Output = -1;
									Circuit->Signals[Circuit->NumberOfSignals]->Deleted = 0;
									Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles = 0;
									Circuit->Signals[Circuit->NumberOfSignals]->Attribute = NULL;

									if (!strcmp(Phrase, "input"))
									{
										Circuit->Signals[Circuit->NumberOfSignals]->Type = Parser_SignalType_input;
										Circuit->Signals[Circuit->NumberOfSignals]->Depth = 0;

										TempInputs = (int *)malloc((Circuit->NumberOfInputs + 1) * sizeof(int));
										memcpy(TempInputs, Circuit->Inputs, Circuit->NumberOfInputs * sizeof(int));
										free(Circuit->Inputs);
										Circuit->Inputs = TempInputs;

										Circuit->Inputs[Circuit->NumberOfInputs] = Circuit->NumberOfSignals;
										Circuit->NumberOfInputs++;

										for (Cycle = 0;Cycle < NumberOfNewAttributesCycles;Cycle++)
										{
											if (NewAttributeIndex[Cycle] < NumberOfNewAttributes[Cycle])
											{
												if (Cycle < NumberOfInputAttributesCycles)
												{
													for (TempAttributeIndex = 0;TempAttributeIndex < NumberOfInputAttributes[Cycle];TempAttributeIndex++)
														if (!strcmp(InputAttributes[Cycle][TempAttributeIndex], NewAttributes[Cycle][NewAttributeIndex[Cycle]]))
															break;

													if (TempAttributeIndex < NumberOfInputAttributes[Cycle])
													{
														printf("douplicat attribute %s found for input %s in cycle %d\n", NewAttributes[Cycle][NewAttributeIndex[Cycle]], Str2, Cycle);
														fclose(DesignFile);
														free(Str1);
														free(Str2);
														free(Phrase);
														free(AttributeText);
														return 1;
													}
												}

												while (Cycle >= Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles)
												{
													Buffer_char = (char**)malloc((Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles + 1) * sizeof(char*));
													memcpy(Buffer_char, Circuit->Signals[Circuit->NumberOfSignals]->Attribute, Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles * sizeof(char*));
													free(Circuit->Signals[Circuit->NumberOfSignals]->Attribute);
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute = Buffer_char;
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles] = NULL;
													Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles++;
												}
														
												Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Cycle] = (char*)malloc((strlen(NewAttributes[Cycle][NewAttributeIndex[Cycle]]) + 1) * sizeof(char));
												strcpy(Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Cycle], NewAttributes[Cycle][NewAttributeIndex[Cycle]]);

												if ((strstr(NewAttributes[Cycle][NewAttributeIndex[Cycle]], "ref") != NewAttributes[Cycle][NewAttributeIndex[Cycle]]) && // add it to the list if it is not refresh nor control nor clock
													strcmp(NewAttributes[Cycle][NewAttributeIndex[Cycle]], "con") &&
													strcmp(NewAttributes[Cycle][NewAttributeIndex[Cycle]], "clk"))
												{

													while (Cycle >= NumberOfInputAttributesCycles)
													{
														Buffer_char2 = (char***)malloc((NumberOfInputAttributesCycles + 1) * sizeof(char**));
														memcpy(Buffer_char2, InputAttributes, NumberOfInputAttributesCycles * sizeof(char**));
														free(InputAttributes);
														InputAttributes = Buffer_char2;
														InputAttributes[NumberOfInputAttributesCycles] = NULL;

														Buffer_int = (int*)malloc((NumberOfInputAttributesCycles + 1) * sizeof(int));
														memcpy(Buffer_int, NumberOfInputAttributes, NumberOfInputAttributesCycles * sizeof(int));
														free(NumberOfInputAttributes);
														NumberOfInputAttributes = Buffer_int;
														NumberOfInputAttributes[NumberOfInputAttributesCycles] = 0;

														NumberOfInputAttributesCycles++;
													}

													Buffer_char = (char**)malloc((NumberOfInputAttributes[Cycle] +1) * sizeof(char*));
													memcpy(Buffer_char, InputAttributes[Cycle], NumberOfInputAttributes[Cycle] * sizeof(char*));
													free(InputAttributes[Cycle]);
													InputAttributes[Cycle] = Buffer_char;

													InputAttributes[Cycle][NumberOfInputAttributes[Cycle]] = (char*)malloc((strlen(NewAttributes[Cycle][NewAttributeIndex[Cycle]]) + 1) * sizeof(char));
													strcpy(InputAttributes[Cycle][NumberOfInputAttributes[Cycle]], NewAttributes[Cycle][NewAttributeIndex[Cycle]]);
													NumberOfInputAttributes[Cycle]++;
													NewAttributeIndex[Cycle]++;
												}
											}
											else if (!WithAttributes)
											{
												while (Cycle >= Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles)
												{
													Buffer_char = (char**)malloc((Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles + 1) * sizeof(char*));
													memcpy(Buffer_char, Circuit->Signals[Circuit->NumberOfSignals]->Attribute, Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles * sizeof(char*));
													free(Circuit->Signals[Circuit->NumberOfSignals]->Attribute);
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute = Buffer_char;
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles] = NULL;
													Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles++;
												}

												Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Cycle] = (char*)calloc(1, sizeof(char));
											}
											else
											{
												printf("attribute of input %s in cycle %d not given\n", Str2, Cycle);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(AttributeText);
												return 1;
											}
										}

										if (!NumberOfNewAttributesCycles)
										{
											Cycle = 0;

											if (!WithAttributes)
											{
												while (Cycle >= Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles)
												{
													Buffer_char = (char**)malloc((Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles + 1) * sizeof(char*));
													memcpy(Buffer_char, Circuit->Signals[Circuit->NumberOfSignals]->Attribute, Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles * sizeof(char*));
													free(Circuit->Signals[Circuit->NumberOfSignals]->Attribute);
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute = Buffer_char;
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles] = NULL;
													Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles++;
												}

												Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Cycle] = (char*)calloc(1, sizeof(char));
											}
											else
											{
												printf("attribute of input %s in cycle %d not given\n", Str2, Cycle);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(AttributeText);
												return 1;
											}
										}
									}
									else if (!strcmp(Phrase, "output"))
									{
										Circuit->Signals[Circuit->NumberOfSignals]->Type = Parser_SignalType_output;
										Circuit->Signals[Circuit->NumberOfSignals]->Depth = -1;

										TempOutputs = (int *)malloc((Circuit->NumberOfOutputs + 1) * sizeof(int));
										memcpy(TempOutputs, Circuit->Outputs, Circuit->NumberOfOutputs * sizeof(int));
										free(Circuit->Outputs);
										Circuit->Outputs = TempOutputs;

										Circuit->Outputs[Circuit->NumberOfOutputs] = Circuit->NumberOfSignals;
										Circuit->NumberOfOutputs++;
																			   										 									  
										for (Cycle = 0;Cycle < NumberOfNewAttributesCycles;Cycle++)
										{
											if (NewAttributeIndex[Cycle] < NumberOfNewAttributes[Cycle])
											{
												if (Cycle < NumberOfOutputAttributesCycles)
												{
													for (TempAttributeIndex = 0;TempAttributeIndex < NumberOfOutputAttributes[Cycle];TempAttributeIndex++)
														if (!strcmp(OutputAttributes[Cycle][TempAttributeIndex], NewAttributes[Cycle][NewAttributeIndex[Cycle]]))
															break;

													if (TempAttributeIndex < NumberOfOutputAttributes[Cycle])
													{
														printf("douplicat attribute %s found for output %s in cycle %d\n", NewAttributes[Cycle][NewAttributeIndex[Cycle]], Str2, Cycle);
														fclose(DesignFile);
														free(Str1);
														free(Str2);
														free(Phrase);
														free(AttributeText);
														return 1;
													}
												}

												while (Cycle >= Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles)
												{
													Buffer_char = (char**)malloc((Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles + 1) * sizeof(char*));
													memcpy(Buffer_char, Circuit->Signals[Circuit->NumberOfSignals]->Attribute, Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles * sizeof(char*));
													free(Circuit->Signals[Circuit->NumberOfSignals]->Attribute);
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute = Buffer_char;
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles] = NULL;
													Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles++;
												}

												Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Cycle] = (char*)malloc((strlen(NewAttributes[Cycle][NewAttributeIndex[Cycle]]) + 1) * sizeof(char));
												strcpy(Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Cycle], NewAttributes[Cycle][NewAttributeIndex[Cycle]]);

												if ((strstr(NewAttributes[Cycle][NewAttributeIndex[Cycle]], "ref") != NewAttributes[Cycle][NewAttributeIndex[Cycle]]) && // add it to the list if it is not refresh nor control nor clock
													strcmp(NewAttributes[Cycle][NewAttributeIndex[Cycle]], "con") &&
													strcmp(NewAttributes[Cycle][NewAttributeIndex[Cycle]], "clk"))
												{

													while (Cycle >= NumberOfOutputAttributesCycles)
													{
														Buffer_char2 = (char***)malloc((NumberOfOutputAttributesCycles + 1) * sizeof(char**));
														memcpy(Buffer_char2, OutputAttributes, NumberOfOutputAttributesCycles * sizeof(char**));
														free(OutputAttributes);
														OutputAttributes = Buffer_char2;
														OutputAttributes[NumberOfOutputAttributesCycles] = NULL;

														Buffer_int = (int*)malloc((NumberOfOutputAttributesCycles + 1) * sizeof(int));
														memcpy(Buffer_int, NumberOfOutputAttributes, NumberOfOutputAttributesCycles * sizeof(int));
														free(NumberOfOutputAttributes);
														NumberOfOutputAttributes = Buffer_int;
														NumberOfOutputAttributes[NumberOfOutputAttributesCycles] = 0;

														NumberOfOutputAttributesCycles++;
													}

													Buffer_char = (char**)malloc((NumberOfOutputAttributes[Cycle] + 1) * sizeof(char*));
													memcpy(Buffer_char, OutputAttributes[Cycle], NumberOfOutputAttributes[Cycle] * sizeof(char*));
													free(OutputAttributes[Cycle]);
													OutputAttributes[Cycle] = Buffer_char;

													OutputAttributes[Cycle][NumberOfOutputAttributes[Cycle]] = (char*)malloc((strlen(NewAttributes[Cycle][NewAttributeIndex[Cycle]]) + 1) * sizeof(char));
													strcpy(OutputAttributes[Cycle][NumberOfOutputAttributes[Cycle]], NewAttributes[Cycle][NewAttributeIndex[Cycle]]);
													NumberOfOutputAttributes[Cycle]++;
													NewAttributeIndex[Cycle]++;
												}
											}
											else if (!WithAttributes)
											{
												while (Cycle >= Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles)
												{
													Buffer_char = (char**)malloc((Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles + 1) * sizeof(char*));
													memcpy(Buffer_char, Circuit->Signals[Circuit->NumberOfSignals]->Attribute, Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles * sizeof(char*));
													free(Circuit->Signals[Circuit->NumberOfSignals]->Attribute);
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute = Buffer_char;
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles] = NULL;
													Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles++;
												}

												Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Cycle] = (char*)calloc(1, sizeof(char));
											}
											else
											{
												printf("attribute of output %s in cycle %d not given\n", Str2, Cycle);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(AttributeText);
												return 1;
											}
										}

										if (!NumberOfNewAttributesCycles)
										{
											Cycle = 0;

											if (!WithAttributes)
											{
												while (Cycle >= Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles)
												{
													Buffer_char = (char**)malloc((Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles + 1) * sizeof(char*));
													memcpy(Buffer_char, Circuit->Signals[Circuit->NumberOfSignals]->Attribute, Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles * sizeof(char*));
													free(Circuit->Signals[Circuit->NumberOfSignals]->Attribute);
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute = Buffer_char;
													Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles] = NULL;
													Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles++;
												}

												Circuit->Signals[Circuit->NumberOfSignals]->Attribute[Cycle] = (char*)calloc(1, sizeof(char));
											}
											else
											{
												printf("attribute of output %s in cycle %d not given\n", Str2, Cycle);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(AttributeText);
												return 1;
											}
										}

									}
									else  // if (!strcmp(Phrase, "wire"))
									{
										Circuit->Signals[Circuit->NumberOfSignals]->Type = Parser_SignalType_wire;
										Circuit->Signals[Circuit->NumberOfSignals]->Depth = -1;

										Circuit->Signals[Circuit->NumberOfSignals]->NumberOfAttributeCycles = 1;
										Circuit->Signals[Circuit->NumberOfSignals]->Attribute = (char**)malloc(1 * sizeof(char*));
										Circuit->Signals[Circuit->NumberOfSignals]->Attribute[0] = (char*)calloc(1, sizeof(char));
									}

									Circuit->NumberOfSignals++;
								}

								i = 0;
							}
							else if ((ch != ' ') && (ch != '\n') && (ch != '\t') && (ch != '\r'))
							{
								Str1[i++] = ch;
								Str1[i] = 0;
							}
						} while ((ch != ';') && (!feof(DesignFile)));
					}
					else
						ReadSignalsFinished = 1;
				}

				//---------------------------------------------------------------------------------------------//
				//------------------- reading the Circuit->Cells from the design file ----------------------------------//

				if (!feof(DesignFile))
				{
					strcpy(Str2, Str1);

					do {
						fReadaWord(DesignFile, Str1, NULL);
						if (Str1[0] != '[')
							strcat(Str2, " ");
						strcat(Str2, Str1);

						if (Str1[strlen(Str1) - 1] == ';')
						{
							i = 0;
							j = 0;
							Str1[0] = 0;
							Task = Parser_Task_find_module_type;

							do {
								ch = Str2[i++];

								if (ch == ' ')
								{
									if (j)
									{
										if (Task == Parser_Task_find_module_type)
										{
											for (CellTypeIndex = 0;CellTypeIndex < Library->NumberOfCellTypes;CellTypeIndex++)
											{
												for (CaseIndex = 0;CaseIndex < Library->CellTypes[CellTypeIndex]->NumberOfCases;CaseIndex++)
													if (!strcmp(Str1, Library->CellTypes[CellTypeIndex]->Cases[CaseIndex]))
														break;

												if (CaseIndex < Library->CellTypes[CellTypeIndex]->NumberOfCases)
													break;
											}

											if (CellTypeIndex < Library->NumberOfCellTypes)
											{
												TempCells = (Parser_CellStruct **)malloc((Circuit->NumberOfCells + 1) * sizeof(Parser_CellStruct *));
												memcpy(TempCells, Circuit->Cells, Circuit->NumberOfCells * sizeof(Parser_CellStruct *));
												free(Circuit->Cells);
												Circuit->Cells = TempCells;

												Circuit->Cells[Circuit->NumberOfCells] = (Parser_CellStruct *)malloc(sizeof(Parser_CellStruct));
												Circuit->Cells[Circuit->NumberOfCells]->Type = CellTypeIndex;
												Circuit->Cells[Circuit->NumberOfCells]->NumberOfInputs = Library->CellTypes[CellTypeIndex]->NumberOfInputs;
												Circuit->Cells[Circuit->NumberOfCells]->Inputs = (int *)malloc(Library->CellTypes[CellTypeIndex]->NumberOfInputs * sizeof(int));
												Circuit->Cells[Circuit->NumberOfCells]->NumberOfOutputs = Library->CellTypes[CellTypeIndex]->NumberOfOutputs;
												Circuit->Cells[Circuit->NumberOfCells]->Outputs = (int *)malloc(Library->CellTypes[CellTypeIndex]->NumberOfOutputs * sizeof(int));
												Circuit->Cells[Circuit->NumberOfCells]->Deleted = 0;

												if (Library->CellTypes[CellTypeIndex]->GateOrReg == Parser_CellType_Gate)
												{
													Circuit->Cells[Circuit->NumberOfCells]->Depth = -1;
													TempGates = (int *)malloc((Circuit->NumberOfGates + 1) * sizeof(int));
													memcpy(TempGates, Circuit->Gates, Circuit->NumberOfGates * sizeof(int));
													free(Circuit->Gates);
													Circuit->Gates = TempGates;

													Circuit->Gates[Circuit->NumberOfGates] = Circuit->NumberOfCells;
													Circuit->NumberOfGates++;
												}
												else // Parser_CellType_Reg
												{
													Circuit->Cells[Circuit->NumberOfCells]->Depth = -1;
													TempRegs = (int *)malloc((Circuit->NumberOfRegs + 1) * sizeof(int));
													memcpy(TempRegs, Circuit->Regs, Circuit->NumberOfRegs * sizeof(int));
													free(Circuit->Regs);
													Circuit->Regs = TempRegs;

													Circuit->Regs[Circuit->NumberOfRegs] = Circuit->NumberOfCells;
													Circuit->NumberOfRegs++;
												}

												Task = Parser_Task_find_module_name;
												MyNumberofIO = Library->CellTypes[CellTypeIndex]->NumberOfInputs + Library->CellTypes[CellTypeIndex]->NumberOfOutputs;
												CurrentIO = 0;
											}
											else
											{
												printf("cell type ""%s"" not found\n", Str1);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(AttributeText);
												return 1;
											}
										}
										else if (Task == Parser_Task_find_module_name)
										{
											Circuit->Cells[Circuit->NumberOfCells]->Name = (char *)malloc(strlen(Str1) + 1);
											strcpy(Circuit->Cells[Circuit->NumberOfCells]->Name, Str1);

											Task = Parser_Task_find_open_bracket;
											IO_port_found = 0;
										}
										else if (Task == Parser_Task_find_IO_port)
										{
											if (Str1[0] == '.')
											{
												for (InputIndex = 0;InputIndex < Library->CellTypes[CellTypeIndex]->NumberOfInputs;InputIndex++)
												{
													if (!strcmp(Str1 + 1, Library->CellTypes[CellTypeIndex]->Inputs[InputIndex]))
														break;
												}

												if (InputIndex >= Library->CellTypes[CellTypeIndex]->NumberOfInputs) // the IO port NOT found in the Circuit->Inputs
												{
													for (OutputIndex = 0;OutputIndex < Library->CellTypes[CellTypeIndex]->NumberOfOutputs;OutputIndex++)
													{
														if (!strcmp(Str1 + 1, Library->CellTypes[CellTypeIndex]->Outputs[OutputIndex]))
															break;
													}

													if (OutputIndex >= Library->CellTypes[CellTypeIndex]->NumberOfOutputs) // the IO port NOT found in the Circuit->Outputs
													{
														printf("IO port ""%s"" not found in cell type ""%s""\n", Str1 + 1, Library->CellTypes[CellTypeIndex]->Cases[CaseIndex]);
														fclose(DesignFile);
														free(Str1);
														free(Str2);
														free(Phrase);
														free(AttributeText);
														return 1;
													}

													InputIndex = -1;
												}

												IO_port_found = 1;
												Task = Parser_Task_find_open_bracket;
											}
											else
											{
												printf("error in reading the netlist, '.' is expected in %s\n", Str1);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(AttributeText);
												return 1;
											}
										}
										else if (Task == Parser_Task_find_signal_name)
										{
											if (strlen(Str1))
											{
												for (SignalIndex = 0;SignalIndex < Circuit->NumberOfSignals;SignalIndex++)
												{
													if (!strcmp(Str1, Circuit->Signals[SignalIndex]->Name))
														break;
												}
											}
											else
												SignalIndex = -1;

											if (SignalIndex < Circuit->NumberOfSignals)
											{
												if (InputIndex != -1)
												{
													Circuit->Cells[Circuit->NumberOfCells]->Inputs[InputIndex] = SignalIndex;

													Buffer_int = (int *)malloc((Circuit->Signals[SignalIndex]->NumberOfInputs + 1) * sizeof(int));
													memcpy(Buffer_int, Circuit->Signals[SignalIndex]->Inputs, Circuit->Signals[SignalIndex]->NumberOfInputs * sizeof(int));
													free(Circuit->Signals[SignalIndex]->Inputs);
													Circuit->Signals[SignalIndex]->Inputs = Buffer_int;

													Circuit->Signals[SignalIndex]->Inputs[Circuit->Signals[SignalIndex]->NumberOfInputs] = Circuit->NumberOfCells;
													Circuit->Signals[SignalIndex]->NumberOfInputs++;
												}
												else
												{
													Circuit->Cells[Circuit->NumberOfCells]->Outputs[OutputIndex] = SignalIndex;
													if (SignalIndex != -1)
														Circuit->Signals[SignalIndex]->Output = Circuit->NumberOfCells;
												}
											}
											else
											{
												printf("signal ""%s"" not found\n", Str1);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(AttributeText);
												return 1;
											}

											CurrentIO++;
											Task = Parser_Task_find_close_bracket;
										}

										j = 0;
										Str1[0] = 0;
									}
								}
								else if (ch == '(')
								{
									if (Task == Parser_Task_find_open_bracket)
									{
										if (IO_port_found)
											Task = Parser_Task_find_signal_name;
										else
											Task = Parser_Task_find_IO_port;
									}
									else if (Task == Parser_Task_find_IO_port)
									{
										if (Str1[0] == '.')
										{
											for (InputIndex = 0;InputIndex < Library->CellTypes[CellTypeIndex]->NumberOfInputs;InputIndex++)
											{
												if (!strcmp(Str1 + 1, Library->CellTypes[CellTypeIndex]->Inputs[InputIndex]))
													break;
											}

											if (InputIndex >= Library->CellTypes[CellTypeIndex]->NumberOfInputs) // the IO port NOT found in the Circuit->Inputs
											{
												for (OutputIndex = 0;OutputIndex < Library->CellTypes[CellTypeIndex]->NumberOfOutputs;OutputIndex++)
												{
													if (!strcmp(Str1 + 1, Library->CellTypes[CellTypeIndex]->Outputs[OutputIndex]))
														break;
												}

												if (OutputIndex >= Library->CellTypes[CellTypeIndex]->NumberOfOutputs) // the IO port NOT found in the Circuit->Outputs
												{
													printf("IO port ""%s"" did not found in cell type ""%s""\n", Str1 + 1, Library->CellTypes[CellTypeIndex]->Cases[0]);
													fclose(DesignFile);
													free(Str1);
													free(Str2);
													free(Phrase);
													free(AttributeText);
													return 1;
												}

												InputIndex = -1;
											}

											Task = Parser_Task_find_signal_name;
										}
										else
										{
											printf("error in reading the netlist, '.' is expected in %s\n", Str1);
											fclose(DesignFile);
											free(Str1);
											free(Str2);
											free(Phrase);
											free(AttributeText);
											return 1;
										}
									}
									else
									{
										printf("Error!\n");
										fclose(DesignFile);
										free(Str1);
										free(Str2);
										free(Phrase);
										free(AttributeText);
										return 1;
									}

									j = 0;
									Str1[0] = 0;
								}
								else if (ch == ')')
								{
									if (Task == Parser_Task_find_close_bracket)
									{
										if (CurrentIO < MyNumberofIO)
											Task = Parser_Task_find_comma;
									}
									else if (Task == Parser_Task_find_signal_name)
									{
										if (strlen(Str1))
										{
											for (SignalIndex = 0;SignalIndex < Circuit->NumberOfSignals;SignalIndex++)
											{
												if (!strcmp(Str1, Circuit->Signals[SignalIndex]->Name))
													break;
											}
										}
										else
											SignalIndex = -1;

										if (SignalIndex < Circuit->NumberOfSignals)
										{
											if (InputIndex != -1)
											{
												Circuit->Cells[Circuit->NumberOfCells]->Inputs[InputIndex] = SignalIndex;

												Buffer_int = (int *)malloc((Circuit->Signals[SignalIndex]->NumberOfInputs + 1) * sizeof(int));
												memcpy(Buffer_int, Circuit->Signals[SignalIndex]->Inputs, Circuit->Signals[SignalIndex]->NumberOfInputs * sizeof(int));
												free(Circuit->Signals[SignalIndex]->Inputs);
												Circuit->Signals[SignalIndex]->Inputs = Buffer_int;

												Circuit->Signals[SignalIndex]->Inputs[Circuit->Signals[SignalIndex]->NumberOfInputs] = Circuit->NumberOfCells;
												Circuit->Signals[SignalIndex]->NumberOfInputs++;
											}
											else
											{
												Circuit->Cells[Circuit->NumberOfCells]->Outputs[OutputIndex] = SignalIndex;
												if (SignalIndex != -1)
													Circuit->Signals[SignalIndex]->Output = Circuit->NumberOfCells;
											}
										}
										else
										{
											printf("signal ""%s"" not found\n", Str1);
											fclose(DesignFile);
											free(Str1);
											free(Str2);
											free(Phrase);
											free(AttributeText);
											return 1;
										}

										CurrentIO++;
										if (CurrentIO < MyNumberofIO)
											Task = Parser_Task_find_comma;
										else
											Task = Parser_Task_find_close_bracket;
									}
									else
									{
										printf("Error!\n");
										fclose(DesignFile);
										free(Str1);
										free(Str2);
										free(Phrase);
										free(AttributeText);
										return 1;
									}

									j = 0;
									Str1[0] = 0;
								}
								else if (ch == ',')
								{
									IO_port_found = 0;
									Task = Parser_Task_find_IO_port;

									j = 0;
									Str1[0] = 0;
								}
								else
								{
									Str1[j++] = ch;
									Str1[j] = 0;
								}

							} while (ch != ';');

							Circuit->NumberOfCells++;

							Str1[0] = 0;
							Str2[0] = 0;
						}

					} while (strcmp(Str1, "endmodule") && (!feof(DesignFile)));

					finished = 1;
				}
			}
		}
	} while ((!feof(DesignFile)) && (!finished));

	fclose(DesignFile);
	free(Str1);
	free(Str2);
	free(Phrase);
	free(AttributeText);

	if (!finished)
	{
		printf("The target module %s not found\n", MainModuleName);
		return 1;
	}

	return 0;
}

//***************************************************************************************

int RemoveBuffer(int CellIndex, Parser_CircuitStruct* Circuit)
{
	int   InputSignal;
	int   TempIndex;
	int   NumberOfRerouted;
	int   OutputSignal;
	int   InputIndex;
	int	  *TempInputs;
	int   OriginCellIndex;
	int   OutputIndex;

	InputSignal = Circuit->Cells[CellIndex]->Inputs[0];
	OutputSignal = Circuit->Cells[CellIndex]->Outputs[0];
	if (((Circuit->Signals[InputSignal]->Type == Parser_SignalType_input) |
		(Circuit->Signals[InputSignal]->Type == Parser_SignalType_output)) &
		(Circuit->Signals[OutputSignal]->Type == Parser_SignalType_output))
		return (-1);   // cannot be removed

	OriginCellIndex = Circuit->Signals[InputSignal]->Output;
	if (OriginCellIndex >= 0)
		for (OutputIndex = 0;OutputIndex < Circuit->Cells[OriginCellIndex]->NumberOfOutputs;OutputIndex++)
			if (Circuit->Cells[OriginCellIndex]->Outputs[OutputIndex] == InputSignal)
				break;

	for (InputIndex = 0;InputIndex < Circuit->Signals[InputSignal]->NumberOfInputs;InputIndex++)
		if (Circuit->Signals[InputSignal]->Inputs[InputIndex] == CellIndex)
		{
			memcpy(&Circuit->Signals[InputSignal]->Inputs[InputIndex], &Circuit->Signals[InputSignal]->Inputs[InputIndex + 1], (Circuit->Signals[InputSignal]->NumberOfInputs - InputIndex - 1) * sizeof(int));
			Circuit->Signals[InputSignal]->NumberOfInputs--;
			break;
		}

	if (Circuit->Signals[OutputSignal]->Type == Parser_SignalType_output)
	{
		TempIndex = InputSignal;
		InputSignal = OutputSignal;
		OutputSignal = TempIndex;
	}

	TempInputs = (int *)malloc((Circuit->Signals[InputSignal]->NumberOfInputs + Circuit->Signals[OutputSignal]->NumberOfInputs) * sizeof(int));
	memcpy(TempInputs, Circuit->Signals[InputSignal]->Inputs, Circuit->Signals[InputSignal]->NumberOfInputs * sizeof(int));
	free(Circuit->Signals[InputSignal]->Inputs);
	Circuit->Signals[InputSignal]->Inputs = TempInputs;
	memcpy(&Circuit->Signals[InputSignal]->Inputs[Circuit->Signals[InputSignal]->NumberOfInputs], Circuit->Signals[OutputSignal]->Inputs, Circuit->Signals[OutputSignal]->NumberOfInputs * sizeof(int));
	Circuit->Signals[InputSignal]->NumberOfInputs += Circuit->Signals[OutputSignal]->NumberOfInputs;

	NumberOfRerouted = 0;
	for (InputIndex = 0;InputIndex < Circuit->Signals[OutputSignal]->NumberOfInputs;InputIndex++)
		for (TempIndex = 0;TempIndex < Circuit->Cells[Circuit->Signals[OutputSignal]->Inputs[InputIndex]]->NumberOfInputs;TempIndex++)
			if (Circuit->Cells[Circuit->Signals[OutputSignal]->Inputs[InputIndex]]->Inputs[TempIndex] == OutputSignal)
			{
				Circuit->Cells[Circuit->Signals[OutputSignal]->Inputs[InputIndex]]->Inputs[TempIndex] = InputSignal;
				NumberOfRerouted++;
			}

	Circuit->Signals[InputSignal]->Output = OriginCellIndex;
	if (OriginCellIndex >= 0)
		Circuit->Cells[OriginCellIndex]->Outputs[OutputIndex] = InputSignal;
	free(Circuit->Signals[OutputSignal]->Inputs);
	Circuit->Cells[CellIndex]->Deleted = 1; //
	Circuit->Signals[OutputSignal]->Deleted = 1;

	return(NumberOfRerouted);
}

//***************************************************************************************

int RemoveUnconnectedCells(Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit)
{
	int   CellIndex;
	int	  InputIndex;
	int	  OutputIndex;
	int	  NumberOfRemoved;
	int   NewRemoved;

	NumberOfRemoved = 0;

	do
	{
		NewRemoved = 0;
		for (CellIndex = 0;CellIndex < Circuit->NumberOfCells;CellIndex++)
			if (!Circuit->Cells[CellIndex]->Deleted)
			{
				for (InputIndex = 0;InputIndex < Circuit->Cells[CellIndex]->NumberOfInputs;InputIndex++)
					if ((!Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Deleted) &&
						((strcmp(Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Attribute[0], "clk") &&
							strcmp(Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Attribute[0], "con")) ||
							(Library->CellTypes[Circuit->Cells[CellIndex]->Type]->GateOrReg == Parser_CellType_Gate)) &&
							((Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Output != -1) ||
						(Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Type == Parser_SignalType_input)))
						break;

				if (InputIndex == Circuit->Cells[CellIndex]->NumberOfInputs) // all inputs of the cell (except clock) are unconnected
				{
					Circuit->Cells[CellIndex]->Deleted = 1;

					for (InputIndex = 0;InputIndex < Circuit->Cells[CellIndex]->NumberOfInputs;InputIndex++)
						if ((!Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->NumberOfAttributeCycles) ||
							(strcmp(Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Attribute[0], "clk") &&
							 strcmp(Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Attribute[0], "con")))
							Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Deleted = 1;

					for (OutputIndex = 0;OutputIndex < Circuit->Cells[CellIndex]->NumberOfOutputs;OutputIndex++)
						if (Circuit->Cells[CellIndex]->Outputs[OutputIndex] != -1)
							Circuit->Signals[Circuit->Cells[CellIndex]->Outputs[OutputIndex]]->Deleted = 1;

					NumberOfRemoved++;
					NewRemoved = 1;
				}
			}
	} while (NewRemoved);

	printf("%d unconnected cell(s) removed\n", NumberOfRemoved);

	return 0;
}

//***************************************************************************************

int RemoveAllBuffers(Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit)
{
	int   GateIndex;
	int	  NumberOfRemoved;
	int	  NumberOfRerouted;

	NumberOfRemoved = 0;
	NumberOfRerouted = 0;
	for (GateIndex = 0;GateIndex < Circuit->NumberOfGates;GateIndex++)
		if (!Circuit->Cells[Circuit->Gates[GateIndex]]->Deleted)
			if (Library->CellTypes[Circuit->Cells[Circuit->Gates[GateIndex]]->Type]->Type & Parser_CellType_Type_Buffer)
			{
				NumberOfRerouted += RemoveBuffer(Circuit->Gates[GateIndex], Circuit);
				NumberOfRemoved++;
			}

	printf("%d Buffer(s) removed and %d signal(s) rerouted\n", NumberOfRemoved, NumberOfRerouted);

	return 0;
}

//***************************************************************************************

int RemoveCellFromSignalInputList(Parser_CircuitStruct* Circuit, int SignalIndex, int InputIndex, int CellIndex)
{
	if (InputIndex < 0)
	{
		for (InputIndex = 0;InputIndex < Circuit->Signals[SignalIndex]->NumberOfInputs;InputIndex++)
			if (Circuit->Signals[SignalIndex]->Inputs[InputIndex] == CellIndex)
				break;
	}

	if (InputIndex < Circuit->Signals[SignalIndex]->NumberOfInputs)
	{
		memcpy(&Circuit->Signals[SignalIndex]->Inputs[InputIndex], &Circuit->Signals[SignalIndex]->Inputs[InputIndex + 1], (Circuit->Signals[SignalIndex]->NumberOfInputs - InputIndex - 1) * sizeof(int));
		Circuit->Signals[SignalIndex]->NumberOfInputs--;
	}

	return(Circuit->Signals[SignalIndex]->NumberOfInputs);
}

//***************************************************************************************

int MakeCircuitDepth(Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit)
{
	int		i;
	int		InputIndex;
	int		OutputIndex;
	int		SignalIndex;
	int		GateIndex;
	int		CellIndex;
	int		TempIndex;
	short	DepthIndex;
	char	OneChanged;
	int     SignalIndex0;
	int     SignalIndex1;
	int     SignalIndex2;
	int		TypeIndex;
	int		BufferTypeIndex = -1;
	int*	TempBuffer;
	int		Cycle;

	do {
		DepthIndex = 0;
		do {
			OneChanged = 0;

			for (SignalIndex = 0;SignalIndex < Circuit->NumberOfSignals;SignalIndex++)
			{
				if ((!Circuit->Signals[SignalIndex]->Deleted) &&
					(Circuit->Signals[SignalIndex]->Depth == DepthIndex))
				{
					for (InputIndex = 0;InputIndex < Circuit->Signals[SignalIndex]->NumberOfInputs;InputIndex++)
					{
						CellIndex = Circuit->Signals[SignalIndex]->Inputs[InputIndex];

						for (i = 0;i < Circuit->Cells[CellIndex]->NumberOfInputs;i++)
							if (Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[i]]->Depth == -1)
								break;

						if (i >= Circuit->Cells[CellIndex]->NumberOfInputs) // all have depth
						{
							Circuit->Cells[CellIndex]->Depth = DepthIndex + 1;

							for (OutputIndex = 0;OutputIndex < Circuit->Cells[CellIndex]->NumberOfOutputs;OutputIndex++)
								if (Circuit->Cells[CellIndex]->Outputs[OutputIndex] != -1)
									Circuit->Signals[Circuit->Cells[CellIndex]->Outputs[OutputIndex]]->Depth = DepthIndex + 1;
						}
					}

					OneChanged = 1;
				}
			}

			DepthIndex++;
		} while (OneChanged);
	
		OneChanged = 0;

		for (CellIndex = 0;CellIndex < Circuit->NumberOfCells;CellIndex++)
			if (!Circuit->Cells[CellIndex]->Deleted)
			{
				if (Circuit->Cells[CellIndex]->Depth < 0)
				{
					if (Library->CellTypes[Circuit->Cells[CellIndex]->Type]->Type & Parser_CellType_Type_Mux)
					{
						SignalIndex0 = Circuit->Cells[CellIndex]->Inputs[0]; // A
						SignalIndex1 = Circuit->Cells[CellIndex]->Inputs[1]; // B
						SignalIndex2 = Circuit->Cells[CellIndex]->Inputs[2]; // S

						if (Circuit->Signals[SignalIndex2]->Depth >= 0)
						{
							if (BufferTypeIndex < 0)
								for (TypeIndex = 0;TypeIndex < Library->NumberOfCellTypes;TypeIndex++)
									if (Library->CellTypes[TypeIndex]->Type & Parser_CellType_Type_Buffer)
									{
										BufferTypeIndex = TypeIndex;
										break;
									}

							if (BufferTypeIndex < 0)
							{
								printf("no buffer cell type is defined in the library\n");
								return 1;
							}

							if ((Circuit->Signals[SignalIndex0]->Depth >= 0) ||
								(Circuit->Signals[SignalIndex1]->Depth >= 0))
							{
								Circuit->Cells[CellIndex]->Type = BufferTypeIndex;
								Circuit->Cells[CellIndex]->NumberOfInputs = 1;
								RemoveCellFromSignalInputList(Circuit, SignalIndex2, -1, CellIndex);

								TempBuffer = (int*)malloc((Circuit->NumberOfTransitions + 1) * sizeof(int));
								memcpy(TempBuffer, Circuit->TransitionList[0], Circuit->NumberOfTransitions * sizeof(int));
								free(Circuit->TransitionList[0]);
								Circuit->TransitionList[0] = TempBuffer;

								TempBuffer = (int*)malloc((Circuit->NumberOfTransitions + 1) * sizeof(int));
								memcpy(TempBuffer, Circuit->TransitionList[1], Circuit->NumberOfTransitions * sizeof(int));
								free(Circuit->TransitionList[1]);
								Circuit->TransitionList[1] = TempBuffer;

								if (Circuit->Signals[SignalIndex0]->Depth >= 0)
								{
									Circuit->Cells[CellIndex]->Inputs[0] = SignalIndex0;
									RemoveCellFromSignalInputList(Circuit, SignalIndex1, -1, CellIndex);

									Circuit->TransitionList[0][Circuit->NumberOfTransitions] = SignalIndex0;
									Circuit->TransitionList[1][Circuit->NumberOfTransitions] = SignalIndex1;
								}
								else if (Circuit->Signals[SignalIndex1]->Depth >= 0)
								{
									Circuit->Cells[CellIndex]->Inputs[0] = SignalIndex1;
									RemoveCellFromSignalInputList(Circuit, SignalIndex0, -1, CellIndex);

									Circuit->TransitionList[0][Circuit->NumberOfTransitions] = SignalIndex1;
									Circuit->TransitionList[1][Circuit->NumberOfTransitions] = SignalIndex0;
								}

								Circuit->NumberOfTransitions++;
								OneChanged = 1;
							}
						}
					}
				}
			}
	} while (OneChanged);
	   	  

	Circuit->MaxDepth = DepthIndex;
	Circuit->CellsInDepth = (int **)malloc((Circuit->MaxDepth + 1) * sizeof(int *));
	Circuit->NumberOfCellsInDepth = (int *)calloc(Circuit->MaxDepth + 1, sizeof(int));

	for (CellIndex = 0;CellIndex < Circuit->NumberOfCells;CellIndex++)
		Circuit->NumberOfCellsInDepth[Circuit->Cells[CellIndex]->Depth]++;

	for (DepthIndex = 0;DepthIndex <= Circuit->MaxDepth;DepthIndex++)
	{
		Circuit->CellsInDepth[DepthIndex] = (int *)malloc(Circuit->NumberOfCellsInDepth[DepthIndex] * sizeof(int));
		Circuit->NumberOfCellsInDepth[DepthIndex] = 0; // temporary to be used as index in the next loop
	}

	for (CellIndex = 0;CellIndex < Circuit->NumberOfCells;CellIndex++)
		if (!Circuit->Cells[CellIndex]->Deleted)
		{
			DepthIndex = Circuit->Cells[CellIndex]->Depth;

			if (DepthIndex < 0)
			{
				printf("the circuit either has a loop or cell %s has an unconnected input. SILVER is currently not able to evaluate such a deisgn\n", Circuit->Cells[CellIndex]->Name);
				return 1;
			}

			Circuit->CellsInDepth[DepthIndex][Circuit->NumberOfCellsInDepth[DepthIndex]] = CellIndex;
			Circuit->NumberOfCellsInDepth[DepthIndex]++;
		}

	for (SignalIndex = 0;SignalIndex < Circuit->NumberOfSignals;SignalIndex++)
		if ((!Circuit->Signals[SignalIndex]->Deleted) &&
			(Circuit->Signals[SignalIndex]->Output != -1) && (Circuit->Signals[SignalIndex]->Depth == -1))
			break;

	if (SignalIndex < Circuit->NumberOfSignals)
	{
		printf("the depth of signal ""%s"" could not be identified\n", Circuit->Signals[SignalIndex]->Name);
		return 1;
	}

	//*************************************

	Circuit->MaxCycles = 0;
	for (DepthIndex = 0;DepthIndex <= Circuit->MaxDepth;DepthIndex++)
	{
		for (TempIndex = 0;TempIndex < Circuit->NumberOfCellsInDepth[DepthIndex];TempIndex++)
		{
			CellIndex = Circuit->CellsInDepth[DepthIndex][TempIndex];

			Cycle = 0;
			for (InputIndex = 0;InputIndex < Circuit->Cells[CellIndex]->NumberOfInputs;InputIndex++)
			{
				SignalIndex = Circuit->Cells[CellIndex]->Inputs[InputIndex];

				if (Circuit->Signals[SignalIndex]->Output != -1)
					if (Cycle < Circuit->Cells[Circuit->Signals[SignalIndex]->Output]->Cycle)
						Cycle = Circuit->Cells[Circuit->Signals[SignalIndex]->Output]->Cycle;
			}

			if (Library->CellTypes[Circuit->Cells[CellIndex]->Type]->GateOrReg == Parser_CellType_Reg)
				Cycle++;

			Circuit->Cells[CellIndex]->Cycle = Cycle;

			if (Circuit->MaxCycles < Cycle)
				Circuit->MaxCycles = Cycle;
		}
	}

	printf("circuit has %d register stages\n", Circuit->MaxCycles);

	return 0;
}

//***************************************************************************************

int AddSignal(Parser_CircuitStruct* Circuit, char* Name)
{
	int					  SignalIndex;
	int					  NewSignalIndex;
	Parser_SignalStruct** TempSignals;
	
	char*				  Str = (char *)malloc(Parser_Max_Name_Length * sizeof(char));

	TempSignals = (Parser_SignalStruct**)malloc((Circuit->NumberOfSignals + 1) * sizeof(Parser_SignalStruct*));
	memcpy(TempSignals, Circuit->Signals, Circuit->NumberOfSignals * sizeof(Parser_SignalStruct*));
	free(Circuit->Signals);
	Circuit->Signals = TempSignals;
	NewSignalIndex = Circuit->NumberOfSignals;

	Circuit->Signals[NewSignalIndex] = (Parser_SignalStruct*)malloc(sizeof(Parser_SignalStruct));

	if (Name[0])
	{
		strcpy(Str, Name);

		do
		{
			for (SignalIndex = 0;SignalIndex < Circuit->NumberOfSignals;SignalIndex++)
				if (!strcmp(Circuit->Signals[SignalIndex]->Name, Str))
				{
					strcat(Str, "_");
					break;
				}
		} while (SignalIndex < Circuit->NumberOfSignals);
	}
	else
		sprintf(Str, "new_%s_signal_%d", "SILVER", NewSignalIndex);

	Circuit->Signals[NewSignalIndex]->Name = (char *)malloc(strlen(Str) + 1);
	strcpy(Circuit->Signals[NewSignalIndex]->Name, Str);
	Circuit->Signals[NewSignalIndex]->Type = Parser_SignalType_wire;
	Circuit->Signals[NewSignalIndex]->Depth = -1;
	Circuit->Signals[NewSignalIndex]->NumberOfInputs = 0;
	Circuit->Signals[NewSignalIndex]->Inputs = NULL;
	Circuit->Signals[NewSignalIndex]->Output = -1;
	Circuit->Signals[NewSignalIndex]->Deleted = 0;
	Circuit->Signals[NewSignalIndex]->NumberOfAttributeCycles = 0;
	Circuit->Signals[NewSignalIndex]->Attribute = NULL;
	Circuit->NumberOfSignals++;

	free(Str);
	return(NewSignalIndex);
}

//***************************************************************************************

int AddSignalToInputs(Parser_CircuitStruct* Circuit, int SignalIndex)
{
	int*	TempInt;

	Circuit->Signals[SignalIndex]->Type = Parser_SignalType_input;

	TempInt = (int *)malloc((Circuit->NumberOfInputs + 1) * sizeof(int));
	memcpy(TempInt, Circuit->Inputs, Circuit->NumberOfInputs * sizeof(int));
	free(Circuit->Inputs);
	Circuit->Inputs = TempInt;
	Circuit->Inputs[Circuit->NumberOfInputs] = SignalIndex;
	Circuit->NumberOfInputs++;

	return(Circuit->NumberOfInputs);
}

//***************************************************************************************

int AddCellToSignalInputList(Parser_CircuitStruct* Circuit, int SignalIndex, int CellIndex)
{
	int*	TempInt;

	TempInt = (int *)malloc((Circuit->Signals[SignalIndex]->NumberOfInputs + 1) * sizeof(int));
	memcpy(TempInt, Circuit->Signals[SignalIndex]->Inputs, Circuit->Signals[SignalIndex]->NumberOfInputs * sizeof(int));
	free(Circuit->Signals[SignalIndex]->Inputs);
	Circuit->Signals[SignalIndex]->Inputs = TempInt;
	Circuit->Signals[SignalIndex]->Inputs[Circuit->Signals[SignalIndex]->NumberOfInputs] = CellIndex;
	Circuit->Signals[SignalIndex]->NumberOfInputs++;

	return(Circuit->Signals[SignalIndex]->NumberOfInputs);
}

//***************************************************************************************

int ApplyAttributeCycles(Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit)
{
	int		InputIndex;
	int		InputIndex2;
	int		InputIndex3;
	int		SignalIndex;
	int		NewSignalIndex;
	int		NumberOfInputs;
	int*	SignalsInCycle = NULL;
	int		CellIndex;
	int		Cycle;
	int		Cycle2;
	int		i;
	int		j;
	int		TempIndex;
	int*	Buffer_int;

	char*	Str = (char *)malloc(Parser_Max_Name_Length * sizeof(char));

	Circuit->CycleTransitionList[0] = (int**)calloc(Circuit->MaxCycles, sizeof(int*));
	Circuit->CycleTransitionList[1] = (int**)calloc(Circuit->MaxCycles, sizeof(int*));
	Circuit->NumberOfCycleTransitions = (int*)calloc(Circuit->MaxCycles, sizeof(int));

	NumberOfInputs = Circuit->NumberOfInputs;
	for (InputIndex = 0;InputIndex < NumberOfInputs;InputIndex++)
	{
		SignalIndex = Circuit->Inputs[InputIndex];

		//if (strstr(Circuit->Signals[SignalIndex]->Attribute[0], "ref") == Circuit->Signals[SignalIndex]->Attribute[0])

		free(SignalsInCycle);
		SignalsInCycle = (int*)malloc(Circuit->Signals[SignalIndex]->NumberOfAttributeCycles * sizeof(int));

		SignalsInCycle[0] = SignalIndex;
		for (Cycle = 1;Cycle < Circuit->Signals[SignalIndex]->NumberOfAttributeCycles;Cycle++)
		{
			for (i = 0;i < Cycle;i++)
				if (!strcmp(Circuit->Signals[SignalIndex]->Attribute[Cycle], Circuit->Signals[SignalIndex]->Attribute[i]))
					break;

			if (i < Cycle)
				SignalsInCycle[Cycle] = SignalsInCycle[i];
			else
			{
				sprintf(Str, "%s_Cycle%d", Circuit->Signals[SignalIndex]->Name, Cycle);
				NewSignalIndex = AddSignal(Circuit, Str);
				Circuit->Signals[NewSignalIndex]->Depth = 0;
				AddSignalToInputs(Circuit, NewSignalIndex);

				Circuit->Signals[NewSignalIndex]->NumberOfAttributeCycles = 1;
				Circuit->Signals[NewSignalIndex]->Attribute = (char**)malloc(1 * sizeof(char*));
				Circuit->Signals[NewSignalIndex]->Attribute[0] = (char*)malloc((strlen(Circuit->Signals[SignalIndex]->Attribute[Cycle]) + 1) * sizeof(char));
				strcpy(Circuit->Signals[NewSignalIndex]->Attribute[0], Circuit->Signals[SignalIndex]->Attribute[Cycle]);

				SignalsInCycle[Cycle] = NewSignalIndex;
			}
		}

		//****************

		for (InputIndex2 = 0;InputIndex2 < Circuit->Signals[SignalIndex]->NumberOfInputs;InputIndex2++)
		{
			CellIndex = Circuit->Signals[SignalIndex]->Inputs[InputIndex2];
			Cycle = Circuit->Cells[CellIndex]->Cycle;

			if (Cycle >= Circuit->Signals[SignalIndex]->NumberOfAttributeCycles)
				Cycle = Circuit->Signals[SignalIndex]->NumberOfAttributeCycles - 1;

			if (Library->CellTypes[Circuit->Cells[CellIndex]->Type]->GateOrReg == Parser_CellType_Reg)
				Cycle--;

			if (Cycle < 0)
				Cycle = 0;

			if (SignalsInCycle[Cycle] != SignalIndex)
			{
				for (InputIndex3 = 0;InputIndex3 < Circuit->Cells[CellIndex]->NumberOfInputs;InputIndex3++)
					if (Circuit->Cells[CellIndex]->Inputs[InputIndex3] == SignalIndex)
					{
						Circuit->Cells[CellIndex]->Inputs[InputIndex3] = SignalsInCycle[Cycle];
						AddCellToSignalInputList(Circuit, SignalsInCycle[Cycle], CellIndex);
						RemoveCellFromSignalInputList(Circuit, SignalIndex, InputIndex2, CellIndex);
						InputIndex2--;
						break;
					}
			}
		}

		//****************

		for (TempIndex = 0;TempIndex < Circuit->NumberOfTransitions;TempIndex++)
			if (Circuit->TransitionList[0][TempIndex] == SignalIndex)
			{
				if (Circuit->Signals[Circuit->TransitionList[1][TempIndex]]->Output != -1)
				{
					/*****/

					Cycle = Circuit->Cells[Circuit->Signals[Circuit->TransitionList[1][TempIndex]]->Output]->Cycle;
					if (Cycle >= Circuit->Signals[SignalIndex]->NumberOfAttributeCycles)
						Cycle = Circuit->Signals[SignalIndex]->NumberOfAttributeCycles - 1;

					Circuit->TransitionList[0][TempIndex] = SignalsInCycle[Cycle];

					Cycle = Circuit->Cells[Circuit->Signals[Circuit->TransitionList[1][TempIndex]]->Output]->Cycle - 1;
					if (Cycle < 0) // should actually not happen
						Cycle = 0;

					Buffer_int = (int*)malloc((Circuit->NumberOfCycleTransitions[Cycle] + 1) * sizeof(int));
					memcpy(Buffer_int, Circuit->CycleTransitionList[0][Cycle], Circuit->NumberOfCycleTransitions[Cycle] * sizeof(int));
					free(Circuit->CycleTransitionList[0][Cycle]);
					Circuit->CycleTransitionList[0][Cycle] = Buffer_int;

					Buffer_int = (int*)malloc((Circuit->NumberOfCycleTransitions[Cycle] + 1) * sizeof(int));
					memcpy(Buffer_int, Circuit->CycleTransitionList[1][Cycle], Circuit->NumberOfCycleTransitions[Cycle] * sizeof(int));
					free(Circuit->CycleTransitionList[1][Cycle]);
					Circuit->CycleTransitionList[1][Cycle] = Buffer_int;

					Circuit->CycleTransitionList[0][Cycle][Circuit->NumberOfCycleTransitions[Cycle]] = Circuit->TransitionList[0][TempIndex];
					Circuit->CycleTransitionList[1][Cycle][Circuit->NumberOfCycleTransitions[Cycle]] = Circuit->TransitionList[1][TempIndex];
					Circuit->NumberOfCycleTransitions[Cycle]++;
				}
			}

		//****************

		for (Cycle = 0;Cycle < Circuit->Signals[SignalIndex]->NumberOfAttributeCycles - 1;Cycle++)
			if (Cycle < Circuit->MaxCycles)
			{
				if (SignalsInCycle[Cycle] != SignalsInCycle[Cycle + 1])
				{
					Buffer_int = (int*)malloc((Circuit->NumberOfCycleTransitions[Cycle] + 1) * sizeof(int));
					memcpy(Buffer_int, Circuit->CycleTransitionList[0][Cycle], Circuit->NumberOfCycleTransitions[Cycle] * sizeof(int));
					free(Circuit->CycleTransitionList[0][Cycle]);
					Circuit->CycleTransitionList[0][Cycle] = Buffer_int;

					Buffer_int = (int*)malloc((Circuit->NumberOfCycleTransitions[Cycle] + 1) * sizeof(int));
					memcpy(Buffer_int, Circuit->CycleTransitionList[1][Cycle], Circuit->NumberOfCycleTransitions[Cycle] * sizeof(int));
					free(Circuit->CycleTransitionList[1][Cycle]);
					Circuit->CycleTransitionList[1][Cycle] = Buffer_int;

					Circuit->CycleTransitionList[0][Cycle][Circuit->NumberOfCycleTransitions[Cycle]] = SignalsInCycle[Cycle + 1];
					Circuit->CycleTransitionList[1][Cycle][Circuit->NumberOfCycleTransitions[Cycle]] = SignalsInCycle[Cycle];
					Circuit->NumberOfCycleTransitions[Cycle]++;
				}

				for (Cycle2 = 0;Cycle2 <= Cycle;Cycle2++)
					if (SignalsInCycle[Cycle2] != SignalsInCycle[Cycle + 1])
					{
						Buffer_int = (int*)malloc((Circuit->NumberOfCycleTransitions[Cycle] + 1) * sizeof(int));
						memcpy(Buffer_int, Circuit->CycleTransitionList[0][Cycle], Circuit->NumberOfCycleTransitions[Cycle] * sizeof(int));
						free(Circuit->CycleTransitionList[0][Cycle]);
						Circuit->CycleTransitionList[0][Cycle] = Buffer_int;

						Buffer_int = (int*)malloc((Circuit->NumberOfCycleTransitions[Cycle] + 1) * sizeof(int));
						memcpy(Buffer_int, Circuit->CycleTransitionList[1][Cycle], Circuit->NumberOfCycleTransitions[Cycle] * sizeof(int));
						free(Circuit->CycleTransitionList[1][Cycle]);
						Circuit->CycleTransitionList[1][Cycle] = Buffer_int;

						Circuit->CycleTransitionList[0][Cycle][Circuit->NumberOfCycleTransitions[Cycle]] = -SignalsInCycle[Cycle2];
						Circuit->CycleTransitionList[1][Cycle][Circuit->NumberOfCycleTransitions[Cycle]] = -SignalsInCycle[Cycle + 1];
						Circuit->NumberOfCycleTransitions[Cycle]++;
					}
			}
	}

	free(Str);
	return 0;
}


//***************************************************************************************

int WriteCustomizedFile(char* OutputFileName, Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit)
{
	FILE*	OutFile;
	int		GateIndex;
	int		RegIndex;
	int		InputIndex;
	int		SignalIndex;
	int		OutputIndex;
	int		UnusedSignalCounter;
	int		TempIndex;
	int		TempIndex2;
	int		DepthIndex;
	int		CellIndex;
	int*	TempSignalList;
	char	ShouldBeAdded;
	int		ThisCell_SignalIndex;
	int		Cycle;
	char	TransitionFileShouldBeMade;
	int*	TempTransitionList[2] = { NULL,NULL };
	int		NumberOfTempTransitionList;
	int*	Buffer_int;

	TempSignalList = (int*)malloc(Circuit->NumberOfSignals * 2 * sizeof(int)); // * 2 for registers with two outputs
	OutFile = fopen(OutputFileName, "wt");

	SignalIndex = 0;
	if (Parser_With_GND_and_VDD)
	{
		fprintf(OutFile, "in 0 0\n"); // gnd
		fprintf(OutFile, "in 1 1\n"); // vdd
		TempSignalList[SignalIndex++] = 0;
		TempSignalList[SignalIndex++] = 1;
	}

	for (InputIndex = 0;InputIndex < Circuit->NumberOfInputs;InputIndex++)
	{
		if (strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute[0], "con"))
		{
			if (!strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute[0], "clk"))
				Circuit->ClockSignalIndex = Circuit->Inputs[InputIndex];
			else
				if (strstr(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute[0], "ref") != Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute[0])
				{
					TempSignalList[Circuit->Inputs[InputIndex]] = SignalIndex++;
					fprintf(OutFile, "in %d %s # %s\n", TempSignalList[Circuit->Inputs[InputIndex]], Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute[0], Circuit->Signals[Circuit->Inputs[InputIndex]]->Name);
				}
		}
	}

	for (InputIndex = 0;InputIndex < Circuit->NumberOfInputs;InputIndex++)
	{
		if (strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute[0], "con"))
		{
			if (!strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute[0], "clk"))
				Circuit->ClockSignalIndex = Circuit->Inputs[InputIndex];
			else
				if (strstr(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute[0], "ref") == Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute[0])
				{
					TempSignalList[Circuit->Inputs[InputIndex]] = SignalIndex++;
					fprintf(OutFile, "ref %d # %s\n", TempSignalList[Circuit->Inputs[InputIndex]], Circuit->Signals[Circuit->Inputs[InputIndex]]->Name);
				}
		}
	}

	//----------------------

	for (DepthIndex = 1;DepthIndex < Circuit->MaxDepth + 1;DepthIndex++)
	{
		//fprintf(OutFile, "# depth %d\n", DepthIndex);

		for (CellIndex = 0;CellIndex < Circuit->NumberOfCellsInDepth[DepthIndex];CellIndex++)
		{
			ShouldBeAdded = 0;
			for (OutputIndex = 0;OutputIndex < Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->NumberOfOutputs; OutputIndex++)
				if (Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Outputs[OutputIndex] != -1)
					ShouldBeAdded = 1;

			if (ShouldBeAdded)
			{
				fprintf(OutFile, "%s", Library->CellTypes[Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Type]->CustomName);

				for (InputIndex = 0;InputIndex < Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->NumberOfInputs;InputIndex++)
				{
					TempIndex = Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Inputs[InputIndex];

					if (strcmp(Circuit->Signals[TempIndex]->Attribute[0], "con") &&
						strcmp(Circuit->Signals[TempIndex]->Attribute[0], "clk"))
						fprintf(OutFile, " %d", TempSignalList[TempIndex]);
				}

				fprintf(OutFile, " # %s\n", Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Name);

				ThisCell_SignalIndex = SignalIndex++;

				for (OutputIndex = 0;OutputIndex < Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->NumberOfOutputs; OutputIndex++)
					if (Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Outputs[OutputIndex] != -1)
					{
						if (OutputIndex == 0)
							TempSignalList[Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Outputs[OutputIndex]] = ThisCell_SignalIndex;
						else if ((OutputIndex == 1) &&  // D_FF QN
							(Library->CellTypes[Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Type]->GateOrReg == Parser_CellType_Reg)) // an inverter should be added after Reg
						{
							fprintf(OutFile, "not %d # auto_add for %s\n", ThisCell_SignalIndex, Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Name);
							TempSignalList[Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Outputs[OutputIndex]] = SignalIndex++;
						}
					}
			}
		}
	}

	for (OutputIndex = 0;OutputIndex < Circuit->NumberOfOutputs;OutputIndex++)
	{
		if (strcmp(Circuit->Signals[Circuit->Outputs[OutputIndex]]->Attribute[0], "con") &&
			strcmp(Circuit->Signals[Circuit->Outputs[OutputIndex]]->Attribute[0], "clk"))
		{
			TempIndex = TempSignalList[Circuit->Outputs[OutputIndex]];
			fprintf(OutFile, "out %d %s # %s\n", TempIndex, Circuit->Signals[Circuit->Outputs[OutputIndex]]->Attribute[0], Circuit->Signals[Circuit->Outputs[OutputIndex]]->Name);
		}
	}

	fclose(OutFile);

	//*************************

	char *TempStr = (char *)malloc(Parser_Max_Name_Length * sizeof(char));
	char *ptr;

	strcpy(TempStr, OutputFileName);
	ptr = strchr(TempStr, '.');
	if (ptr != NULL)
		*ptr = 0;
	strcat(TempStr, "_tran");
	ptr = strchr(OutputFileName, '.');
	if (ptr != NULL)
		strcat(TempStr, ptr);

	if (Circuit->NumberOfTransitions > 0)
	{
		printf("the circuit has a loop and a list for transitional leakage is made\n");
		TransitionFileShouldBeMade = 1;
	}
	else
	{
		TransitionFileShouldBeMade = 0;
		for (Cycle = 0;Cycle < Circuit->MaxCycles;Cycle++)
			if (Circuit->NumberOfCycleTransitions[Cycle])
			{
				printf("the circuit has transitional input, and a list for transitional leakage is made\n");
				TransitionFileShouldBeMade = 1;
				break;
			}
	}

	if (TransitionFileShouldBeMade)
	{
		OutFile = fopen(TempStr, "wt");

		NumberOfTempTransitionList = 0;
		for (Cycle = 0;Cycle < Circuit->MaxCycles;Cycle++)
			if (Circuit->NumberOfCycleTransitions[Cycle])
			{
				fprintf(OutFile, "Cycle %d\n", Cycle + 1);

				for (TempIndex = 0;TempIndex < Circuit->NumberOfCycleTransitions[Cycle];TempIndex++)
					if ((Circuit->CycleTransitionList[0][Cycle][TempIndex] < 0) ||
						(Circuit->CycleTransitionList[1][Cycle][TempIndex] < 0))
					{
						for (TempIndex2 = 0;TempIndex2 < NumberOfTempTransitionList;TempIndex2++)
							if (TempTransitionList[0][TempIndex2] == -Circuit->CycleTransitionList[0][Cycle][TempIndex])
								break;

						if (TempIndex2 < NumberOfTempTransitionList)
							TempTransitionList[1][TempIndex2] = -Circuit->CycleTransitionList[1][Cycle][TempIndex];
						else
						{
							Buffer_int = (int*)malloc((NumberOfTempTransitionList + 1) * sizeof(int));
							memcpy(Buffer_int, TempTransitionList[0], NumberOfTempTransitionList * sizeof(int));
							free(TempTransitionList[0]);
							TempTransitionList[0] = Buffer_int;

							Buffer_int = (int*)malloc((NumberOfTempTransitionList + 1) * sizeof(int));
							memcpy(Buffer_int, TempTransitionList[1], NumberOfTempTransitionList * sizeof(int));
							free(TempTransitionList[1]);
							TempTransitionList[1] = Buffer_int;

							TempTransitionList[0][NumberOfTempTransitionList] = -Circuit->CycleTransitionList[0][Cycle][TempIndex];
							TempTransitionList[1][NumberOfTempTransitionList] = -Circuit->CycleTransitionList[1][Cycle][TempIndex];
							NumberOfTempTransitionList++;
						}
					}

				fprintf(OutFile, "inputs:\n");
				for (TempIndex2 = 0;TempIndex2 < NumberOfTempTransitionList;TempIndex2++)
					fprintf(OutFile, "%d %d # %s %s\n",
						TempSignalList[TempTransitionList[0][TempIndex2]],
						TempSignalList[TempTransitionList[1][TempIndex2]],
						Circuit->Signals[TempTransitionList[0][TempIndex2]]->Name,
						Circuit->Signals[TempTransitionList[1][TempIndex2]]->Name);

				/*
								for (TempIndex = 0;TempIndex < Circuit->NumberOfCycleTransitions[Cycle];TempIndex++)
									if ((Circuit->CycleTransitionList[0][Cycle][TempIndex] < 0) ||
										(Circuit->CycleTransitionList[1][Cycle][TempIndex] < 0))
										fprintf(OutFile, "%d %d # %s %s\n",
											TempSignalList[-Circuit->CycleTransitionList[0][Cycle][TempIndex]],
											TempSignalList[-Circuit->CycleTransitionList[1][Cycle][TempIndex]],
											Circuit->Signals[-Circuit->CycleTransitionList[0][Cycle][TempIndex]]->Name,
											Circuit->Signals[-Circuit->CycleTransitionList[1][Cycle][TempIndex]]->Name);
				*/


				fprintf(OutFile, "transitions:\n");
				for (TempIndex = 0;TempIndex < Circuit->NumberOfCycleTransitions[Cycle];TempIndex++)
					if ((Circuit->CycleTransitionList[0][Cycle][TempIndex] > 0) ||
						(Circuit->CycleTransitionList[1][Cycle][TempIndex] > 0))
						fprintf(OutFile, "%d %d # %s %s\n",
							TempSignalList[Circuit->CycleTransitionList[0][Cycle][TempIndex]],
							TempSignalList[Circuit->CycleTransitionList[1][Cycle][TempIndex]],
							Circuit->Signals[Circuit->CycleTransitionList[0][Cycle][TempIndex]]->Name,
							Circuit->Signals[Circuit->CycleTransitionList[1][Cycle][TempIndex]]->Name);

				fprintf(OutFile, "\n");
			}

		fclose(OutFile);
	}
	else
		remove(TempStr);
	
	free(TempStr);

	return 0;
}

//***************************************************************************************

int Parse_and_Convert(char* LibraryFileName, char* LibraryName,
	char* InputVerilogFileName, char* MainModuleName, char* OutputFileName, unsigned char WithAttributes = 1)
{
	//---------------------------------------------------------------------------------------------//
	//------------------- reading the library file ------------------------------------------------//
	int res;
	Parser_LibraryStruct Library;

	res = ReadLibrryFile(LibraryFileName, LibraryName, &Library);

	//---------------------------------------------------------------------------------------------//
	//------------------- reading the design file -------------------------------------------------//

	Parser_CircuitStruct Circuit;

	if (!res)
		res = ReadDesignFile(InputVerilogFileName, MainModuleName, &Library, &Circuit, WithAttributes);

	//---------------------------------------------------------------------------------------------//
	//------------------- remove unconnected cells ------------------------------------------------//

	if (!res)
		res = RemoveUnconnectedCells(&Library, &Circuit);

	//---------------------------------------------------------------------------------------------//
	//------------------- remove all buffers ------------------------------------------------------//

	if (!res)
		res = RemoveAllBuffers(&Library, &Circuit);

	//---------------------------------------------------------------------------------------------//
	//------------------- make the depth of the cells ---------------------------------------------//

	if (!res)
		res = MakeCircuitDepth(&Library, &Circuit);

	//---------------------------------------------------------------------------------------------//
	//------------------- apply the attributes to the cycles of the circuit -----------------------//

	if (!res)
		res = ApplyAttributeCycles(&Library, &Circuit);
	
	//---------------------------------------------------------------------------------------------//
	//------------------- writing the customized file for Pascal tool -----------------------------//

	if (!res)
		res = WriteCustomizedFile(OutputFileName, &Library, &Circuit);

	return(res);
}

//***************************************************************************************

static int parse_and_convert_wrapper(
    std::string LibraryFileName, std::string LibraryName,
	std::string InputFileName, std::string MainModuleName,
	std::string OutputFileName
)
{
    std::vector<char> lfn(LibraryFileName.begin(), LibraryFileName.end()); lfn.push_back('\0');
    std::vector<char> ln(LibraryName.begin(), LibraryName.end()); ln.push_back('\0');
    std::vector<char> ifn(InputFileName.begin(), InputFileName.end()); ifn.push_back('\0');
    std::vector<char> mmn(MainModuleName.begin(), MainModuleName.end()); mmn.push_back('\0');
    std::vector<char> ofn(OutputFileName.begin(), OutputFileName.end()); ofn.push_back('\0');

    return Parse_and_Convert(&lfn[0], &ln[0], &ifn[0], &mmn[0], &ofn[0]);
}
