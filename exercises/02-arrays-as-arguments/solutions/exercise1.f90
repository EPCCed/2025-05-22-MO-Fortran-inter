program exercise1

  implicit none

  real, allocatable :: a(:)

  a = [ 1.0, 2.0, 3.0, 4.0, 5.0 ]
  print *, "Initial values ", a

  call my_array_operation(a)
  ! call my_array_operation(a(1:5:2))
  ! a = alloc_arr()

  print *, "Final values ", a
  
contains

  subroutine my_array_operation(b)

    real, allocatable, intent(out) :: b(:)

    if (.not. allocated(b)) then
       print *, "The argument b is unallocated"
       return
    end if
    
    print *, "shape(b): ", shape(b)

    b(:) = 0.0

  end subroutine my_array_operation

  function alloc_arr() result(arr)

    integer, allocatable :: arr(:)

  end function alloc_arr

end program exercise1
