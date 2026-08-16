NAME "MatrixProcessor"

#include "console.i"

PROC printMatrix(name[], m, n, ARRAY a[:][:])
VAR i, j
 Console_Output(name)
 FOR i=0 TO m-1
  FOR j=0 TO n-1
   Console_Output(" "+Str(Long(a[i][j])))
  NEXT
  Console_Output("\n")
 NEXT
 Console_Output("\n")
END

PROC main()
VAR m1[3][3], m2[3][3], sum[3][3], prod[3][3], result[3][3]
VAR i, j, k

 Console_Open()

 ; Initialize matrices
 FOR i=0 TO 2
  FOR j=0 TO 2
   m1[i][j] = i*3 + j + 1
   m2[i][j] = (i+1)*(j+1)
  NEXT
 NEXT

 ; Print input matrices
 printMatrix("Matrix 1:", 3, 3, m1)
 printMatrix("Matrix 2:", 3, 3, m2)

 ; Calculate sum
 FOR i=0 TO 2
  FOR j=0 TO 2
   sum[i][j] = m1[i][j] + m2[i][j]
  NEXT
 NEXT
 printMatrix("Sum:", 3, 3, sum)

 ; Calculate product
 FOR i=0 TO 2
  FOR j=0 TO 2
   result[i][j] = 0
   FOR k=0 TO 2
    result[i][j] += m1[i][k] * m2[k][j]
   NEXT
  NEXT
 NEXT
 printMatrix("Product:", 3, 3, result)

 Console_Close()
END
