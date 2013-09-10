! !euclid.f (FORTRAN 77)
! !     Find greatest common divisor using the Euclidean algorithm
!  
!       program EUCLID
!         PRINT *, 'A?'
!         READ *, NA
!         IF (NA.LE.0) THEN
!           PRINT *, 'A must be a positive integer.'
!           STOP
!         END IF
!         PRINT *, 'B?'
!         READ *, NB
!         IF (NB.LE.0) THEN
!           PRINT *, 'B must be a positive integer.'
!           STOP
!         END IF
!         PRINT *, 'The GCD of', NA, ' and', NB, ' is', NGCD(NA, NB), '.'
!         STOP
!       END
!  
!       FUNCTION NGCD(NA, NB)
!         IA = NA
!         IB = NB
!     1   IF (IB.NE.0) THEN
!           ITEMP = IA
!           IA = IB
!           IB = MOD(ITEMP, IB)
!           GOTO 1
!         END IF
!         NGCD = IA
!         RETURN
!       END

! 
        program EUCLID
        
          character*1 jobz, uplo
!           integer n,lda,lwork,info
          double precision, allocatable a(:,:)
!           double precision, allocatable w(:)
!           double precision, allocatable, work(:)
!           double precision wwork
        
          N = 1000
          lda=1000
          jobz='V'
          uplo='U'
        !   allocate(a(lda,n))
        !   ... code to fill matrix a ...
        !   allocate(w(n))
        !   lwork = -1       ! workspace query
        !   call dsyev(jobz, uplo, n, a, lda, w, wwork, lwork, info)
        !   lwork = wwork+0.1
        !   ! now the real work:
        !   allocate(work(lwork))
        !   call dsyev(jobz, uplo, n, a, lda, w, work, lwork, info)
        !   deallocate(work)
        END