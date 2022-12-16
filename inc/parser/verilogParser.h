//////////////////////////////////////////////////////////////////////////////////
// COMPANY:		Ruhr University Bochum
// AUTHOR:		Amir Moradi (for the paper: https://doi.org/10.1007/978-3-030-64837-4_26
//                                          https://eprint.iacr.org/2020/634.pdf
//////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, Amir Moradi
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

#define Parser_Max_Name_Length 10000

#define Parser_CellType_Gate     0
#define Parser_CellType_Reg      1

#define Parser_CellType_Type_Buffer   1

#define Parser_SignalType_input  0
#define Parser_SignalType_output 1
#define Parser_SignalType_wire   2

#define Parser_Task_find_module_type          0
#define Parser_Task_find_module_name          1
#define Parser_Task_find_open_bracket         2
#define Parser_Task_find_point                3
#define Parser_Task_find_IO_port              4
#define Parser_Task_find_signal_name          5
#define Parser_Task_find_close_bracket        6
#define Parser_Task_find_comma                7
#define Parser_Task_find_assign_signal_name1  8
#define Parser_Task_find_equal                9
#define Parser_Task_find_assign_signal_name2 10

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
	char*	Attribute;
	char	Deleted;
};

struct Parser_LibraryStruct {
	Parser_CellTypeStruct**	CellTypes = NULL;
	int						NumberOfCellTypes;
    int                     BufferCellType = -1;
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
    //reset Buffer
	memset(Buffer, 0, 10); //Parser_Max_Name_Length

    static char Lastch = 0;
    char        ch = 0;
    int         i = 0;
    int         j = 0;
    char        BracketOpened = 0;

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
				if (i && (!BracketOpened))
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
            {
                Buffer[i++] = ch;

           		if (ch == '{')
	            	BracketOpened = 1;

	            if (ch == '}')
	            	BracketOpened = 0;
			}
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
					{
						Library->CellTypes[Library->NumberOfCellTypes]->Type |= Parser_CellType_Type_Buffer;
						if (Library->BufferCellType < 0)
							Library->BufferCellType = Library->NumberOfCellTypes;
					}

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

int ProcessAttribute(char* AttributeText, char** &NewAttributes, int &NumberOfNewAttributes)
{
	int				i;
	char*			ptr;
	char			ch;
	int				j;
	int				k;
	static char*	Str1 = NULL;
	static char*	Str2 = NULL;
	static char*	Str3 = NULL;
	static char*	Str4 = NULL;
	int				VariableIndex1;
	int				VariableIndex2;
	int				VariableIndex;
	int				ShareIndex1;
	int				ShareIndex2;
	int				ShareIndex;
	int				VariableIndexUpwards;
	int				ShareIndexUpwards;
	char**			Buffer_char;

	for (i = 0;i < NumberOfNewAttributes;i++)
		free(NewAttributes[i]);
	free(NewAttributes);
	NumberOfNewAttributes = 0;
	NewAttributes = NULL;

	if (Str1 == NULL)
	{
		Str1 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));
		Str2 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));
		Str3 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));
		Str4 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));
	}

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
						else if ((ch == ',') || (ch == '\"'))
						{
							if ((VariableIndex1 != -1) && (ShareIndex1 != -1))
							{
								printf("giben attribute is not valid: %s\n", AttributeText);
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
										strcpy(Str3, "ref");
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

									Buffer_char = (char**)malloc((NumberOfNewAttributes + 1) * sizeof(char*));
									memcpy(Buffer_char, NewAttributes, NumberOfNewAttributes * sizeof(char*));
									free(NewAttributes);
									NewAttributes = Buffer_char;

									NewAttributes[NumberOfNewAttributes] = (char*)malloc((strlen(Str4) + 1) * sizeof(char));
									strcpy(NewAttributes[NumberOfNewAttributes], Str4);
									NumberOfNewAttributes++;
								}
							}
						}
						else if ((ch != ' ') && (ch != '\n') && (ch != '\t') && (ch != '\r'))
						{
							Str1[i++] = ch;
							Str1[i] = 0;
						}
					} while ((ch != '\"') && (ch != ',') && ch);
				} while (ch != '\"');


			}
		}
	}

	return(0);
}

//***************************************************************************************

int TrimSignalName(char* SignalName, int* k = NULL)
{
	int          i, j, l;
	static char* Str = NULL;
	char*        ptr;

	if (Str == NULL)
		Str = (char *)malloc(Parser_Max_Name_Length * sizeof(char));

	j = -1;
	l = strlen(SignalName);

	if (SignalName[l - 1] == ']')
	{
		for (i = l - 2;i >= 0;i--)
			if (SignalName[i] == '[')
				break;

		if (i >= 0)
		{
			SignalName[i] = 0;
			strcpy(Str, &SignalName[i + 1]);
			Str[strlen(Str) - 1] = 0;
			ptr = strchr(Str, ':');
			if (ptr == NULL)
			{
				j = atoi(Str);
				if (k != NULL)
					*k = -1;
			}
			else
			{
				*ptr = 0;
				j = atoi(Str);
				if (k != NULL)
					*k = atoi(ptr + 1);
			}
		}
	}

	return(j);
}

//***************************************************************************************

