// Written in the D programming language.
// dmd 2.071.1
/*
dmd option
  -m32           generate 32 bit code
  -m32mscoff     generate 32 bit code and write MS-COFF object files
  -m64           generate 64 bit code
*/

import std.stdio;

int main()
{
	string s = "Hello! ";
	version(Win32)
	{
		s ~= "Win32";
	}
	else version(Win64)
	{
		s ~= "Win64";
	}
	else
	{
		s ~= "Win??";
	}
	s ~= "/";
	version(CRuntime_DigitalMars)
	{
		s ~= "CRuntime_DigitalMars";
	}
	version(CRuntime_Microsoft)
	{
		s ~= "CRuntime_Microsoft";
	}
	writeln(s);
	writeln("#");
	return 0;
}

