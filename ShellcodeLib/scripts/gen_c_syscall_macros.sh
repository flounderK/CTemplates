#!/bin/bash

for i in $(seq 0 512); do
    a=$(syscall_lookup $i | grep --color=never -Po '(?<=SYS_)(.+)$')
    signatures=$(syscall_searcher.py -s "^$a$" -r 'a')
	UNIQ_SIGNATURES=$(echo "$signatures" | sort | uniq)
    numsigs=$(echo "$UNIQ_SIGNATURES" | wc -l)
	SIGLEN=$(echo "$UNIQ_SIGNATURES" | wc -c)
	if [ "$SIGLEN" -eq 1 ]; then
		# echo "No sig found for $i" >/proc/self/fd/2
		continue
	fi
    if [ $numsigs -le 2 ]; then
        sig=$(echo "$UNIQ_SIGNATURES" | head -n1)
    else
		echo "$a has too many variations" >/proc/self/fd/2
        continue
    fi
	ARGS=$(echo "$sig" | grep --color=never -Po '([^()]+\))')
	NAME=$(echo "$sig" | grep --color=never -Po '^([^(]+)')
    printf "#define _%s _syscall(__NR_%s, %s\n" "$sig" "$NAME" "$ARGS"
done