int ReadDesignFile_Find_IO_Port(char* Str1, char SubCircuitRead, int CellTypeIndex, int CaseIndex,
                                Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit, int NumberOfSignalsOffset,
                                char* SubCircuitInstanceName, Parser_CircuitStruct* SubCircuit,
                                int* &InputPorts, int &NumberOfInputPorts, int* &OutputPorts, int &NumberOfOutputPorts)
{
	int          SignalIndex;
	int 		 InputIndex;
	int 		 OutputIndex;
	int          TempIndex;
	int          i;
    static char* Str2 = NULL;
    int*         Buffer_int;

 	if (Str2 == NULL)
 		Str2 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));

	NumberOfInputPorts = 0;
	NumberOfOutputPorts = 0;
	free(InputPorts);
	free(OutputPorts);
	InputPorts = NULL;
	OutputPorts = NULL;

	if (!SubCircuitRead)
	{
		if (strlen(Str1))
		{
			for (InputIndex = 0; InputIndex < Library->CellTypes[CellTypeIndex]->NumberOfInputs; InputIndex++)
			{
				strcpy(Str2, Library->CellTypes[CellTypeIndex]->Inputs[InputIndex]);
				i = TrimSignalName(Str2);

				if ((!strcmp(Str1 + 1, Library->CellTypes[CellTypeIndex]->Inputs[InputIndex])) ||
					(!strcmp(Str1 + 1, Str2)))
				{
					Buffer_int = (int *)malloc((NumberOfInputPorts + 1) * sizeof(int));
					memcpy(Buffer_int, InputPorts, NumberOfInputPorts * sizeof(int));
					free(InputPorts);
					InputPorts = Buffer_int;

					InputPorts[NumberOfInputPorts] = InputIndex;
					NumberOfInputPorts++;

					if (i < 0) // means the signal name was found not its trimmed
						break;
				}
			}

			if (!NumberOfInputPorts) // the IO port NOT found in the Circuit->Inputs
			{
				for (OutputIndex = 0; OutputIndex < Library->CellTypes[CellTypeIndex]->NumberOfOutputs; OutputIndex++)
				{
					strcpy(Str2, Library->CellTypes[CellTypeIndex]->Outputs[OutputIndex]);
					i = TrimSignalName(Str2);

					if ((!strcmp(Str1 + 1, Library->CellTypes[CellTypeIndex]->Outputs[OutputIndex])) ||
						(!strcmp(Str1 + 1, Str2)))
					{
						Buffer_int = (int *)malloc((NumberOfOutputPorts + 1) * sizeof(int));
						memcpy(Buffer_int, OutputPorts, NumberOfOutputPorts * sizeof(int));
						free(OutputPorts);
						OutputPorts = Buffer_int;

						OutputPorts[NumberOfOutputPorts] = OutputIndex;
						NumberOfOutputPorts++;

						if (i < 0) // means the signal name was found not its trimmed
							break;
					}
				}

				if (!NumberOfOutputPorts) // the IO port NOT found in the Circuit->Outputs
				{
					printf("IO port \"%s\" not found in cell type \"%s\"\n", Str1 + 1, Library->CellTypes[CellTypeIndex]->Cases[CaseIndex]);
					return 1;
				}
			}
		}
		else
		{
			for (InputIndex = 0; InputIndex < Circuit->Cells[Circuit->NumberOfCells]->NumberOfInputs; InputIndex++)
				if (Circuit->Cells[Circuit->NumberOfCells]->Inputs[InputIndex] == -1)
				{
					printf("Input port \"%s\" of cell \"%s\" cannot be left unconnected\n", Library->CellTypes[CellTypeIndex]->Inputs[InputIndex], Circuit->Cells[Circuit->NumberOfCells]->Name);
					return 1;
				}

			for (OutputIndex = 0; OutputIndex < Circuit->Cells[Circuit->NumberOfCells]->NumberOfOutputs; OutputIndex++)
				if (Circuit->Cells[Circuit->NumberOfCells]->Outputs[OutputIndex] == -1)
				{
					Buffer_int = (int *)malloc((NumberOfOutputPorts + 1) * sizeof(int));
					memcpy(Buffer_int, OutputPorts, NumberOfOutputPorts * sizeof(int));
					free(OutputPorts);
					OutputPorts = Buffer_int;

					OutputPorts[NumberOfOutputPorts] = OutputIndex;
					NumberOfOutputPorts++;
				}
		}
	}
	else
	{
		if (strlen(Str1))
		{
			TempIndex = strlen(SubCircuitInstanceName);
			strcat(SubCircuitInstanceName, ".");
			if (Str1[1] == '\\')
				strcat(SubCircuitInstanceName, Str1 + 2);
			else
				strcat(SubCircuitInstanceName, Str1 + 1);

			strcpy(Str1, "\\");
			strcat(Str1, SubCircuitInstanceName);
			SubCircuitInstanceName[TempIndex] = '\0';

			for (InputIndex = 0; InputIndex < SubCircuit->NumberOfInputs; InputIndex++)
			{
				SignalIndex = SubCircuit->Inputs[InputIndex];
				if (SignalIndex > Circuit->NumberOfConstants)
					SignalIndex -= NumberOfSignalsOffset;

				strcpy(Str2, Circuit->Signals[SignalIndex]->Name);
				i = TrimSignalName(Str2);

				if ((!strcmp(Str1, Circuit->Signals[SignalIndex]->Name)) ||
					(!strcmp(Str1, Str2)))
				{
					Buffer_int = (int *)malloc((NumberOfInputPorts + 1) * sizeof(int));
					memcpy(Buffer_int, InputPorts, NumberOfInputPorts * sizeof(int));
					free(InputPorts);
					InputPorts = Buffer_int;

					InputPorts[NumberOfInputPorts] = InputIndex;
					NumberOfInputPorts++;

					if (i < 0) // means the signal name was found not its trimmed
						break;
				}
			}

			if (!NumberOfInputPorts) // the IO port NOT found in the SubCircuit.Inputs
			{
				for (OutputIndex = 0; OutputIndex < SubCircuit->NumberOfOutputs; OutputIndex++)
				{
					SignalIndex = SubCircuit->Outputs[OutputIndex];
					if (SignalIndex > Circuit->NumberOfConstants)
						SignalIndex -= NumberOfSignalsOffset;

					strcpy(Str2, Circuit->Signals[SignalIndex]->Name);
					i = TrimSignalName(Str2);

					if ((!strcmp(Str1, Circuit->Signals[SignalIndex]->Name)) ||
						(!strcmp(Str1, Str2)))
					{
						Buffer_int = (int *)malloc((NumberOfOutputPorts + 1) * sizeof(int));
						memcpy(Buffer_int, OutputPorts, NumberOfOutputPorts * sizeof(int));
						free(OutputPorts);
						OutputPorts = Buffer_int;

						OutputPorts[NumberOfOutputPorts] = OutputIndex;
						NumberOfOutputPorts++;

						if (i < 0) // means the signal name was found not its trimmed
							break;
					}
				}

				if (!NumberOfOutputPorts) // the IO port NOT found in the subCircuit.Outputs
				{
					printf("IO port \"%s\" not found in module \"%s\"", Str1, SubCircuitInstanceName);
					return 1;
				}
			}
		}
		else
		{
			for (InputIndex = 0; InputIndex < SubCircuit->NumberOfInputs; InputIndex++)
			{
				SignalIndex = SubCircuit->Inputs[InputIndex];
				if (SignalIndex > Circuit->NumberOfConstants)
					SignalIndex -= NumberOfSignalsOffset;

				if (!Circuit->Signals[SignalIndex]->Deleted)
				{
					printf("Input port \"%s\" of module \"%s\" cannot be left unconnected\n", Circuit->Signals[SignalIndex]->Name, SubCircuitInstanceName);
					return 1;
				}
			}

			for (OutputIndex = 0; OutputIndex < SubCircuit->NumberOfOutputs; OutputIndex++)
			{
				SignalIndex = SubCircuit->Outputs[OutputIndex];
				if (SignalIndex > Circuit->NumberOfConstants)
					SignalIndex -= NumberOfSignalsOffset;

				if (!Circuit->Signals[SignalIndex]->Deleted)
				{
					Buffer_int = (int *)malloc((NumberOfOutputPorts + 1) * sizeof(int));
					memcpy(Buffer_int, OutputPorts, NumberOfOutputPorts * sizeof(int));
					free(OutputPorts);
					OutputPorts = Buffer_int;

					OutputPorts[NumberOfOutputPorts] = OutputIndex;
					NumberOfOutputPorts++;
				}
			}
		}
	}

	return 0;
}

//***************************************************************************************

