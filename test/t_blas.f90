
implicit none

  integer, parameter :: N = 2048
  integer :: i, j
  DOUBLE PRECISION :: A(N,N), B(N,N), C(N,N)

  DOUBLE PRECISION :: alpha, beta

  A(:,:)=2.;
  B(:,:)=3.;
  C(:,:)=3.;
  alpha=1.0; beta=2.0
  

!       do, j=1,N
!           write (*,*) A(i,j)
!       enddo
!   enddo
  call dgemm('N','N',N ,N ,N , alpha, A, N, B, N, beta, C, N)

!   print*, C(0,0)
!   do, i=1,N
!       do, j=1,N
!           write (*,*) C(i,j)
!       enddo
!   enddo
end    
!   DGEMM(TRANSA,TRANSB,M,N,K,ALPHA,A,LDA,B,LDB,BETA,C,LDC)

!  13 * .. Scalar Arguments ..
! 14 * DOUBLE PRECISION ALPHA,BETA
! 15 * INTEGER K,LDA,LDB,LDC,M,N
! 16 * CHARACTER TRANSA,TRANSB
! 17 * ..
! 18 * .. Array Arguments ..
! 19 * DOUBLE PRECISION A(LDA,*),B(LDB,*),C(LDC,*)
