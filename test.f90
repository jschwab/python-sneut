program tsneut4

  include 'implno.dek'

  integer :: i, j

  double precision :: log10Rho, log10T
  double precision :: temp,den,abar,zbar
  double precision :: pair,plas,phot,brem,recomb,total
  double precision :: snu,snudt,snudd,snuda,snudz

  abar = 96d0 / 7d0
  zbar = 48d0 / 7d0

  do i = 0, 10

     log10Rho = 8.5 + 0.1 * i
     den = 10**log10Rho

     do j = 0, 4

        log10T = 8.1 + 0.1 * j
        temp = 10**log10T

        call sneut4(temp,den,zbar,abar,pair,plas,phot,brem,recomb,total)
        call sneut5(temp,den,abar,zbar,snu,snudt,snudd,snuda,snudz)

        write(*,'(4(ES12.4))') log10Rho, log10T, total, snu

     enddo

  enddo


end program tsneut4
