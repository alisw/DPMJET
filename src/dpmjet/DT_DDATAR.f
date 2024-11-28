
      SUBROUTINE DT_DDATAR
 
      IMPLICIT NONE
      INTEGER i , ia , iaa , ib , ibb , ip , iv , j , l
      DOUBLE PRECISION ONE , TINY10 , ZERO
      SAVE 
 
#if defined(FLDOTINCL) && defined(FOR_FLUKA)
      INCLUDE 'inc/dtflka12ca'
#else
      INCLUDE 'inc/dtflka'
#endif
 
      PARAMETER (TINY10=1.0D-10,ONE=1.0D0,ZERO=0.0D0)
 
C quark-content to particle index conversion (DTUNUC 1.x)
      INCLUDE 'inc/dtq2id'
 
      DIMENSION iv(36) , ip(36) , ib(126) , ibb(126) , ia(126) , 
     &          iaa(126)
 
      DATA iv/33 , 34 , 38 , 123 , 0 , 0 , 32 , 33 , 39 , 124 , 0 , 0 , 
     &     36 , 37 , 96 , 127 , 0 , 0 , 126 , 125 , 128 , 129 , 14*0/
      DATA ip/23 , 14 , 16 , 116 , 0 , 0 , 13 , 23 , 25 , 117 , 0 , 0 , 
     &     15 , 24 , 31 , 120 , 0 , 0 , 119 , 118 , 121 , 122 , 14*0/
      DATA ib/0 , 1 , 21 , 140 , 0 , 0 , 8 , 22 , 137 , 0 , 0 , 97 , 
     &     138 , 0 , 0 , 146 , 0 , 0 , 0 , 0 , 0 , 1 , 8 , 22 , 137 , 
     &     0 , 0 , 0 , 20 , 142 , 0 , 0 , 98 , 139 , 0 , 0 , 147 , 0 , 
     &     0 , 0 , 0 , 0 , 21 , 22 , 97 , 138 , 0 , 0 , 20 , 98 , 139 , 
     &     0 , 0 , 0 , 145 , 0 , 0 , 148 , 0 , 0 , 0 , 0 , 0 , 140 , 
     &     137 , 138 , 146 , 0 , 0 , 142 , 139 , 147 , 0 , 0 , 145 , 
     &     148 , 50*0/
      DATA ibb/53 , 54 , 104 , 161 , 0 , 0 , 55 , 105 , 162 , 0 , 0 , 
     &     107 , 164 , 0 , 0 , 167 , 0 , 0 , 0 , 0 , 0 , 54 , 55 , 105 , 
     &     162 , 0 , 0 , 56 , 106 , 163 , 0 , 0 , 108 , 165 , 0 , 0 , 
     &     168 , 0 , 0 , 0 , 0 , 0 , 104 , 105 , 107 , 164 , 0 , 0 , 
     &     106 , 108 , 165 , 0 , 0 , 109 , 166 , 0 , 0 , 169 , 0 , 0 , 
     &     0 , 0 , 0 , 161 , 162 , 164 , 167 , 0 , 0 , 163 , 165 , 168 , 
     &     0 , 0 , 166 , 169 , 0 , 0 , 170 , 47*0/
      DATA ia/0 , 2 , 99 , 152 , 0 , 0 , 9 , 100 , 149 , 0 , 0 , 102 , 
     &     150 , 0 , 0 , 158 , 0 , 0 , 0 , 0 , 0 , 2 , 9 , 100 , 149 , 
     &     0 , 0 , 0 , 101 , 154 , 0 , 0 , 103 , 151 , 0 , 0 , 159 , 0 , 
     &     0 , 0 , 0 , 0 , 99 , 100 , 102 , 150 , 0 , 0 , 101 , 103 , 
     &     151 , 0 , 0 , 0 , 157 , 0 , 0 , 160 , 0 , 0 , 0 , 0 , 0 , 
     &     152 , 149 , 150 , 158 , 0 , 0 , 154 , 151 , 159 , 0 , 0 , 
     &     157 , 160 , 50*0/
      DATA iaa/67 , 68 , 110 , 171 , 0 , 0 , 69 , 111 , 172 , 0 , 0 , 
     &     113 , 174 , 0 , 0 , 177 , 0 , 0 , 0 , 0 , 0 , 68 , 69 , 111 , 
     &     172 , 0 , 0 , 70 , 112 , 173 , 0 , 0 , 114 , 175 , 0 , 0 , 
     &     178 , 0 , 0 , 0 , 0 , 0 , 110 , 111 , 113 , 174 , 0 , 0 , 
     &     112 , 114 , 175 , 0 , 0 , 115 , 176 , 0 , 0 , 179 , 0 , 0 , 
     &     0 , 0 , 0 , 171 , 172 , 174 , 177 , 0 , 0 , 173 , 175 , 178 , 
     &     0 , 0 , 176 , 179 , 0 , 0 , 180 , 47*0/
 
      l = 0
      DO i = 1 , 6
         DO j = 1 , 6
            l = l + 1
            IMPs(i,j) = ip(l)
            IMVe(i,j) = iv(l)
         END DO
      END DO
      l = 0
      DO i = 1 , 6
         DO j = 1 , 21
            l = l + 1
            IB08(i,j) = ib(l)
            IB10(i,j) = ibb(l)
            IA08(i,j) = ia(l)
            IA10(i,j) = iaa(l)
         END DO
      END DO
C     A1  = 0.88D0
C     B1  = 3.0D0
C     B2  = 3.0D0
C     B3  = 8.0D0
C     LT  = 0
C     LB  = 0
C     BET = 12.0D0
C     AS  = 0.25D0
C     B8  = 0.33D0
C     AME = 0.95D0
C     DIQ = 0.375D0
C     ISU = 4
 
      END SUBROUTINE
