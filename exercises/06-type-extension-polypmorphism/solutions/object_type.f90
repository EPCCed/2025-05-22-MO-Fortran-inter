module object_type

  implicit none
  public

  type, public :: object_t
    real :: rho  = 1.0       ! density
    real :: x(3) = 0.0       ! position of centre of mass
  end type object_t

  type, extends(object_t), public :: sphere_t
    real :: a = 1.0          ! radius
  end type sphere_t

  type, extends(sphere_t), public :: charged_sphere_t
    real :: q = -1.0         ! charge
  end type charged_sphere_t

contains

  subroutine object_info(p)

    class(object_t), pointer, intent(in) :: p

    select type (p)
    type is (charged_sphere_t)
       print *, "Charge = ", p%q
    class is (sphere_t)
       print *, "Radius = ", p%a
    class is (object_t)
       print *, "Density = ", p%rho
       print *, "Position = ", p%x
    class default
       print *, "Unknown object type!"
    end select

  end subroutine object_info
    
end module object_type
