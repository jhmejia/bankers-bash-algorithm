# bankers-bash-algorithm
## A BASH Script for Banker's Algorithm
### by John Henry Mejia 

usage: ./banker [inputfile.txt]

The input file format is the following:

- number of processes and number of resource types: n m
- 1 x m resource vector
- 1 x m available vector 
- n x m maximum matrix 
- n x m allocation matrix 
- i : 1 x m request vector 


## Examples
### Example 1
#### Input
```text
4 3

9 3 6

1 1 2

3 3 2
6 3 3
3 3 4
4 3 2

1 0 0
5 1 1
2 1 1
0 0 2

0:1 0 1 
```
#### Output
```text
There are 4 processes and 3 resource types in the system.

The Resource Vector is:
A B C
9 3 6

The Available Vector is:
A B C
1 1 2

The Max Matrix is:
   A B C 
0: 3 3 2 
1: 6 3 3
2: 3 3 4
3: 4 3 2

The Allocation Matrix is:
   A B C
0: 1 0 0
1: 5 1 1
2: 2 1 1
3: 0 0 2

The Need Matrix is:
   A B C
0: 2 3 2
1: 1 2 2
2: 1 2 3
3: 4 3 0

THE SYSTEM IS NOT IN A SAFE STATE
```

### Example 2
#### Input
```text
4 3

9 3 6

1 1 2

3 2 2
6 1 3
3 1 4
4 2 2

1 0 0
5 1 1
2 1 1
0 0 2

0:1 0 1 
```
#### Output
```text
There are 4 processes and 3 resource types in the system.

The Resource Vector is:
A B C
9 3 6

The Available Vector is:
A B C
1 1 2

The Max Matrix is:
   A B C 
0: 3 2 2 
1: 6 1 3
2: 3 1 4
3: 4 2 2

The Allocation Matrix is:
   A B C
0: 1 0 0
1: 5 1 1
2: 2 1 1
3: 0 0 2

The Need Matrix is:
   A B C
0: 2 2 2
1: 1 0 2
2: 1 0 3
3: 4 2 0

THE SYSTEM IS IN A SAFE STATE

The Request Vector is:
  A B C
0:1 0 1

THE REQUEST CANNOT BE GRANTED
```
### Example 3
#### Input
```text
4 3

9 3 6

1 1 2

3 2 2
6 1 3
3 1 4
4 2 2

1 0 0
5 1 1
2 1 1
0 0 2

1:1 0 1 
```
#### Output
```text
There are 4 processes and 3 resource types in the system.

The Resource Vector is...
A B C
9 3 6

The Available Vector is...
A B C
1 1 2

The Max Matrix is...
   A B C 
0: 3 2 2 
1: 6 1 3
2: 3 1 4
3: 4 2 2

The Allocation Matrix is...
   A B C
0: 1 0 0
1: 5 1 1
2: 2 1 1
3: 0 0 2

The Need Matrix is...
   A B C
0: 2 2 2
1: 1 0 2
2: 1 0 3
3: 4 2 0

THE SYSTEM IS IN A SAFE STATE

The Request Vector is...
  A B C
1:1 0 1

THE REQUEST CAN BE GRANTED: NEW STATE FOLLOWS

The Resource Vector is...
A B C
9 3 6

The Available Vector is...
A B C
0 1 1

The Max Matrix is...
   A B C 
0: 3 2 2 
1: 6 1 3
2: 3 1 4
3: 4 2 2

The Allocation Matrix is...
   A B C
0: 1 0 0
1: 6 1 2
2: 2 1 1
3: 0 0 2

The Need Matrix is...
   A B C
0: 2 2 2
1: 0 0 1
2: 1 0 3
3: 4 2 0
```

