---
title: "Interoperability with C"
teaching: 15
exercises: 30
questions:
- "How can we write Fortran programs that interact with C in a portable way?"
- "How can we make use of Fortran procedures from C code?"
objectives:
- "Understand the use of the `iso_c_binding` intrinsic module."
- "Write C/Fortran programs that call Fortran/C procedures using `iso_c_binding`."
keypoints:
- "The `iso_c_binding` module allows a programmer to write Fortran that is interoperable with C."
- "Care must be taken with pointers and arrays, and with variables which are to be passed to C by value."
---

Fortran 2003 introduced facilities to allow a Fortran program to interact
with C in a standardised way.

## The intrinsic module `iso_c_binding`

Fortran has introduced the idea of _interoperable_ entities, which
have declarations which have an analogue in C. (Strictly C, not C++.
However, as there is a subset of C which is also valid C++, one can
also communicate with C++.)

Facilities for ensuring that data objects and procedures are interoperable
are provided by the intrinsic module `iso_c_binding`

### Numeric data types

For `integer`, `real` and `complex` types, `iso_c_binding` provides names
for constants which are the relevant kind parameters for Fortran. For
example, integer interoperable types include:
```
  !  declaration                                       ... interoperable with ...
  integer (c_int)                 :: i_int             ! C "int"
  integer (c_short)               :: i_short_int       ! C "short int"
  integer (c_long)                :: i_long            ! C "long int"
  integer (c_size_t)              :: i_size_t          ! C "size_t
```
The value can be -1 (no interoperable Fortran type) or -2 (no corresponding
C type). Recall `size_t` is usually an unsigned type in C. There is still no
direct analogue of unsigned types in Fortran, although an interoperable
type is almost certainly available.

For real types, the full list is:
```
  ! declaration                                        ... interoperable with ...
  real (c_float)                  :: r_float           ! C "float"
  real (c_double)                 :: r_double          ! C "double"
  real (c_long_double)            :: r_long_double     ! C "long double"
```
If the value of the C name is -1 (e.g., `c_long_double`) then Fortran does not
provide a precision equal to that of C type (`long double`). Other negative
values indicate unavailabillity for different reasons.

For complex types, the full list is:
```
  ! declaration                                        ... interoperable with ...
  complex (c_float_complex)       :: z_float_complex   ! C "float _Complex"
  complex (c_double_complex)      :: z_double_complex  ! C "double _Complex"
  complex (c_long_double_complex) :: z_ldc             ! C "long double _Complex"
```
The precision for complex numbers relates to the precision for each of
the real and imaginary parts.

### Logical data types

There is one interoperable logical type:
```
  ! declaration
  logical (c_bool)                :: logical_c_bool    ! C "_Bool"
```
As logical operations in C are often performed using integer types, an
integer type may be appropriate in a given context.

### Example (1 minute)

> ## `iso_c_binding` symbols
> 
> A program is provided which prints out a full list of the symbols
> from `iso_c_binding` illustrated above.
> ```
> $ ftn print_iso_c_binding.f90
> ```
{: .challenge}

### Characters and strings

An interoperable character type is expected to be available:
```
  ! declaration                                  ... interoperable with ...
  character (kind = c_char, len = 1) :: char     ! C "char"
```
To pass strings to C, rather than single characters, it is usually
necessary to think about a string in Fortran as being an assumed
size array of characters of `len = 1`.

Named constants for the following C special characters are provided:
`c_null_char` (`\0`), `c_alert` (`\a`), `c_backspace` (`\b`),
`c_form_feed` (`\f`),`c_new_line` (`\n`), `c_carriage_return` (`\r`),
`c_horizontal_tab` (`\t`), and `c_vertical_tab` (`\v`).

Fortran code receiving strings from C may wish to discard the `c_null_char`
at the end of the string.

### Calling C from Fortran

