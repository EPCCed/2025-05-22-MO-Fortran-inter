program example1

  use iso_c_binding, only : c_int, c_char, c_size_t, c_float, c_double, c_null_char
  implicit none

  interface
    function f_snprintf_float(str, sz, cformat, x) &
         bind(c, name = "c_snprintf_float")  result(nchar)
      use iso_c_binding, only : c_int, c_char, c_size_t, c_float
      character (kind = c_char, len = 1),        intent(out) :: str(*)
      integer   (kind = c_size_t),        value, intent(in)  :: sz
      character (kind = c_char, len = 1),        intent(in)  :: cformat(*)
      real      (kind = c_float),         value, intent(in)  :: x
      integer   (kind = c_int)                               :: nchar
    end function f_snprintf_float

    function f_snprintf_double(str, sz, cformat, x) &
         bind(c, name = "c_snprintf_double") result(nchar)
      use iso_c_binding, only : c_int, c_char, c_size_t, c_double
      character (kind = c_char, len = 1),        intent(out) :: str(*)
      integer   (kind = c_size_t),        value, intent(in)  :: sz
      character (kind = c_char, len = 1),        intent(in)  :: cformat(*)
      real      (kind = c_double),        value, intent(in)  :: x
      integer   (kind = c_int)                               :: nchar
    end function f_snprintf_double
  end interface

  integer (c_size_t),  parameter       :: sz = 80
  character (kind = c_char, len = sz)  :: str = ""
  character (kind = c_char, len = 10)  :: cformat
  real    (c_float)                    :: x = 3.14e0
  real    (c_double)                   :: y = 2.71d0

  integer (c_int) :: nwrite = 0

  print *, "Single precision:"
  cformat = "%5.3f"
  print *, "Format ", cformat
  nwrite = f_snprintf_float(str, sz, trim(cformat), x)
  print *, "Return value ", nwrite
  print *, "Index of null ", index(str, c_null_char)
  print *, "String ", trim(str), len_trim(str)

  print *, "Double precision:"
  cformat = "%22.15e"
  print *, "Format ", cformat
  nwrite = f_snprintf_double(str, sz, trim(cformat), y)
  print *, "Return value ", nwrite
  print *, "Index of null ", index(str, c_null_char)
  print *, "String ", trim(str), len_trim(str)

end program example1
