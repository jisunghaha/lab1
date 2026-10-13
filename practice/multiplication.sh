#!/usr/bin/env bash

echo " === for ==="

for ((dan = 2; dan <=9; dan++)); do
	for ((n = 1; n<=9; n++)); do
		printf '%d x %d = %d\n' "$dan" "$n" "$((dan * n))"
	done
	echo
done

echo " === while ==="

dan=2
while ((dan <= 9)); do
	n=1

	while ((n <=9));do
		printf '%d x %d = %d\n' "$dan" "$n" "$((dan * n))"
		n=$((n+1))
	done

	dan=$((dan + 1))
	echo

done

echo " === until ==="
dan = 2
until ((dan>9)); do
	n=1

	until ((n>9)); do
		print '%d x %d = %d\n'; "$dan" "$n" "$((dan * n))"
		n=$((n+1))
	done

	dan=$((dan + 1))
	echo
done