Suppose we wish to call the standard C library function
```
int atoi(const char * str);
```
from Fortran. To do this, we will write a Fortran interface to reflect the
need for interoperable arguments. This might be:
```
  interface
    function c_atoi(str) bind(c, name = "atoi") result(i)
      use, intrinsic :: iso_c_binding, only : c_char, c_int
      character (kind = c_char, len = 1), intent(in) :: str(*)
      integer (kind = c_int)                         :: i
    end function c_atoi
  end interface
```
The `bind(c)` declaration indicates that this interface relates to a C function.
If the `name` is present, it can be used to associate the C name with the Fortran
interface declaration. If the `name` is not present, the C name will be taken
to be the Fortran name (in lower case). Here,
the function could be called from Fortran via, e.g.,
```
   integer (c_int) :: i
   i = c_atoi("-23")
```
The arguments of the function, and the return type, should all be relevant
interoperable types.

A C function with `void` return type should have an interface defining a subroutine
rather than a function.

### Arguments passed by value

Many C functions have non-pointer dummy arguments, e.g.,
```
double hypot(double x, double y);
```
where actual arguments would be passed by value.

An appropriate Fortran interface can provide information on such scalar arguments
via the `value` attribute:
```
  interface
    function c_hypot(x, y) bind(c, name = "hypot") result(z)
      use iso_c_binding, only : c_double
      real (c_double), value :: x, y
      real (c_double)        :: z
    end function c_hypot
  end interface
```
The `value` attribute takes the place of `intent(in)` (they cannot occur
together). If a scalar argument does not have the `value` attribute, it
means that C expects a pointer.

The `value` attribute can also be used in a normal Fortran
context, where it is a signal to the compiler that the value should be
copied in, whereon it may be changed, but not copied out again.

### Example (10 minutes)

> ## Calling C from Fortran
>
> Suppose we have a C function with prototype
> ```
> int c_snprintf_float(char * str, size_t nsz, const char * format, float x);
> ```
> which we wish to call from Fortran. The function uses the standard C
> library call `snprintf()` to write the value of the `float` argument
> to a string `str` with C format specification `format`. The maximum
> number of characters to be written is `nsz`. The return value is the
> number of characters actually written to the string (not including
> the `\0` terminating character).
> 
> The C function is supplied in the current directory; it needs to be
> compiled (not linked) with the relevant C compiler, e.g. on ARCHER2,
> ```
> $ cc -c c_snprintf.c
> ```
> which will produce an object `c_snprintf.o`.
> 
> Write a program which includes an interface which allows the C function
> to be called with appropriate arguments. If the program is called
> `f_snprintf.f90`, we should be able to compile this with the C object
> via:
> ```
> $ ftn c_snprintf.o f_snprintf.f90
> ```
> Note this is the Fortran compiler.
> 
> What can you say about the length of the string returned in Fortran
> compared with the number of characters written indicated by the
> return value?
> 
> > ## Solution
> > 
> > You will need to provide an interface like so:
> > ```
> >   interface
> >     function f_snprintf_float(str, sz, cformat, x) &
> >          bind(c, name = "c_snprintf_float")  result(nchar)
> >       use iso_c_binding, only : c_int, c_char, c_size_t, c_float
> >       character (kind = c_char, len = 1),        intent(out) :: str(*)
> >       integer   (kind = c_size_t),        value, intent(in)  :: sz
> >       character (kind = c_char, len = 1),        intent(in)  :: cformat(*)
> >       real      (kind = c_float),         value, intent(in)  :: x
> >       integer   (kind = c_int)                               :: nchar
> >     end function f_snprintf_float
> > 
> >     function f_snprintf_double(str, sz, cformat, x) &
> >          bind(c, name = "c_snprintf_double") result(nchar)
> >       use iso_c_binding, only : c_int, c_char, c_size_t, c_double
> >       character (kind = c_char, len = 1),        intent(out) :: str(*)
> >       integer   (kind = c_size_t),        value, intent(in)  :: sz
> >       character (kind = c_char, len = 1),        intent(in)  :: cformat(*)
> >       real      (kind = c_double),        value, intent(in)  :: x
> >       integer   (kind = c_int)                               :: nchar
> >     end function f_snprintf_double
> >   end interface
> > ```
> > {: .source}
> > In order to make use of it, you should declare the variables that will be the
> > actual arguments using the same interoperable types.
> >
> > According to the Fortran, the returned string has length of 6, whereas the string legnth
> > reported by the returned value from `snprintf` is 5. The extra is the null character used
> > by C to terminate strings.
> >
> > An example program called [f_snprintf.f90](../exercises/14-interoperability-with-c/solutions/f_snprintf.f90) is provided.
> >
> {: .solution}
> 
> If you were to implement interfaces for both the `c_snprintf_float()`
> and `c_snprintf_double()` versions, you might wonder whether you could
> overload the specific names with a generic name. It seems like this should
> be possible, but all attempts currently fail with the compiler unable to
> resolve which specific interface it should use from the generic.
>
{: .challenge}

