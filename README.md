Problem #1 Write a function that takes an array of numbers and the length of the array. The array of numbers of can of any length with the numbers being any size. Your function should (a) report the range of the numbers (i.e. min and max), (b) print to screen a list of all numbers within the range that are missing from the array (c) print the count of all numbers that appear 2 or more times within the array.
For example: if given [3, 1, -5, 3, 3, -5, 0, 10, 1, 1] and the corresponded array length of 10, we would output the following:
Range is -5 to 10
Missing Numbers:
-4
-3
-2
-1
2
4
5
6
7
8
9
Duplicate Numbers:
3 appears 3 times
1 appears 3 times
-5 appears 2 times
Rules for Problem #1:
a) You may use any data structures you would like, and you may use data structure libraries (for example you may use a Standard Library Linked List if you think that is the right data structure to use). If you use a dynamically-typed language such as PHP, for each variable you use please indicate what data structure it would be if you were usually a statically-type language (e.g. set, array, linked list, etc).
b) You may not use any helper functions such as min(), max(), find(), etc
c) No sorting is allowed
d) Must be linear time O(N), so no nested loops are allowed
e) Must be memory efficient, so for input of [1, -100000, 100000], if you allocate a data structure like int [100000], you are doing something wrong, since you are using memory of sizeof(int)*100000 even though the input array only has 3 ints