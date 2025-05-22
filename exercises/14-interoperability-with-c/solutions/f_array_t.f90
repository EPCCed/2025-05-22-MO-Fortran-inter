module f_array_t

  use iso_c_binding, only : c_int, c_float, c_ptr, c_f_pointer
  use iso_fortran_env, only : output_unit
  implicit none

  ! Interoperable Fortran counterpart to the C array_t.
  type, bind(c) :: array_t
    integer (c_int)  :: nlen
    type (c_ptr) :: data
  end type array_t

contains

  subroutine f_subroutine(a) bind(c)
    implicit none

    type (array_t), intent(in) :: a
    real (c_float), pointer    :: data(:)

    integer :: i

    ! Get a Fortran pointer counterpart to the C pointer.
    ! As it's a pointer to an array, we need to provide its size.
    call c_f_pointer(a%data, data, [ a%nlen ])

    ! Print the array's contents. It should match what was
    ! printed from the C code.
    write(output_unit, "('Fortran pointer to array of size ', i2, ':')") a%nlen
    do i = 1, a%nlen
        write (output_unit, "('Element (',i2,')',x,f4.1)") i, data(i)
    end do

  end subroutine f_subroutine

end module f_array_t