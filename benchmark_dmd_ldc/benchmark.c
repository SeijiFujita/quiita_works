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
		return tarai_double( tarai_double(x - 1.0, y, z), tarai_double(y - 1.0, z, x), tarai_double(z - 1.0, x, y) );
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


#define BENCHMARK_LOOP 10

void benchMark_int(void)
{
	long sw[BENCHMARK_LOOP];
	printf("# tarai bench ----\n");
	
	for (int i = 0; i < BENCHMARK_LOOP; i++) {
		long long start = getTimeSpec();
		tarai(22, 11, 0);
		sw[i] = getElapsed(start);
		// printf("%d: %ld\n", i, sw[i]);
	}
	qsort((void *)&sw, BENCHMARK_LOOP, sizeof(long), lcomp);
	printf("fastest: %ldms\n", sw[0]);
	printf("worst  : %ldms\n", sw[BENCHMARK_LOOP - 1]);
	
	long total = 0;
	for (int i = 0; i < BENCHMARK_LOOP; i++) {
		total += sw[i];
	}
	printf("average: %ldms\n", total / BENCHMARK_LOOP);
}
void benchMark_double(void)
{
	long sw[BENCHMARK_LOOP];
	printf("# taraid bench ----\n");
	
	for (int i = 0; i < BENCHMARK_LOOP; i++) {
		long long start = getTimeSpec();
		tarai_double(22, 11, 0);
		sw[i] = getElapsed(start);
		// printf("%d: %ld\n", i, sw[i]);
	}
	qsort((void *)&sw, BENCHMARK_LOOP, sizeof(long), lcomp);
	printf("fastest: %ldms\n", sw[0]);
	printf("worst  : %ldms\n", sw[BENCHMARK_LOOP - 1]);
	
	long total = 0;
	for (int i = 0; i < BENCHMARK_LOOP; i++) {
		total += sw[i];
	}
	printf("average: %ldms\n", total / BENCHMARK_LOOP);
}

int main()
{
	benchMark_int();
	benchMark_double();
	return 0;
}
