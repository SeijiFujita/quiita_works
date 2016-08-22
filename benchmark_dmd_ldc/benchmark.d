// Written in the D programming language.
// dmd 2.071.0


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
double tarai(double x, double y, double z)
{
	if (x <= y) {
		return z;
	} else {
		return tarai( tarai(x - 1, y, z), tarai(y - 1, z, x), tarai(z - 1, x, y) );
	}
}

void benchMark(void delegate() dg, string s)
{
	import std.stdio : writeln;
	import std.datetime : Clock;
	import std.algorithm.sorting : sort;
	
	long[] sw;
	writeln("# ", s, " bench ----");
	foreach (i; 0 .. 10) {
		long start = Clock.currStdTime() / 10000;
		//fib(40);
		//taraid(22.0, 11.0, 0);
		dg();
		long end = Clock.currStdTime() / 10000;
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

int main()
{
	void taki() {
		tarai(22, 11, 0);
	}
	void takd() {
		tarai(22.0, 11.0, 0.0);
	}
	
	benchMark(&taki, "tarai int");
	benchMark(&takd, "tarai duble");
	return 0;
}
