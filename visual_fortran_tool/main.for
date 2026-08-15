C     VISUAL FORTRAN TOOL IMPLEMENTATION
C     Demonstrates classic Fortran 77/90 compatible syntax with Visual extensions.
      PROGRAM VisualFortranTool
C     Implicit typing disabled for safety (implicit none)
      IMPLICIT NONE

C     Declare variables
      INTEGER :: errorCode
      CHARACTER(LEN=80) :: message

C     Initialize program state
      errorCode = 0
      message = 'Visual Fortran Tool Initialized Successfully.'

C     Print status message
      WRITE(*, '(A)') message

C     Demonstrate a simple loop
      INTEGER :: i
      WRITE(*, '(A, I3, A)') 'Iterating from 1 to 5:', 1, '...'
      DO i = 1, 5
         WRITE(*, '(A, I1)') '   Count: ', i
      END DO

C     Demonstrate conditional logic
      WRITE(*, '(A)') 'Checking condition...'
      IF (errorCode .EQ. 0) THEN
         WRITE(*, '(A)') 'Status: OK - No errors detected.'
      ELSE
         WRITE(*, '(A, I0)') 'Status: ERROR - Code: ', errorCode
      END IF

C     End of program
      STOP
      END PROGRAM VisualFortranTool