## Arrays

Fortran arrays of non-zero size are interoperable if the data type is
interoperable, and the array has an explicit shape or an assumed size
(the `*` notation).

As an example of an explicit shape consider the C function with
prototype
```
void c_array1(int nlen, double * data);
```
As usual, one would expect the array to be indexed from zero in C.

An appropriate Fortran interface might be
```
  interface
    subroutine c_array1(nlen, data) bind(c)
      use iso_c_binding, only : c_int, c_double
      integer (c_int), value         :: nlen
      real (c_double), intent(inout) :: data(nlen)
    end subroutine c_array1
  end interface
```
A Fortran allocatable array should be declared as assumed size in the
interface. The relevant current size of the allocation will typically
need to be passed as well, as above.

For arrays of rank 2, we must remember that the array element order is
reversed in C relative to Fortran. That is, the Fortran declaration
```
   integer (c_int) :: array(m, n)
```
would need to correspond an array `array[][m]` or `array[n][m]` to be
interoperable. The Fortran interface would specify `dimension (m,*)`
or `dimension(m,n)`, respectively.

### Exercise (10 minutes)

> ## Passing arrays to C
>
> The accompanying C file `c_array.c` holds a function with prototype
> ```
> void c_array(int mlen, int nlen, int [][mlen]);
> ```
> intended to be interoperable with a Fortran array declared `(mlen,nlen)`.
> The C function simply prints out the values of the elements.
> 
> Write a Fortran program that passes a small array of shape `(2,3)`
> to the C function. Initialise the values consistent with Fortran array element
> order (e.g., indicative of increasing address). Does what you see make sense?
> > ## Solution
> > 
> > If you declare the array in Fortran as described and in your interface
> > to the C function declare it as assumed size
> > ```
> > integer (kind = c_int), intent(in) :: idata(mlen, *)
> > ```
> > {: .source}
> > then you should receive output like the following:
> > ```
> > Element [0][0]  0  1
> > Element [0][1]  1  2
> > Element [1][0]  2  3
> > Element [1][1]  3  4
> > Element [2][0]  4  5
> > Element [2][1]  5  6
> > ```
> > {: .output}
> > In C the array appears to be transposed. The loop moves through it
> > in such a way that memory accesses are contiguous.
> >
> > Sample solution code is available in the `solutions` directory in
> > [f_array.f90](../exercises/14-interoperability-with-c/solutions/f_array.f90).
> {: .solution}
{: .challenge}

### Pointers

Derived types `c_ptr` and `c_funptr` are provided for interoperability with C
pointer types. These shouldn't be assigned to directly, but instead a number of
functions are provided to manage the translation of Fortran entities to and from
these new types.

- `c_loc(x)` returns the `c_ptr` type which C can use as the address of
the argument. The argument can be a scalar, a contiguous array of
non-zero size (or allocated non-zero size), or an associated pointer.
The argument must be of interoperable type. The argument must be a
pointer or a data object with target attribute.

