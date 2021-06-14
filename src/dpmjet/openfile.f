      SUBROUTINE DPMJET_OPENINP()
*
*----------------------------------------------------------------------*
* Opens a file with a given unit number
*
*
* IOUNIT: Input unit to be assiged to the file
* FILNAM: Name of the file
*
*----------------------------------------------------------------------*
*
      IMPLICIT NONE
      LOGICAL EXISTS
      INTEGER LNROOT
      INTEGER LNBLNK
      CHARACTER*1000 FILNAM
      CHARACTER*1000 CHROOT
*----------------------------------------------------------------------*
C  input/output channels
      INCLUDE 'inc/dtflka'
*----------------------------------------------------------------------*
      CHROOT=' '
      CALL GETENV('DPMJET_ROOT',CHROOT)
      LNROOT = LNBLNK(CHROOT)
      IF(LNROOT.LE.0) THEN
         FILNAM='dpmjet.dat'
      ELSE
         FILNAM=CHROOT(1:LNROOT)//'/dpmdata/dpmjet.dat'
      ENDIF
      INQUIRE(FILE=FILNAM,EXIST=EXISTS)
      IF(.NOT.EXISTS) THEN
         PRINT*,'***********************************'
         PRINT*,'*           openfile              *'
         PRINT*,'*        ---------------          *'
         PRINT*,'*   File dpmjet.dat not found     *'
         PRINT*,'*         Program STOP            *'
         PRINT*,'*  Check DPMJET_ROOT environment  *'
         PRINT*,'*           variable              *'
         PRINT*,'***********************************'
         STOP
      ENDIF
      LINp = 10
      OPEN (LINp, FILE="dpmjet.inp", STATUS="OLD")
      LDAt = 23
      OPEN (LDAt, FILE=FILNAM, STATUS="OLD")
*
      CALL PHOJET_OPENINP()
*      
      RETURN
      END
      SUBROUTINE PHOJET_OPENINP()
*
*----------------------------------------------------------------------*
* Opens a file with a given unit number
*
*
* IOUNIT: Input unit to be assiged to the file
* FILNAM: Name of the file
*
*----------------------------------------------------------------------*
*
      IMPLICIT NONE
      LOGICAL EXISTS
      INTEGER LNROOT
      INTEGER LNBLNK
      CHARACTER*1000 CHROOT
*----------------------------------------------------------------------*
C  input/output channels
      INCLUDE 'inc/poinou'
*----------------------------------------------------------------------*
      CHROOT=' '
      CALL GETENV('DPMJET_ROOT',CHROOT)
      LNROOT = LNBLNK(CHROOT)
      IF(LNROOT.LE.0) THEN
         DATDir='dpmdata/'
         LENDir=8
      ELSE
         DATDir=CHROOT(1:LNROOT)//'/dpmdata/'
         LENDir=LNROOT+9
      ENDIF
      RETURN
      END
