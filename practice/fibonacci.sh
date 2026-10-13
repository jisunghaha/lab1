#!/usr/bin/env bash

# F0부터 출력할 항의 수. 기본값은 10.
n=${1:-10}

# 64비트 Bash 정수 범위에서 F0~F92까지만 출력한다.
if [[ ! "$n" =~ ^([1-9]|[1-8][0-9]|9[0-3])$ ]]; then
    echo "사용법: $0 [1~93 사이의 항 개수]" >&2
    exit 1
fi

a=0
b=1

for ((i = 0; i < n; i++)); do
    printf '%s' "$a"

    if ((i < n - 1)); then
        printf ' '

        # 마지막 갱신에서는 불필요한 F93 계산을 피한다.
        if ((i == n - 2)); then
            let "a = b"
        else
            let "next = a + b"
            let "a = b"
            let "b = next"
        fi
    fi
done

printf '\n'
