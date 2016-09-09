
## □DMD vs LDC ベンチマークテスト(Windows編)

LDC は LLVM という汎用コンパイラのフレームワーク?で
高速に実行されるコードの生成を行うのが特徴ですので、
DMD よりどれほど早くなるのか気になるところです。
ただし、LDC は残念ながら lld(LLVM 用のリンカ)は使っていないので
リンク時の最適化はできないと思っています。


## □今回の材料

1. dmd.2.071.1
1. ldc2-1.0.0
1. Windows 10 Home ver 1511 / build 10586.545


## □ベンチマークの方法

以下のような、たらいまわし関数[^1]を使います。
ベンチマークとしては数値の比較と再帰関数の呼び出しの速度計測を行います。


```d:tarai.d
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
```



[^1]:たらいまわし関数/竹内関数 https://ja.wikipedia.org/wiki/%E7%AB%B9%E5%86%85%E9%96%A2%E6%95%B0



## □ベンチマーク結果

たらいまわし関数を１０回計測した平均値をまとめました。Boldは最速値で数値の単位はミリ秒(ms)

DMDコンパイラは tarai_int は思ったより早いですが double の演算は w64を使うべきですね。
LDC は w64 は早いものの w32 はそれほど早くなくて意外です。
なお LDC の最適化オプション -O を付けると、たらいまわし関数が計測出来ないので最適化オプションは付けませんでした。



| Compiler-32/64             | tarai_int   | tarai_double |
|:---------------------------|:-----------:|:------------:|
|DMD/w32/DigitalMars runtime |1497         |5084          |
|DMD/w32/Microsoft runtime   |**1445**     |5122          |
|DMD/w64/Microsoft runtime   |1618         |1959          |
|LDC/w32                     |2185         |2947          |
|LDC/w64                     |1475         |**1897**      |
|*Clang/w64*                 |1670         |1640          |

- 数値の単位はmsec

## □ソースコード

```bat:Build.bat
@echo off
rem ---- DMD
path=C:\D\dmd.2.071.1\windows\bin;

dmd -O -inline -release -boundscheck=off -m32 -ofbenchmark32.exe benchmark.d
@if ERRORLEVEL 1 goto :eof
benchmark32.exe

dmd -O -inline -release -boundscheck=off -m32mscoff -ofbenchmark32mscoff.exe benchmark.d
@if ERRORLEVEL 1 goto :eof
benchmark32mscoff.exe

dmd -O -inline -release -boundscheck=off -m64 -ofbenchmark64.exe benchmark.d
@if ERRORLEVEL 1 goto :eof
benchmark64.exe

rem ---- LDC
path=C:\D\ldc2-1.0.0-win32-msvc\bin;c:\windows\system32;
ldc2 -release -boundscheck=off -m32 -ofbenchmark32_ldc.exe benchmark.d
@if ERRORLEVEL 1 goto :eof
benchmark32_ldc.exe

path=C:\D\ldc2-1.0.0-win64-msvc\bin;c:\windows\system32;
ldc2 -release -boundscheck=off -m64 -ofbenchmark64_ldc.exe benchmark.d
@if ERRORLEVEL 1 goto :eof
benchmark64_ldc.exe

rem ---- Clang
path=C:\D\Clang\bin;
clang -o benchmark_clang.exe benchmark.c
@if ERRORLEVEL 1 goto :eof
benchmark_clang.exe

echo done...
pause 

```


```d:benchmark.d
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
	void taki() {
		tarai(22, 11, 0);
	}
	void takd() {
		tarai_double(22.0, 11.0, 0.0);
	}
	xStopWatch s;
	s.benchMark("tarai int", 10, &taki);
	s.benchMark("tarai duble", 10, &takd);
	return 0;
}

```


```c:benchmark.c
/**
 * Written in the C programming language.
 * clang version 3.8.1 (branches/release_38)
 * Target: x86_64-pc-windows-msvc
 * Thread model: posix
 * InstalledDir: C:\D\Clang\bin
 *
 * http://llvm.org/releases/download.html
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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
		return tarai_double( tarai(x - 1.0, y, z), tarai_double(y - 1.0, z, x), tarai_double(z - 1.0, x, y) );
	}
}

int lcomp(const void *c1, const void *c2)
{
	long tmp1 = *(long *)c1;
	long tmp2 = *(long *)c2;
	
	if (tmp1 < tmp2) {
	  	return -1;
	}
	if (tmp1 == tmp2) {
	  	return  0;
	}
	if (tmp1 > tmp2) {
	  	return  1;
	}
	return 0;
}

/*
http://www.mm2d.net/main/prog/c/time-03.html

struct timespec {
  time_t tv_sec; // Seconds.
  long tv_nsec;  // Nanoseconds.
};

// 1sec = 1_000 msec = 1_000_000 usec = 1_000_000_000 nsec

*/

long long getTimeSpec()
{
	struct timespec ts;
	long long result;
	
	timespec_get(&ts, TIME_UTC);
	// clock_gettime(CLOCK_REALTIME, &ts1);
	result = (ts.tv_sec * 1000000000) + ts.tv_nsec;
	return result;
}

long getElapsed(long long start)
{
	long long result, end = getTimeSpec();
	
	result = end - start;
/*	printf("start : %lld\n", start);
	printf("end   : %lld\n", end);
	printf("result: %lld ns\n", result);
	printf("result: %lld ms\n", result / 1000000);
*/
	return result / 1000000; // to msec
}


#define LOOP5 10

void benchMark_int(void)
{
	long sw[LOOP5];
	printf("# tarai bench ----\n");
	
	for (int i = 0; i < LOOP5; i++) {
		long long start = getTimeSpec();
		tarai(22, 11, 0);
		sw[i] = getElapsed(start);
		// printf("%d: %ld\n", i, sw[i]);
	}
	qsort((void *)&sw, LOOP5, sizeof(long), lcomp);
	printf("fastest: %ldms\n", sw[0]);
	printf("worst  : %ldms\n", sw[LOOP5 - 1]);
	
	long total = 0;
	for (int i = 0; i < LOOP5; i++) {
		total += sw[i];
	}
	printf("average: %ldms\n", total / LOOP5);
}
void benchMark_double(void)
{
	long sw[LOOP5];
	printf("# taraid bench ----\n");
	
	for (int i = 0; i < LOOP5; i++) {
		long long start = getTimeSpec();
		tarai_double(22, 11, 0);
		sw[i] = getElapsed(start);
		// printf("%d: %ld\n", i, sw[i]);
	}
	qsort((void *)&sw, LOOP5, sizeof(long), lcomp);
	printf("fastest: %ldms\n", sw[0]);
	printf("worst  : %ldms\n", sw[LOOP5 - 1]);
	
	long total = 0;
	for (int i = 0; i < LOOP5; i++) {
		total += sw[i];
	}
	printf("average: %ldms\n", total / LOOP5);
}

int main()
{
	benchMark_int();
	benchMark_double();
	return 0;
}

```


## □参考リンク

-20の言語/環境でてきとうにベンチマークしてみた http://safx-dev.blogspot.jp/2015/11/20-rust-go-crystal-nim-swift.html


-------

-location https://github.com/SeijiFujita/quiita_works/tree/master/benchmark_dmd_ldc

tag: dlang, tarai
filename: using_m64.md
last update: 2016/08/24