int ReadDesignFile_Find_Signal_Name(char* Str1, char SubCircuitRead, int CellTypeIndex, int CaseIndex,
                                    Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit, int Task,
                                    int NumberOfSignalsOffset, int NumberOfCellsOffset,
                                    char* SubCircuitInstanceName, Parser_CircuitStruct* SubCircuit,
                                    int* &InputPorts, int &NumberOfInputPorts, int* &OutputPorts, int &NumberOfOutputPorts, int &CurrentIO)
{
	int                 SignalIndex;
	int                 SignalIndexWithOffset;
	int                 SignalIndex2;
	int                 SignalIndex2WithOffset;
	int 		        InputIndex;
	int 		        OutputIndex;
	int                 CellIndex;
	int                 InputIndex2;
	int                 OutputIndex2;
	int                 TempIndex;
    int*                Buffer_int;
    static char*        Str2 = NULL;
    static char*        Str3 = NULL;
    int                 Index1, Index2, IndexUpwards;
    int                 j;
    Parser_CellStruct** TempCells;
    int*                TempGates;
    int*                IOSignals = NULL;
    int                 NumberOfIOSignals = 0;
    char*               strptr;
    char*               strptr2;
    char                doneone;

	if (Str2 == NULL)
		Str2 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));

	if (Str3 == NULL)
		Str3 = (char*)malloc(Parser_Max_Name_Length * sizeof(char));

	if (strlen(Str1))
	{
		strptr = Str1;
		if (strptr[0] == '{')
			strptr++;

		if (strptr[strlen(strptr) - 1] == '}')
			strptr[strlen(strptr) - 1]  = 0;

		strptr[strlen(strptr) + 1] = 0;

		while (strlen(strptr))
		{
			strptr2 = strchr(strptr, ',');
			if (strptr2)
				*strptr2 = 0;

			strcpy(Str2, strptr);
			Index1 = TrimSignalName(Str2, &Index2);
			doneone = 0;

			if (Index1 < 0) // the given signal name does not have any index (without [])
			{
				for (SignalIndex = 0; SignalIndex < Circuit->NumberOfSignals; SignalIndex++)
				{
					strcpy(Str2, Circuit->Signals[SignalIndex]->Name);
					TrimSignalName(Str2);

					if (!strcmp(strptr, Str2))
					{
						Buffer_int = (int *)malloc((NumberOfIOSignals + 1) * sizeof(int));
						memcpy(Buffer_int, IOSignals, NumberOfIOSignals * sizeof(int));
						free(IOSignals);
						IOSignals = Buffer_int;

						IOSignals[NumberOfIOSignals] = SignalIndex;
						NumberOfIOSignals++;
						doneone = 1;
					}
				}
			}
			else if ((Index1 >= 0) && (Index2 < 0)) // the given signal name has one index (with [ ])
			{
				for (SignalIndex = 0; SignalIndex < Circuit->NumberOfSignals; SignalIndex++)
				{
					if (!strcmp(strptr, Circuit->Signals[SignalIndex]->Name))
					{
						Buffer_int = (int *)malloc((NumberOfIOSignals + 1) * sizeof(int));
						memcpy(Buffer_int, IOSignals, NumberOfIOSignals * sizeof(int));
						free(IOSignals);
						IOSignals = Buffer_int;

						IOSignals[NumberOfIOSignals] = SignalIndex;
						NumberOfIOSignals++;
						doneone = 1;
					}
				}
			}
			else if ((Index1 >= 0) && (Index2 >= 0)) // the given signal name has two indices (with [ : ])
			{
				IndexUpwards = (Index1 < Index2) ? 1 : -1;

				for (j = Index1; ((IndexUpwards == 1) && (j <= Index2)) || ((IndexUpwards == -1) && (j >= Index2)); j += IndexUpwards)
				{
					sprintf(Str3, "%s[%d]", Str2, j);

					for (SignalIndex = 0; SignalIndex < Circuit->NumberOfSignals; SignalIndex++)
						if (!strcmp(Str3, Circuit->Signals[SignalIndex]->Name))
							break;

					if (SignalIndex < Circuit->NumberOfSignals)
					{
						Buffer_int = (int *)malloc((NumberOfIOSignals + 1) * sizeof(int));
						memcpy(Buffer_int, IOSignals, NumberOfIOSignals * sizeof(int));
						free(IOSignals);
						IOSignals = Buffer_int;

						IOSignals[NumberOfIOSignals] = SignalIndex;
						NumberOfIOSignals++;
						doneone = 1;
					}
					else
					{
						printf("Signal \"%s\" not found\n", Str3);
						free(IOSignals);
						return 1;
					}
				}
			}

			if (!doneone)
			{
				printf("Signal \"%s\" not found\n", strptr);
				free(IOSignals);
				return 1;
			}

			strptr += strlen(strptr) + 1;
		}
	}
	else
	{
		if (NumberOfInputPorts > 0)
		{
			if (!SubCircuitRead)
			{
				printf("Input port \"%s\" of cell type \"%s\" cannot be left unconnected\n", Library->CellTypes[CellTypeIndex]->Inputs[InputPorts[0]], Library->CellTypes[CellTypeIndex]->Cases[CaseIndex]);
				free(IOSignals);
				return 1;
			}
			else
			{
				SignalIndex = SubCircuit->Inputs[InputPorts[0]];
				if (SignalIndex >= Circuit->NumberOfConstants)
					SignalIndex -= NumberOfSignalsOffset;

				printf("Input port \"%s\" of module \"%s\" cannot be left unconnected\n", Circuit->Signals[SignalIndex]->Name, SubCircuitInstanceName);
				free(IOSignals);
				return 1;
			}
		}

		for (TempIndex = 0; TempIndex < NumberOfOutputPorts; TempIndex++)
		{
			Buffer_int = (int *)malloc((NumberOfIOSignals + 1) * sizeof(int));
			memcpy(Buffer_int, IOSignals, NumberOfIOSignals * sizeof(int));
			free(IOSignals);
			IOSignals = Buffer_int;

			IOSignals[NumberOfIOSignals] = -1;
			NumberOfIOSignals++;
		}
	}

	//**********************************************//

	if (Task == Parser_Task_find_assign_signal_name1)
	{
		free(InputPorts);
		NumberOfInputPorts = NumberOfIOSignals;
		InputPorts = (int *)malloc(NumberOfInputPorts * sizeof(int));

		for (TempIndex = 0; TempIndex < NumberOfIOSignals; TempIndex++)
		{
			CellTypeIndex = Library->BufferCellType; // not necessary

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

			for (InputIndex = 0;InputIndex < Circuit->Cells[Circuit->NumberOfCells]->NumberOfInputs; InputIndex++)
				Circuit->Cells[Circuit->NumberOfCells]->Inputs[InputIndex] = -1;

			for (OutputIndex = 0;OutputIndex < Circuit->Cells[Circuit->NumberOfCells]->NumberOfOutputs; OutputIndex++)
				Circuit->Cells[Circuit->NumberOfCells]->Outputs[OutputIndex] = -1;

			//if (Library->CellTypes[CellTypeIndex]->GateOrReg == CellType_Gate)
			Circuit->Cells[Circuit->NumberOfCells]->Depth = -1;

			TempGates = (int *)malloc((Circuit->NumberOfGates + 1) * sizeof(int));
			memcpy(TempGates, Circuit->Gates, Circuit->NumberOfGates * sizeof(int));
			free(Circuit->Gates);
			Circuit->Gates = TempGates;

			Circuit->Gates[Circuit->NumberOfGates] = Circuit->NumberOfCells + NumberOfCellsOffset;
			Circuit->NumberOfGates++;

			//if (!strcmp(Str1, "assign"))
			sprintf(Str2, "assign_%d", Circuit->NumberOfCells);
			Circuit->Cells[Circuit->NumberOfCells]->Name = (char *)malloc(Parser_Max_Name_Length);
			strncpy(Circuit->Cells[Circuit->NumberOfCells]->Name, Str2, Parser_Max_Name_Length - 1); // Str2 = "assign_%d"
			Circuit->Cells[Circuit->NumberOfCells]->Name[Parser_Max_Name_Length - 1] = '\0';

			SignalIndex = IOSignals[TempIndex];
			OutputIndex = 0;
			Circuit->Cells[Circuit->NumberOfCells]->Outputs[OutputIndex] = SignalIndex;
			if (SignalIndex >= Circuit->NumberOfConstants)
				Circuit->Cells[Circuit->NumberOfCells]->Outputs[OutputIndex] += NumberOfSignalsOffset;

			Circuit->Signals[SignalIndex]->Output = Circuit->NumberOfCells + NumberOfCellsOffset;

			InputPorts[TempIndex] = Circuit->NumberOfCells;
			Circuit->NumberOfCells++;
		}
	}
	else if (Task == Parser_Task_find_assign_signal_name2)
	{
		if (NumberOfIOSignals != NumberOfInputPorts)
		{
			printf("The size of the signal \"%s\" does not match to the connected signal\n", Str1);
			free(IOSignals);
			return 1;
		}

		for (TempIndex = 0; TempIndex < NumberOfIOSignals; TempIndex++)
		{
			SignalIndex = IOSignals[TempIndex];
			CellIndex = InputPorts[TempIndex];
			InputIndex = 0;
			Circuit->Cells[CellIndex]->Inputs[InputIndex] = SignalIndex;
			if (SignalIndex >= Circuit->NumberOfConstants)
				Circuit->Cells[CellIndex]->Inputs[InputIndex] += NumberOfSignalsOffset;

			Buffer_int = (int *)malloc((Circuit->Signals[SignalIndex]->NumberOfInputs + 1) * sizeof(int));
			memcpy(Buffer_int, Circuit->Signals[SignalIndex]->Inputs, Circuit->Signals[SignalIndex]->NumberOfInputs * sizeof(int));
			free(Circuit->Signals[SignalIndex]->Inputs);
			Circuit->Signals[SignalIndex]->Inputs = Buffer_int;

			Circuit->Signals[SignalIndex]->Inputs[Circuit->Signals[SignalIndex]->NumberOfInputs] = CellIndex + NumberOfCellsOffset;
			Circuit->Signals[SignalIndex]->NumberOfInputs++;
		}
	}
	else
	{
		if (NumberOfIOSignals != (NumberOfInputPorts + NumberOfOutputPorts))
		{
			printf("The size of the signal \"%s\" does not match to the connected port\n", Str1);
			free(IOSignals);
			return 1;
		}

		if (!SubCircuitRead)
		{
			for (TempIndex = 0; TempIndex < (NumberOfInputPorts + NumberOfOutputPorts); TempIndex++)
			{
				SignalIndex = IOSignals[TempIndex];
				if (TempIndex < NumberOfInputPorts)
				{
					InputIndex = InputPorts[TempIndex];
					Circuit->Cells[Circuit->NumberOfCells]->Inputs[InputIndex] = SignalIndex;
					if (SignalIndex >= Circuit->NumberOfConstants)
						Circuit->Cells[Circuit->NumberOfCells]->Inputs[InputIndex] += NumberOfSignalsOffset;

					Buffer_int = (int *)malloc((Circuit->Signals[SignalIndex]->NumberOfInputs + 1) * sizeof(int));
					memcpy(Buffer_int, Circuit->Signals[SignalIndex]->Inputs, Circuit->Signals[SignalIndex]->NumberOfInputs * sizeof(int));
					free(Circuit->Signals[SignalIndex]->Inputs);
					Circuit->Signals[SignalIndex]->Inputs = Buffer_int;

					Circuit->Signals[SignalIndex]->Inputs[Circuit->Signals[SignalIndex]->NumberOfInputs] = Circuit->NumberOfCells + NumberOfCellsOffset;
					Circuit->Signals[SignalIndex]->NumberOfInputs++;
				}
				else
				{
					OutputIndex = OutputPorts[TempIndex - NumberOfInputPorts];
					Circuit->Cells[Circuit->NumberOfCells]->Outputs[OutputIndex] = SignalIndex;
					if (SignalIndex >= Circuit->NumberOfConstants)
						Circuit->Cells[Circuit->NumberOfCells]->Outputs[OutputIndex] += NumberOfSignalsOffset;

					if (SignalIndex != -1)
					{
						Circuit->Signals[SignalIndex]->Output = Circuit->NumberOfCells + NumberOfCellsOffset;
						if (Library->CellTypes[CellTypeIndex]->GateOrReg == Parser_CellType_Reg)
							Circuit->Signals[SignalIndex]->Depth = 0;
					}
				}

				CurrentIO++;
			}
		}
		else
		{
			for (TempIndex = 0; TempIndex < (NumberOfInputPorts + NumberOfOutputPorts); TempIndex++)
			{
				SignalIndex = IOSignals[TempIndex];
				SignalIndexWithOffset = SignalIndex;
				if (SignalIndexWithOffset >= Circuit->NumberOfConstants)
					SignalIndexWithOffset += NumberOfSignalsOffset;

				if (TempIndex < NumberOfInputPorts)
					SignalIndex2WithOffset = SubCircuit->Inputs[InputPorts[TempIndex]];
				else
					SignalIndex2WithOffset = SubCircuit->Outputs[OutputPorts[TempIndex - NumberOfInputPorts]];

				SignalIndex2 = SignalIndex2WithOffset;
				if (SignalIndex2 >= Circuit->NumberOfConstants)
					SignalIndex2 -= NumberOfSignalsOffset;

				Circuit->Signals[SignalIndex2]->Type = Parser_SignalType_wire;

				if (SignalIndex != -1)
				{
					Buffer_int = (int *)malloc((Circuit->Signals[SignalIndex]->NumberOfInputs + Circuit->Signals[SignalIndex2]->NumberOfInputs) * sizeof(int));
					memcpy(Buffer_int, Circuit->Signals[SignalIndex]->Inputs, Circuit->Signals[SignalIndex]->NumberOfInputs * sizeof(int));
					free(Circuit->Signals[SignalIndex]->Inputs);
					Circuit->Signals[SignalIndex]->Inputs = Buffer_int;

					for (InputIndex = 0; InputIndex < Circuit->Signals[SignalIndex2]->NumberOfInputs; InputIndex++)
					{
						CellIndex = Circuit->Signals[SignalIndex2]->Inputs[InputIndex];
						Circuit->Signals[SignalIndex]->Inputs[Circuit->Signals[SignalIndex]->NumberOfInputs] = CellIndex;
						Circuit->Signals[SignalIndex]->NumberOfInputs++;

						CellIndex -= NumberOfCellsOffset;
						for (InputIndex2 = 0; InputIndex2 < Circuit->Cells[CellIndex]->NumberOfInputs; InputIndex2++)
							if (Circuit->Cells[CellIndex]->Inputs[InputIndex2] == SignalIndex2WithOffset)
								Circuit->Cells[CellIndex]->Inputs[InputIndex2] = SignalIndexWithOffset;
					}

					if (TempIndex >= NumberOfInputPorts)
					{
						CellIndex = Circuit->Signals[SignalIndex2]->Output;
						Circuit->Signals[SignalIndex]->Output = CellIndex;
						if (CellIndex != -1)
						{
							CellIndex -= NumberOfCellsOffset;

							for (OutputIndex2 = 0; OutputIndex2 < Circuit->Cells[CellIndex]->NumberOfOutputs; OutputIndex2++)
								if (Circuit->Cells[CellIndex]->Outputs[OutputIndex2] == SignalIndex2WithOffset)
									Circuit->Cells[CellIndex]->Outputs[OutputIndex2] = SignalIndexWithOffset;
						}
					}

					free(Circuit->Signals[SignalIndex2]->Inputs);
					Circuit->Signals[SignalIndex2]->Inputs = NULL;
					Circuit->Signals[SignalIndex2]->NumberOfInputs = 0;
					Circuit->Signals[SignalIndex2]->Deleted = 1;
				}

				CurrentIO++;
			}
		}
	}

	free(IOSignals);
	return 0;
}

