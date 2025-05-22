module f_array_module
    use, intrinsic :: iso_c_binding
    implicit none
    public

    interface
        subroutine c_array (mlen, nlen, idata) &
            bind(c, name = "c_array")
            use iso_c_binding, only : c_int
            integer (kind = c_int), value, intent(in) :: mlen, nlen
            integer (kind = c_int), intent(in) :: idata(mlen, *)
        end subroutine c_array
    end interface

end module f_array_module


program test_array
    use f_array_module
    implicit none

    integer, parameter :: mlen = 2, nlen = 3
    integer :: idata(mlen, nlen)
    
    integer :: i, j

    do j = 1, nlen
        do i = 1, mlen
            idata(i, j) = i + (j - 1) * mlen
        end do
    end do

    ! printing - check correct in memory order
    do j = 1, mlen
        write(*,*) "Row ", j, ": ", idata(j, 1:nlen)
    end do
    print *, idata

    call c_array(mlen, nlen, idata)
end program test_array