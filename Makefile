.RECIPEPREFIX := >

CC = gcc
CFLAGS = -Wall -Wextra -g -O0 -Ilib

.PHONY: all run profile memcheck clean

all: bin/static_test bin/shared_test bin/dynamic_test

build bin reports:
>mkdir -p $@

# 소스 파일을 목적 파일로 변환
build/calc.o: lib/calc.c lib/calc.h | build
>$(CC) $(CFLAGS) -c $< -o $@

build/main.o: src/main.c lib/calc.h | build
>$(CC) $(CFLAGS) -c $< -o $@

build/dynamic.o: src/dynamic.c | build
>$(CC) $(CFLAGS) -c $< -o $@

# 정적 라이브러리와 실행 파일
lib/libcalc.a: build/calc.o
>ar rcs $@ $^

bin/static_test: build/main.o lib/libcalc.a | bin
>$(CC) $(CFLAGS) $^ -o $@

# 공유 라이브러리와 실행 파일
build/calc_pic.o: lib/calc.c lib/calc.h | build
>$(CC) $(CFLAGS) -fPIC -c $< -o $@

lib/libcalc.so: build/calc_pic.o
>$(CC) -shared $< -o $@

bin/shared_test: build/main.o lib/libcalc.so | bin
>$(CC) $(CFLAGS) build/main.o -Llib -lcalc -Wl,-rpath,'$$ORIGIN/../lib' -o $@

# 동적 로딩 실행 파일
bin/dynamic_test: build/dynamic.o | bin
>$(CC) $(CFLAGS) $< -ldl -o $@

run: all
>./bin/static_test
>./bin/shared_test
>./bin/dynamic_test

# 11번: gprof 전용 빌드
build/main_pg.o: src/main.c lib/calc.h | build
>$(CC) $(CFLAGS) -pg -c $< -o $@

build/calc_pg.o: lib/calc.c lib/calc.h | build
>$(CC) $(CFLAGS) -pg -c $< -o $@

lib/libcalc_pg.a: build/calc_pg.o
>ar rcs $@ $^

bin/profile_test: build/main_pg.o lib/libcalc_pg.a | bin
>$(CC) $(CFLAGS) -pg $^ -o $@

profile: bin/profile_test | reports
>cd reports && ../bin/profile_test
>gprof bin/profile_test reports/gmon.out > reports/gprof.txt

# 11번: 메모리 검사
memcheck: all | reports
>valgrind --leak-check=full --error-exitcode=1 --log-file=reports/valgrind-static.txt ./bin/static_test
>valgrind --leak-check=full --error-exitcode=1 --log-file=reports/valgrind-shared.txt ./bin/shared_test
>valgrind --leak-check=full --error-exitcode=1 --log-file=reports/valgrind-dynamic.txt ./bin/dynamic_test

clean:
>rm -rf build bin
>rm -f lib/libcalc.a lib/libcalc.so lib/libcalc_pg.a