//***************************************************************************************

int ReadDesignFile(char* InputVerilogFileName, char* MainModuleName,
	               Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit, unsigned char WithAttributes,
	               int NumberOfSignalsOffset = 0, int NumberOfCellsOffset = 0)
{
	FILE*				  DesignFile;
	char				  finished;
	char				  ReadSignalsFinished;
	int					  CellTypeIndex;
	int					  CaseIndex;
	char*				  Str1 = (char *)malloc(Parser_Max_Name_Length * sizeof(char));
	char*				  Str2 = (char *)malloc(Parser_Max_Name_Length * sizeof(char));
	char				  ch;
	int					  i, j;
    int             	  MyNumberofIO = 0;
    int             	  CurrentIO = 0;
    int             	  InputIndex = 0;
    int             	  OutputIndex = 0;
	int					  SignalIndex;
    int             	  CellIndex;
	int					  Index1, Index2, IndexUpwards;
	Parser_SignalStruct** TempSignals;
	int*			      TempInputs;
	int*			      TempOutputs;
	Parser_CellStruct**   TempCells;
	int*			      TempGates;
	int*			      TempRegs;
	char**			      NewAttributes = NULL;
	int				      NumberOfNewAttributes = 0;
	int				      NewAttributeIndex;
	int				      TempAttributeIndex;
	char**			      InputAttributes = NULL;
	int				      NumberOfInputAttributes = 0;
	char**			      OutputAttributes = NULL;
	int				      NumberOfOutputAttributes = 0;
	Parser_CircuitStruct  SubCircuit;
	char                  SubCircuitRead = 0;
    char*                 SubCircuitInstanceName = (char*)malloc(Parser_Max_Name_Length * sizeof(char));
    int*            	  InputPorts = NULL;
    int                   NumberOfInputPorts = 0;
    int*                  OutputPorts = NULL;
    int                   NumberOfOutputPorts = 0;
	char*                 Phrase = (char *)malloc(Parser_Max_Name_Length * sizeof(char));
	static char*          AttributeText = NULL;
	char                  Task;
	char                  IO_port_found = 0;
	char**			      Buffer_char;

	if (AttributeText == NULL)
		AttributeText = (char *)malloc(Parser_Max_Name_Length * 100 * sizeof(char)); // can be very long

	Circuit->NumberOfSignals = 0;
	Circuit->NumberOfOutputs = 0;
	Circuit->NumberOfInputs = 0;

	Circuit->NumberOfCells = 0;
	Circuit->NumberOfGates = 0;
	Circuit->NumberOfRegs = 0;

	// --------- adding 0 and 1 Circuit->Signals --------------

	Circuit->NumberOfSignals = 6;
	Circuit->NumberOfConstants = Circuit->NumberOfSignals;
	Circuit->Signals = (Parser_SignalStruct **)malloc(Circuit->NumberOfSignals * sizeof(Parser_SignalStruct *));

	Circuit->Signals[0] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[0]->Name = (char *)malloc(Parser_Max_Name_Length);
	strcpy(Circuit->Signals[0]->Name, "1'b0");
	Circuit->Signals[0]->Type = Parser_SignalType_wire;
	Circuit->Signals[0]->NumberOfInputs = 0;
	Circuit->Signals[0]->Inputs = NULL;
	Circuit->Signals[0]->Output = -1;
	Circuit->Signals[0]->Depth = 0;
	Circuit->Signals[0]->Attribute = (char*)calloc(1, sizeof(char));

	Circuit->Signals[1] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[1]->Name = (char *)malloc(Parser_Max_Name_Length);
	strcpy(Circuit->Signals[1]->Name, "1'b1");
	Circuit->Signals[1]->Type = Parser_SignalType_wire;
	Circuit->Signals[1]->NumberOfInputs = 0;
	Circuit->Signals[1]->Inputs = NULL;
	Circuit->Signals[1]->Output = -1;
	Circuit->Signals[1]->Depth = 0;
	Circuit->Signals[1]->Attribute = (char*)calloc(1, sizeof(char));

	Circuit->Signals[2] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[2]->Name = (char *)malloc(Parser_Max_Name_Length);
	strcpy(Circuit->Signals[2]->Name, "1'h0");
	Circuit->Signals[2]->Type = Parser_SignalType_wire;
	Circuit->Signals[2]->NumberOfInputs = 0;
	Circuit->Signals[2]->Inputs = NULL;
	Circuit->Signals[2]->Output = -1;
	Circuit->Signals[2]->Depth = 0;
	Circuit->Signals[2]->Attribute = (char*)calloc(1, sizeof(char));

	Circuit->Signals[3] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[3]->Name = (char *)malloc(Parser_Max_Name_Length);
	strcpy(Circuit->Signals[3]->Name, "1'h1");
	Circuit->Signals[3]->Type = Parser_SignalType_wire;
	Circuit->Signals[3]->NumberOfInputs = 0;
	Circuit->Signals[3]->Inputs = NULL;
	Circuit->Signals[3]->Output = -1;
	Circuit->Signals[3]->Depth = 0;
	Circuit->Signals[3]->Attribute = (char*)calloc(1, sizeof(char));

	Circuit->Signals[4] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[4]->Name = (char *)malloc(Parser_Max_Name_Length);
	strcpy(Circuit->Signals[4]->Name, "1'bx");
	Circuit->Signals[4]->Type = Parser_SignalType_wire;
	Circuit->Signals[4]->NumberOfInputs = 0;
	Circuit->Signals[4]->Inputs = NULL;
	Circuit->Signals[4]->Output = -1;
	Circuit->Signals[4]->Depth = 0;
	Circuit->Signals[4]->Attribute = (char*)calloc(1, sizeof(char));

	Circuit->Signals[5] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
	Circuit->Signals[5]->Name = (char *)malloc(Parser_Max_Name_Length);
	strcpy(Circuit->Signals[5]->Name, "1'hx");
	Circuit->Signals[5]->Type = Parser_SignalType_wire;
	Circuit->Signals[5]->NumberOfInputs = 0;
	Circuit->Signals[5]->Inputs = NULL;
	Circuit->Signals[5]->Output = -1;
	Circuit->Signals[5]->Depth = 0;
	Circuit->Signals[5]->Attribute = (char*)calloc(1, sizeof(char));

	//---------------------------------------------------------------------------------------------//
	//------------------- reading the Circuit->Signals from the design file --------------------------------//

	DesignFile = fopen(InputVerilogFileName, "rt");

	if (DesignFile == NULL)
	{
		printf("design file ""%s"" not found\n", InputVerilogFileName);
		free(Str1);
		free(Str2);
		free(Phrase);
		free(SubCircuitInstanceName);
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
						if (ProcessAttribute(AttributeText, NewAttributes, NumberOfNewAttributes))
						{
							printf("processing the attribute %s failed\n", AttributeText);
							fclose(DesignFile);
							free(Str1);
							free(Str2);
							free(Phrase);
							free(SubCircuitInstanceName);
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
							else if ((ch == ':') && (Str1[0] != '\\'))
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
								NewAttributeIndex = 0;
								IndexUpwards = (Index1 < Index2) ? 1 : -1;

								for (j = Index1;((IndexUpwards == 1) && (j <= Index2)) || ((IndexUpwards == -1) && (j >= Index2)); j += IndexUpwards)
								{
									if (Index1 != -1)
										sprintf(Str2, "%s[%d]", Str1, j);
									else
										sprintf(Str2, "%s", Str1);

									for (SignalIndex = 0; SignalIndex < Circuit->NumberOfSignals; SignalIndex++)
										if (!strcmp(Str2, Circuit->Signals[SignalIndex]->Name))
											break;

									if (SignalIndex < Circuit->NumberOfSignals)
									{
										if (!strcmp(Phrase, "input"))
										{
											if (Circuit->Signals[SignalIndex]->Type != Parser_SignalType_wire)
											{
												printf("Signal \"%s\" is defined multiple times\n", Str2);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(SubCircuitInstanceName);
												return 1;
											}
										}
										else if (!strcmp(Phrase, "output"))
										{
											if (Circuit->Signals[SignalIndex]->Type != Parser_SignalType_wire)
											{
												printf("Signal \"%s\" is defined multiple times\n", Str2);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(SubCircuitInstanceName);
												return 1;
											}
										}
										else // if (!strcmp(Phrase, "wire"))
										{
											if (Circuit->Signals[SignalIndex]->Type == Parser_SignalType_wire)
											{
												printf("Signal \"%s\" is defined multiple times\n", Str2);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(SubCircuitInstanceName);
												return 1;
											}
										}
									}
									else
									{
										TempSignals = (Parser_SignalStruct **)malloc((Circuit->NumberOfSignals + 1) * sizeof(Parser_SignalStruct *));
										memcpy(TempSignals, Circuit->Signals, Circuit->NumberOfSignals * sizeof(Parser_SignalStruct *));
										free(Circuit->Signals);
										Circuit->Signals = TempSignals;

										Circuit->Signals[Circuit->NumberOfSignals] = (Parser_SignalStruct *)malloc(sizeof(Parser_SignalStruct));
										Circuit->Signals[Circuit->NumberOfSignals]->Name = (char *)malloc(Parser_Max_Name_Length);
										strcpy(Circuit->Signals[Circuit->NumberOfSignals]->Name, Str2);
										Circuit->Signals[Circuit->NumberOfSignals]->NumberOfInputs = 0;
										Circuit->Signals[Circuit->NumberOfSignals]->Inputs = NULL;
										Circuit->Signals[Circuit->NumberOfSignals]->Output = -1;
										Circuit->Signals[Circuit->NumberOfSignals]->Deleted = 0;

										SignalIndex = Circuit->NumberOfSignals;
										Circuit->NumberOfSignals++;
									}

									if (!strcmp(Phrase, "input"))
									{
										Circuit->Signals[SignalIndex]->Type = Parser_SignalType_input;
										Circuit->Signals[SignalIndex]->Depth = 0;

										TempInputs = (int *)malloc((Circuit->NumberOfInputs + 1) * sizeof(int));
										memcpy(TempInputs, Circuit->Inputs, Circuit->NumberOfInputs * sizeof(int));
										free(Circuit->Inputs);
										Circuit->Inputs = TempInputs;

										Circuit->Inputs[Circuit->NumberOfInputs] = SignalIndex + NumberOfSignalsOffset;
										Circuit->NumberOfInputs++;

										if (NewAttributeIndex < NumberOfNewAttributes)
										{
											for (TempAttributeIndex = 0;TempAttributeIndex < NumberOfInputAttributes;TempAttributeIndex++)
												if (!strcmp(InputAttributes[TempAttributeIndex], NewAttributes[NewAttributeIndex]))
													break;

											if (TempAttributeIndex < NumberOfInputAttributes)
											{
												printf("douplicat attribute %s found for input %s\n", NewAttributes[NewAttributeIndex], Str2);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(SubCircuitInstanceName);
												return 1;
											}

											Circuit->Signals[SignalIndex]->Attribute = (char*)malloc((strlen(NewAttributes[NewAttributeIndex]) + 1) * sizeof(char));
											strcpy(Circuit->Signals[SignalIndex]->Attribute, NewAttributes[NewAttributeIndex]);

											if (strcmp(NewAttributes[NewAttributeIndex], "ref") && // add it to the list if it is not refresh nor control nor clock
												strcmp(NewAttributes[NewAttributeIndex], "con") &&
												strcmp(NewAttributes[NewAttributeIndex], "clk"))
											{
												Buffer_char = (char**)malloc((NumberOfInputAttributes + 1) * sizeof(char*));
												memcpy(Buffer_char, InputAttributes, NumberOfInputAttributes * sizeof(char*));
												free(InputAttributes);
												InputAttributes = Buffer_char;

												InputAttributes[NumberOfInputAttributes] = (char*)malloc((strlen(NewAttributes[NewAttributeIndex]) + 1) * sizeof(char));
												strcpy(InputAttributes[NumberOfInputAttributes], NewAttributes[NewAttributeIndex]);
												NumberOfInputAttributes++;
												NewAttributeIndex++;
											}
										}
										else if (!WithAttributes)
										{
											Circuit->Signals[SignalIndex]->Attribute = (char*)malloc((strlen("none") + 1)*sizeof(char));
											strcpy(Circuit->Signals[SignalIndex]->Attribute, "none");
										}
										else
										{
											printf("attribute of input %s not given\n", Str2);
											fclose(DesignFile);
											free(Str1);
											free(Str2);
											free(Phrase);
											free(SubCircuitInstanceName);
											return 1;
										}
									}
									else if (!strcmp(Phrase, "output"))
									{
										Circuit->Signals[SignalIndex]->Type = Parser_SignalType_output;
										Circuit->Signals[SignalIndex]->Depth = -1;

										TempOutputs = (int *)malloc((Circuit->NumberOfOutputs + 1) * sizeof(int));
										memcpy(TempOutputs, Circuit->Outputs, Circuit->NumberOfOutputs * sizeof(int));
										free(Circuit->Outputs);
										Circuit->Outputs = TempOutputs;

										Circuit->Outputs[Circuit->NumberOfOutputs] = SignalIndex + NumberOfSignalsOffset;
										Circuit->NumberOfOutputs++;

										if (NewAttributeIndex < NumberOfNewAttributes)
										{
											for (TempAttributeIndex = 0;TempAttributeIndex < NumberOfOutputAttributes;TempAttributeIndex++)
												if (!strcmp(OutputAttributes[TempAttributeIndex], NewAttributes[NewAttributeIndex]))
													break;

											if (TempAttributeIndex < NumberOfOutputAttributes)
											{
												printf("douplicat attribute %s found for output %s\n", NewAttributes[NewAttributeIndex], Str2);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(SubCircuitInstanceName);
												return 1;
											}

											Circuit->Signals[SignalIndex]->Attribute = (char*)malloc((strlen(NewAttributes[NewAttributeIndex]) + 1) * sizeof(char));
											strcpy(Circuit->Signals[SignalIndex]->Attribute, NewAttributes[NewAttributeIndex]);

											if (strcmp(NewAttributes[NewAttributeIndex], "ref") && // add it to the list if it is not refresh nor control not clock
												strcmp(NewAttributes[NewAttributeIndex], "con") &&
												strcmp(NewAttributes[NewAttributeIndex], "clk"))
											{
												Buffer_char = (char**)malloc((NumberOfOutputAttributes + 1) * sizeof(char*));
												memcpy(Buffer_char, OutputAttributes, NumberOfOutputAttributes * sizeof(char*));
												free(OutputAttributes);
												OutputAttributes = Buffer_char;

												OutputAttributes[NumberOfOutputAttributes] = (char*)malloc((strlen(NewAttributes[NewAttributeIndex]) + 1) * sizeof(char));
												strcpy(OutputAttributes[NumberOfOutputAttributes], NewAttributes[NewAttributeIndex]);
												NumberOfOutputAttributes++;
												NewAttributeIndex++;
											}
										}
										else if (!WithAttributes)
										{
											Circuit->Signals[SignalIndex]->Attribute = (char*)malloc((strlen("none") + 1)*sizeof(char));
											strcpy(Circuit->Signals[SignalIndex]->Attribute, "none");
										}
										else
										{
											printf("attribute of output %s not given\n", Str2);
											fclose(DesignFile);
											free(Str1);
											free(Str2);
											free(Phrase);
											free(SubCircuitInstanceName);
											return 1;
										}
									}
									else if ((!strcmp(Phrase, "wire")) && (SignalIndex == Circuit->NumberOfSignals -1))
									{
										Circuit->Signals[SignalIndex]->Type = Parser_SignalType_wire;
										Circuit->Signals[SignalIndex]->Depth = -1;
										Circuit->Signals[SignalIndex]->Attribute = (char*)calloc(1, sizeof(char));
									}
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

                                if ((ch == ' ') || (ch == ';') || (ch == '='))
								{
									if (j)
									{
										if (Task == Parser_Task_find_module_type)
										{
                                            if (!strcmp(Str1, "assign"))
                                                if (Library->BufferCellType > -1)
                                                {
                                                	CellTypeIndex = Library->BufferCellType;

                                                	SubCircuitRead = 0;
													NumberOfInputPorts = 0;
													free(InputPorts);
													InputPorts = NULL;
													NumberOfOutputPorts = 0;
													free(OutputPorts);
													OutputPorts = NULL;

                                                	Task = Parser_Task_find_assign_signal_name1;
												}
                                                else
                                                {
													printf("Buffer cell is not defined in the library for \"assign\" statements!");
													fclose(DesignFile);
													free(Str1);
													free(Str2);
													free(Phrase);
													free(SubCircuitInstanceName);
													return 1;
                                                }
                                            else
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

													for (InputIndex = 0;InputIndex < Circuit->Cells[Circuit->NumberOfCells]->NumberOfInputs; InputIndex++)
														Circuit->Cells[Circuit->NumberOfCells]->Inputs[InputIndex] = -1;

													for (OutputIndex = 0;OutputIndex < Circuit->Cells[Circuit->NumberOfCells]->NumberOfOutputs; OutputIndex++)
														Circuit->Cells[Circuit->NumberOfCells]->Outputs[OutputIndex] = -1;

													if (Library->CellTypes[CellTypeIndex]->GateOrReg == Parser_CellType_Gate)
													{
														Circuit->Cells[Circuit->NumberOfCells]->Depth = -1;
														TempGates = (int *)malloc((Circuit->NumberOfGates + 1) * sizeof(int));
														memcpy(TempGates, Circuit->Gates, Circuit->NumberOfGates * sizeof(int));
														free(Circuit->Gates);
														Circuit->Gates = TempGates;

														Circuit->Gates[Circuit->NumberOfGates] = Circuit->NumberOfCells + NumberOfCellsOffset;
														Circuit->NumberOfGates++;
													}
													else // Parser_CellType_Reg
													{
														Circuit->Cells[Circuit->NumberOfCells]->Depth = -1;
														TempRegs = (int *)malloc((Circuit->NumberOfRegs + 1) * sizeof(int));
														memcpy(TempRegs, Circuit->Regs, Circuit->NumberOfRegs * sizeof(int));
														free(Circuit->Regs);
														Circuit->Regs = TempRegs;

														Circuit->Regs[Circuit->NumberOfRegs] = Circuit->NumberOfCells + NumberOfCellsOffset;
														Circuit->NumberOfRegs++;
													}

													Task = Parser_Task_find_module_name;
													MyNumberofIO = Library->CellTypes[CellTypeIndex]->NumberOfInputs + Library->CellTypes[CellTypeIndex]->NumberOfOutputs;
													CurrentIO = 0;
													SubCircuitRead = 0;
												}
												else
												{
													SubCircuit.Signals = NULL;
													SubCircuit.NumberOfSignals = 0;
													SubCircuit.Inputs = NULL;
													SubCircuit.Outputs = NULL;
													SubCircuit.NumberOfInputs = 0;
													SubCircuit.NumberOfOutputs = 0;
													SubCircuit.NumberOfConstants = 0;
													SubCircuit.Cells = NULL;
													SubCircuit.NumberOfCells = 0;
													SubCircuit.Gates = NULL;
													SubCircuit.Regs = NULL;
													SubCircuit.NumberOfGates = 0;
													SubCircuit.NumberOfRegs = 0;
													SubCircuit.MaxDepth = 0;
													SubCircuit.CellsInDepth = NULL;
													SubCircuit.NumberOfCellsInDepth = NULL;

													if (ReadDesignFile(InputVerilogFileName, Str1, Library, &SubCircuit, 0,
																	   NumberOfSignalsOffset + Circuit->NumberOfSignals - Circuit->NumberOfConstants,
																	   NumberOfCellsOffset + Circuit->NumberOfCells))
													{
														printf("cell type or module ""%s"" not found\n", Str1);
														fclose(DesignFile);
														free(Str1);
														free(Str2);
														free(Phrase);
														free(SubCircuitInstanceName);
														return 1;
													}

													TempSignals = (Parser_SignalStruct **)malloc((Circuit->NumberOfSignals + SubCircuit.NumberOfSignals - SubCircuit.NumberOfConstants) * sizeof(Parser_SignalStruct *));
													memcpy(TempSignals, Circuit->Signals, Circuit->NumberOfSignals * sizeof(Parser_SignalStruct *));
													free(Circuit->Signals);
													Circuit->Signals = TempSignals;
													memcpy(&Circuit->Signals[Circuit->NumberOfSignals], &SubCircuit.Signals[SubCircuit.NumberOfConstants], (SubCircuit.NumberOfSignals - SubCircuit.NumberOfConstants) * sizeof(Parser_SignalStruct *));
													Circuit->NumberOfSignals += SubCircuit.NumberOfSignals - SubCircuit.NumberOfConstants;

													TempCells = (Parser_CellStruct **)malloc((Circuit->NumberOfCells + SubCircuit.NumberOfCells) * sizeof(Parser_CellStruct *));
													memcpy(TempCells, Circuit->Cells, Circuit->NumberOfCells * sizeof(Parser_CellStruct *));
													free(Circuit->Cells);
													Circuit->Cells = TempCells;
													memcpy(&Circuit->Cells[Circuit->NumberOfCells], SubCircuit.Cells, SubCircuit.NumberOfCells * sizeof(Parser_CellStruct *));
													Circuit->NumberOfCells += SubCircuit.NumberOfCells;

													TempGates = (int *)malloc((Circuit->NumberOfGates + SubCircuit.NumberOfGates) * sizeof(int));
													memcpy(TempGates, Circuit->Gates, Circuit->NumberOfGates * sizeof(int));
													free(Circuit->Gates);
													Circuit->Gates = TempGates;
													memcpy(&Circuit->Gates[Circuit->NumberOfGates], SubCircuit.Gates, SubCircuit.NumberOfGates * sizeof(int));
													Circuit->NumberOfGates += SubCircuit.NumberOfGates;

													TempRegs = (int *)malloc((Circuit->NumberOfRegs + SubCircuit.NumberOfRegs) * sizeof(int));
													memcpy(TempRegs, Circuit->Regs, Circuit->NumberOfRegs * sizeof(int));
													free(Circuit->Regs);
													Circuit->Regs = TempRegs;
													memcpy(&Circuit->Regs[Circuit->NumberOfRegs], SubCircuit.Regs, SubCircuit.NumberOfRegs * sizeof(int));
													Circuit->NumberOfRegs += SubCircuit.NumberOfRegs;

													MyNumberofIO = SubCircuit.NumberOfInputs + SubCircuit.NumberOfOutputs;
													CurrentIO = 0;
													SubCircuitRead = 1;
													Task = Parser_Task_find_module_name;
												}
											}
										}
										else if (Task == Parser_Task_find_module_name)
										{
                                            if (!SubCircuitRead)
											{
												Circuit->Cells[Circuit->NumberOfCells]->Name = (char *)malloc(Parser_Max_Name_Length);
												strcpy(Circuit->Cells[Circuit->NumberOfCells]->Name, Str1);
											}
                                            else
                                            {
												strcpy(SubCircuitInstanceName, Str1);

												for (SignalIndex = SubCircuit.NumberOfConstants; SignalIndex < SubCircuit.NumberOfSignals; SignalIndex++)
												{
													strcpy(Str1, "\\");
													strcat(Str1, SubCircuitInstanceName);
													strcat(Str1, ".");
													if (SubCircuit.Signals[SignalIndex]->Name[0] == '\\')
														strcat(Str1, SubCircuit.Signals[SignalIndex]->Name + 1);
													else
														strcat(Str1, SubCircuit.Signals[SignalIndex]->Name);

													strcpy(SubCircuit.Signals[SignalIndex]->Name, Str1);
												}

												for (CellIndex = 0; CellIndex < SubCircuit.NumberOfCells; CellIndex++)
												{
													strcpy(Str1, "\\");
													strcat(Str1, SubCircuitInstanceName);
													strcat(Str1, ".");
													if (SubCircuit.Cells[CellIndex]->Name[0] == '\\')
														strcat(Str1, SubCircuit.Cells[CellIndex]->Name + 1);
													else
														strcat(Str1, SubCircuit.Cells[CellIndex]->Name);

													strcpy(SubCircuit.Cells[CellIndex]->Name, Str1);
												}
											}

											Task = Parser_Task_find_open_bracket;
											IO_port_found = 0;
										}
										else if (Task == Parser_Task_find_IO_port)
										{
											if (Str1[0] == '.')
											{
												if (ReadDesignFile_Find_IO_Port(Str1, SubCircuitRead, CellTypeIndex, CaseIndex, Library, Circuit, NumberOfSignalsOffset,
											 					                SubCircuitInstanceName, &SubCircuit,
																                InputPorts, NumberOfInputPorts, OutputPorts, NumberOfOutputPorts))
                                                {
													printf("IO port ""%s"" not found in cell type ""%s""\n", Str1 + 1, Library->CellTypes[CellTypeIndex]->Cases[CaseIndex]);
													fclose(DesignFile);
													free(Str1);
													free(Str2);
													free(Phrase);
													free(SubCircuitInstanceName);
													return 1;
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
												free(SubCircuitInstanceName);
												return 1;
											}
										}
                                        else if ((Task == Parser_Task_find_signal_name) ||
                                                 (Task == Parser_Task_find_assign_signal_name1) ||
                                                 (Task == Parser_Task_find_assign_signal_name2))
										{
											if (ReadDesignFile_Find_Signal_Name(Str1, SubCircuitRead, CellTypeIndex, CaseIndex, Library, Circuit, Task,
																	            NumberOfSignalsOffset, NumberOfCellsOffset, SubCircuitInstanceName, &SubCircuit,
																	            InputPorts, NumberOfInputPorts, OutputPorts, NumberOfOutputPorts, CurrentIO))
											{
												printf("signal ""%s"" not found\n", Str1);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(SubCircuitInstanceName);
												return 1;
											}

                                            if (Task == Parser_Task_find_assign_signal_name1)
                                                if (ch == '=')
                                                    Task = Parser_Task_find_assign_signal_name2;
                                                else
                                                    Task = Parser_Task_find_equal;
                                            else if (Task == Parser_Task_find_assign_signal_name2)
                                                Task = -1; // to avoid incrementing NumberOfCells
                                            else
                                                Task = Parser_Task_find_close_bracket;
										}

										j = 0;
										Str1[0] = 0;
									}
                                    else if (ch == '=')
                                    {
                                        if (Task == Parser_Task_find_equal)
                                            Task = Parser_Task_find_assign_signal_name2;
                                        else
                                        {
											printf("= is placed in a wrong place\n");
											fclose(DesignFile);
											free(Str1);
											free(Str2);
											free(Phrase);
											free(SubCircuitInstanceName);
											return 1;
                                        }
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
											if (ReadDesignFile_Find_IO_Port(Str1, SubCircuitRead, CellTypeIndex, CaseIndex, Library, Circuit, NumberOfSignalsOffset,
											 					            SubCircuitInstanceName, &SubCircuit,
																            InputPorts, NumberOfInputPorts, OutputPorts, NumberOfOutputPorts))
											{
												printf("IO port ""%s"" did not found in cell type ""%s""\n", Str1 + 1, Library->CellTypes[CellTypeIndex]->Cases[0]);
												fclose(DesignFile);
												free(Str1);
												free(Str2);
												free(Phrase);
												free(SubCircuitInstanceName);
												return 1;
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
											free(SubCircuitInstanceName);
											return 1;
										}
									}
									else
									{
										printf("( is placed in a wrong place\n");
										fclose(DesignFile);
										free(Str1);
										free(Str2);
										free(Phrase);
										free(SubCircuitInstanceName);
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
										if (ReadDesignFile_Find_Signal_Name(Str1, SubCircuitRead, CellTypeIndex, CaseIndex, Library, Circuit, Task,
																	        NumberOfSignalsOffset, NumberOfCellsOffset, SubCircuitInstanceName, &SubCircuit,
																	        InputPorts, NumberOfInputPorts, OutputPorts, NumberOfOutputPorts, CurrentIO))
                                        {
											printf("signal ""%s"" not found\n", Str1);
											fclose(DesignFile);
											free(Str1);
											free(Str2);
											free(Phrase);
											free(SubCircuitInstanceName);
											return 1;
										}

										if (CurrentIO < MyNumberofIO)
											Task = Parser_Task_find_comma;
										else
											Task = Parser_Task_find_close_bracket;
									}
                                    else if (Task == Parser_Task_find_comma)
                                    {
										Str1[0] = 0;
										if (ReadDesignFile_Find_IO_Port(Str1, SubCircuitRead, CellTypeIndex, CaseIndex, Library, Circuit, NumberOfSignalsOffset,
											 					        SubCircuitInstanceName, &SubCircuit,
																        InputPorts, NumberOfInputPorts, OutputPorts, NumberOfOutputPorts))
										{
											fclose(DesignFile);
											free(Str1);
											free(Str2);
											free(Phrase);
											free(SubCircuitInstanceName);
											return 1;
										}

										Str1[0] = 0;
										if (ReadDesignFile_Find_Signal_Name(Str1, SubCircuitRead, CellTypeIndex, CaseIndex, Library, Circuit, Task,
																	        NumberOfSignalsOffset, NumberOfCellsOffset, SubCircuitInstanceName, &SubCircuit,
																	        InputPorts, NumberOfInputPorts, OutputPorts, NumberOfOutputPorts, CurrentIO))
										{
											fclose(DesignFile);
											free(Str1);
											free(Str2);
											free(Phrase);
											free(SubCircuitInstanceName);
											return 1;
										}

										Task = Parser_Task_find_close_bracket;
									}
									else
									{
										printf("\n) is placed in a wrong position\n");
										fclose(DesignFile);
										free(Str1);
										free(Str2);
										free(Phrase);
										free(SubCircuitInstanceName);
										return 1;
									}

									j = 0;
									Str1[0] = 0;
								}
                                else if ((ch == ',') && (Str1[0] != '{'))
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

                            if ((!SubCircuitRead) && (Task >= 0))
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
	free(SubCircuitInstanceName);

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
	if (((Circuit->Signals[InputSignal]->Type == Parser_SignalType_input) ||
		(Circuit->Signals[InputSignal]->Type == Parser_SignalType_output)) &&
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
			InputIndex = -1;
		}

	if (Circuit->Signals[OutputSignal]->Type == Parser_SignalType_output)
	{
		TempIndex = InputSignal;
		InputSignal = OutputSignal;
		OutputSignal = TempIndex;
	}

	TempInputs = (int *)malloc((Circuit->Signals[InputSignal]->NumberOfInputs + Circuit->Signals[OutputSignal]->NumberOfInputs) * sizeof(int));
	memcpy(TempInputs, Circuit->Signals[InputSignal]->Inputs, Circuit->Signals[InputSignal]->NumberOfInputs * sizeof(int));
	//free(Circuit->Signals[InputSignal]->Inputs);
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
	//free(Circuit->Signals[OutputSignal]->Inputs);
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
						((strcmp(Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Attribute, "clk") &&
						  strcmp(Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Attribute, "con")) ||
						 (Library->CellTypes[Circuit->Cells[CellIndex]->Type]->GateOrReg == Parser_CellType_Gate)) &&
						((Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Output != -1) ||
						 (Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Type == Parser_SignalType_input)))
						break;

				if (InputIndex == Circuit->Cells[CellIndex]->NumberOfInputs) // all inputs of the cell (except clock) are unconnected
				{
					Circuit->Cells[CellIndex]->Deleted = 1;

					for (InputIndex = 0;InputIndex < Circuit->Cells[CellIndex]->NumberOfInputs;InputIndex++)
						if (strcmp(Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Attribute, "clk") &&
							strcmp(Circuit->Signals[Circuit->Cells[CellIndex]->Inputs[InputIndex]]->Attribute, "con") &&
							(Circuit->Cells[CellIndex]->Inputs[InputIndex] >= Circuit->NumberOfConstants))
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

int MakeCircuitDepth(Parser_LibraryStruct* Library, Parser_CircuitStruct* Circuit)
{
	int		i;
	int		InputIndex;
	int		OutputIndex;
	int		SignalIndex;
	int		GateIndex;
	int		CellIndex;
	short	DepthIndex;
	char	all_have_depth;

	DepthIndex = 0;

	do {
		all_have_depth = 1;

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

				all_have_depth = 0;
			}
		}

		DepthIndex++;
	} while (!all_have_depth);

	Circuit->MaxDepth = DepthIndex;
	Circuit->CellsInDepth = (int **)malloc((Circuit->MaxDepth + 1) * sizeof(int *));
	Circuit->NumberOfCellsInDepth = (int *)calloc(Circuit->MaxDepth + 1, sizeof(int));

	for (CellIndex = 0;CellIndex < Circuit->NumberOfCells;CellIndex++)
		Circuit->NumberOfCellsInDepth[Circuit->Cells[CellIndex]->Depth]++;

	for (DepthIndex = 1;DepthIndex <= Circuit->MaxDepth;DepthIndex++)
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
	int		temp_index;
	int		DepthIndex;
	int		CellIndex;
	int*	TempSignalList;
	char	ShouldBeAdded;
	int		ThisCell_SignalIndex;
	int     tt;

	TempSignalList = (int *)malloc(Circuit->NumberOfSignals * 2 * sizeof(int));

	SignalIndex = 0;
	if (Parser_With_GND_and_VDD)
	{
		fprintf(OutFile, "in 0 0\n"); // gnd
		fprintf(OutFile, "in 1 1\n"); // vdd
		TempSignalList[SignalIndex++] = 0;
		TempSignalList[SignalIndex++] = 1;
	}

	OutFile = fopen(OutputFileName, "wt");

	for (InputIndex = 0;InputIndex < Circuit->NumberOfInputs;InputIndex++)
	{
		if (strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute, "con"))
		{
			if (!strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute, "clk"))
				Circuit->ClockSignalIndex = Circuit->Inputs[InputIndex];
			else
				if (strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute, "ref"))
				{
					TempSignalList[Circuit->Inputs[InputIndex]] = SignalIndex++;
					fprintf(OutFile, "in %d %s # %s\n", TempSignalList[Circuit->Inputs[InputIndex]], Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute, Circuit->Signals[Circuit->Inputs[InputIndex]]->Name);
				}
		}
	}

	for (InputIndex = 0;InputIndex < Circuit->NumberOfInputs;InputIndex++)
	{
		if (strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute, "con"))
		{
			if (!strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute, "clk"))
				Circuit->ClockSignalIndex = Circuit->Inputs[InputIndex];
			else
				if (!strcmp(Circuit->Signals[Circuit->Inputs[InputIndex]]->Attribute, "ref"))
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
					temp_index = Circuit->Cells[Circuit->CellsInDepth[DepthIndex][CellIndex]]->Inputs[InputIndex];

					if (strcmp(Circuit->Signals[temp_index]->Attribute, "con") &&
						strcmp(Circuit->Signals[temp_index]->Attribute, "clk"))
						fprintf(OutFile, " %d", TempSignalList[temp_index]);
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
		if (strcmp(Circuit->Signals[Circuit->Outputs[OutputIndex]]->Attribute, "con") &&
			strcmp(Circuit->Signals[Circuit->Outputs[OutputIndex]]->Attribute, "clk"))
		{
			temp_index = TempSignalList[Circuit->Outputs[OutputIndex]];
			fprintf(OutFile, "out %d %s # %s\n", temp_index, Circuit->Signals[Circuit->Outputs[OutputIndex]]->Attribute, Circuit->Signals[Circuit->Outputs[OutputIndex]]->Name);
		}
	}

	fclose(OutFile);

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
	//------------------- writing the customized file for Pascal tool -----------------------------//

	if (!res)
		res = WriteCustomizedFile(OutputFileName, &Library, &Circuit);

	return(res);
}

//***************************************************************************************

#ifdef VERILOG
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
#endif
