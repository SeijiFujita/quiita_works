// Written in the D programming language.
// dmd 2.071.1

/*
 tarai
 ベンチマークとしては再帰関数の呼び出し(戻り)の速度計測
 https://ja.wikipedia.org/wiki/%E7%AB%B9%E5%86%85%E9%96%A2%E6%95%B0

 tak(22, 11, 0);
*/
int tarai(int x, int y, int z)
{
	if (x <= y) {
		return z;
	} else {
		return tarai( tarai(x - 1, y, z), tarai(y - 1, z, x), tarai(z - 1, x, y) );
	}
}
double tarai_double(double x, double y, double z)
{
	if (x <= y) {
		return z;
	} else {
		return tarai_double( tarai_double(x - 1.0, y, z), tarai_double(y - 1.0, z, x), tarai_double(z - 1.0, x, y) );
	}
}

struct xStopWatch
{
	import std.conv;
	import core.time;
	import std.datetime : StopWatch;
	
private:
	StopWatch timer;
	long[] array;

	void start() {
		timer.start();
	}
	auto stop() {
		timer.stop();
		long result = timer.peek().to!("msecs", long)();
		array ~= result;
		timer.reset();
		return result;
	}
	
	void sort() {
		import std.algorithm.sorting : sort, isSorted;
		if (!isSorted(array))
			sort(array);
	}
	auto fastest() {
		sort();
		return array[0];
	}
	auto worst() {
		sort();
		return array[$-1];
	}
	auto average() {
		long total;
		foreach (v; array)
			total += v;
		return total / array.length;
	}
	
	public void benchMark(string title, int loop, void delegate() dg) {
		import std.stdio : writeln;
		
		writeln("# ", title, " ", buildID(), " bench ----");
		foreach (i; 0 .. loop) {
			start();
			dg();
			version (ProgressView) {
				writeln(i, ": ", stop());
			} else {
				stop();
			}
		}
		writeln("fastest: ", fastest(), "ms");
		writeln("worst  : ", worst(), "ms");
		writeln("average: ", average(), "ms");
		array.length = 0;
	}
}

string buildID()
{
	string s;
	
	version(DigitalMars) {
		s ~= "DMD";
	} else version (LDC) {
		s ~= "LDC";
	} else version(GDC) {
		s ~= "GDC";
	} else {
		s ~= "n/a";
	}
	s ~= "/";
	version(Win32) {
		s ~= "Win32";
	} else version(Win64) {
		s ~= "Win64";
	} else {
		s ~= "Win??";
	}
	s ~= "/";
	version(CRuntime_DigitalMars) {
		s ~= "CRuntime_DigitalMars";
	} 
	version(CRuntime_Microsoft) {
		s ~= "CRuntime_Microsoft";
	}
	return s;
}

int main()
{
	enum int BENCHMARK_LOOP = 10;
	void taki() {
		tarai(22, 11, 0);
	}
	void takd() {
		tarai_double(22.0, 11.0, 0.0);
	}
	xStopWatch s;
	s.benchMark("tarai int", BENCHMARK_LOOP, &taki);
	s.benchMark("tarai duble", BENCHMARK_LOOP, &takd);
	return 0;
}

version (none) {

/*
 フィボナッチ数列
 ベンチマークとしては再帰関数の呼び出し(戻り)の速度計測

 https://ja.wikipedia.org/wiki/%E3%83%95%E3%82%A3%E3%83%9C%E3%83%8A%E3%83%83%E3%83%81%E6%95%B0

 fib(40)
*/
int fib(int n)
{
	if (n <= 1) {
		return n;
	}
	return fib(n - 1) + fib(n - 2);
}

void benchMark_org(string title, void delegate() dg)
{
	import std.stdio : writeln;
	import std.datetime : Clock;
	import std.algorithm.sorting : sort;
	
	long[] sw;
	writeln("# ", title, " bench ----");
	foreach (i; 0 .. 5) {
		long start = Clock.currStdTime() / 10_000;
		//fib(40);
		//taraid(22.0, 11.0, 0);
		dg();
		long end = Clock.currStdTime() / 10_000;
		long result = end - start;
		sw ~= result;
		writeln(i, ": ", result);
	}
	sort(sw);
	writeln("1st: ", sw[0], "ms");
	writeln("wst: ", sw[$-1], "ms");
	
	long total;
	foreach (v; sw) {
		total += v;
	}
	writeln("ave: ", total / sw.length, "ms");
	
}

void benchMark_old(string title, void delegate() dg)
{
	import std.conv;
	import core.time;
	import std.datetime : StopWatch;
	import std.algorithm.sorting : sort;
	import std.stdio : writeln;
	
	StopWatch timer;
	long[] tarray;
	
	writeln("# ", title, " ", buildID(), " bench ----");
	foreach (i; 0 .. 5) {
		timer.start();
		//fib(40);
		//taraid(22.0, 11.0, 0);
		dg();
		timer.stop();
		long result = timer.peek().to!("msecs", long);
		tarray ~= result;
		writeln(i, ": ", result);
		timer.reset();
	}
	sort(tarray);
	writeln("1st: ", tarray[0], "ms");
	writeln("wst: ", tarray[$-1], "ms");
	
	long total;
	foreach (v; tarray) {
		total += v;
	}
	writeln("ave: ", total / tarray.length, "ms");
}
} // version (none)
