subroutine call_sneut(nrow, den, temp, abar, zbar, pair, plas, phot, brem, recomb, snu, dsnudt, dsnudd, dsnuda, dsnudz)
include 'implno.dek'

integer, intent(in) :: nrow
double precision, intent(in), dimension(nrow) :: den, temp, abar, zbar
double precision, intent(out), dimension(nrow) :: pair, plas, phot, brem, recomb
double precision, dimension (nrow) :: total
double precision, intent(out), dimension(nrow) :: snu, dsnudt, dsnudd, dsnuda, dsnudz

!f2py INTEGER, INTENT(hide) :: nrow
!f2py DOUBLE PRECISION, DIMENSION(nrow), INTENT(in) :: den, temp, abar, zbar
!f2py DOUBLE PRECISION, DIMENSION(nrow), INTENT(out) :: pair, plas, phot, brem, recomb
!f2py DOUBLE PRECISION, DIMENSION(nrow), INTENT(out) :: snu, dsnudt, dsnudd, dsnuda, dsnudz

integer :: i

do i = 1, nrow

   call sneut4(temp(i),den(i),zbar(i),abar(i), &
        pair(i),plas(i),phot(i),brem(i),recomb(i),total(i))

   ! confusing that zbar, abar are in a different order
   call sneut5(temp(i),den(i),abar(i),zbar(i), &
        snu(i), dsnudt(i), dsnudd(i), dsnuda(i), dsnudz(i))

end do

end
