#!/bin/python3

import sys
import unicodedata

def limit_length(s, newlength):
    char_count = 0
    newstr = ""
    for c in s:
        char_count += 1
        if unicodedata.east_asian_width(c) == "W":
            char_count += 1
        if char_count <= newlength:
            newstr += c
        else:
            newstr = newstr + "..."
            break
    return newstr

original = sys.argv[1]
newlen = int(sys.argv[2])
newstr = limit_length(original, newlen)

print(newstr)