- `c_funloc(p)` can return the `c_funptr` address of an interoperable procedure.

- `c_associated(c_ptr1 [, c_ptr2])` is an analogue of the `associated()`
intrinsic which returns `.true.` if the first argument is not
`c_null_ptr`. If the second argument is present, the function will
return `.true.` if both arguments are the same.

- `c_f_pointer(c_ptr, fptr [, shape])` provides functionality to translate a `c_ptr`
  type into a Fortran pointer. A rank 1 integer array shape is
  required if `fptr` is an array.

- `c_f_procpointer(c_funptr, fptr)` provides similar functionality for a
  procedure pointer.


### Derived types

To be interoperable, a Fortran derived type must map to a plain C struct
with interoperable components. This means the Fortran type must have no
type-bound procedures, cannot be extended, and cannot have components that
have either the `allocatable` or `pointer` attributes,

The type should be declared as `bind(c)`, e.g.,
```
  type, bind(c), public :: my_type
    integer (c_int) :: icomponent
    real (c_float)  :: fcomponent
  end type my_type
```
The presence of the `bind(c)` means the type cannot be extended.


## Calling Fortran from C

Let us suppose we have a C program which defines a `struct`
```
typedef struct array_s {
  int nlen;
  float * data;
} array_t;
```
to aggregate the information on an array of `float` which is
to be allocated by the program. Further, we wish to call a
subroutine declared in C as
```
void f_subroutine(const array_t * a);
```
which we wish to write in Fortran.

A corresponding subroutine in Fortran requires the definition of the
interoperable structure, i.e.,
```
  type, bind(c) :: array_t
    integer (c_int)  :: nlen
    type (c_ptr) :: data
  end type array_t
```
where we have used a `c_ptr` type to represent the C pointer component.

An interoperable subroutine declared `bind(c)` might be
```
  subroutine f_subroutine(a) bind(c)

    type (array_t), intent(in) :: a
    real (c_float), pointer    :: data(:)

    call c_f_pointer(a%data, data, [ a%nlen ])

    ! ... perform operations with data(:) ...

  end subroutine f_subroutine
```
The information that the C data is of type `float` appears in the declaration
of the Fortran pointer used to access the array. This must be initialised by
a call to `c_f_pointer()` before it can be used.

### Exercise (10 minutes)

> ## Calling Fortran from C
> 
> Check you can construct a working example based on the above outline.
> Initialise some sample values and check you can recover the values in
> the Fortran subroutine.
> 
> Try using either the C or the Fortran compiler to perform the link stage.
>
> > ## Solution
> > 
> > The Fortran type and subroutine can be placed in a module. Both need to be
> > interoperable with C, meaning they should use `bind(c)`. In the C code
> > provide the `struct`, the `extern void` declaration of the Fortran
> > subroutine, then write a brief program to set some values in the `struct`'s
> > array. In the Fortran subroutine, you can print the array (after retrieving
> > a usable pointer to it via `c_f_pointer()`) and check it's correct.
> >
> > Example solutions are available in
> > `exercises/14-interoperability-with-c/solutions` as
> > [c_struct_to_fortran.c](../exercises/14-interoperability-with-c/solutions/c_struct_to_fortran.c)
> > and
> > [f_array_t.f90](../exercises/14-interoperability-with-c/solutions/f_array_t.f90).
> >
> > Using the GCC compilers, you should be able to compile the code as follows:
> > ```
> > ftn -c f_array_t.f90
> > cc -c c_struct_to_fortran.c
> > ftn f_array_t.o c_struct_to_fortran.o
> > ```
> > {: .output}
> >
> > You can also compile in two steps as long as you tell the C compiler that it
> > will need to use `libgfortran.so` in order to link the symbols from
> > `f_array_t.o`.
> > ```
> > ftn -c f_array_t.f90
> > cc -lgfortran f_array_t.o c_struct_to_fortran.c
> > ```
> > {: .output}
> > 
> {: .solution}
{: .challenge}

{% include links.md %}
