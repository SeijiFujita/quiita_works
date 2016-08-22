// Written in the D programming language.
// dmd 2.071.0
/*
dmd option
  -m32           generate 32 bit code
  -m32mscoff     generate 32 bit code and write MS-COFF object files
  -m64           generate 64 bit code
*/

import std.stdio;

int main()
{
	version(Win32)
	{
		writeln("Win32");
	}
	else version(Win64)
	{
		writeln("Win64");
	}
	else
	{
		writeln("Win??");
	}
	
	version(CRuntime_DigitalMars)
	{
		writeln("CRuntime_DigitalMars");
	}
	version(CRuntime_Microsoft)
	{
		writeln("CRuntime_Microsoft");
	}
	writeln("##------------------");
	return 0;
}

