---
title: "Intrinsic modules"
teaching: 15
exercises: 5
questions:
- "What intrinsic modules does Fortran provide?"
- "How can intrinsic modules aid writing portable code?"
objectives:
- "Be aware of the intrinsic modules in Fortran and their uses"
keypoints:
- "The `iso_fortran_env` intrinsic module provides constants and functions that enable code portability"
- "The IEEE intrinsic modules allow programs to check the conformance with IEEE features"
---

## Intrisic and non-intrinsic modules

Five intrinsic modules are provided by the implementation: we
have seen `iso_fortran_env`.

Three are related to IEEE arithmetic: `ieee_arithmetic`, `ieee_exceptions`
and `ieee_features`.
The last is `iso_c_binding` which concerns C/Fortran interoperability.

A use statement may include, optionally, an `intrinsic` or `non_intrinsic`
attribute, e.g.,
```
  use, intrinsic :: iso_fortran_env
```
This true intrinsic `iso_fortran_env` will then be used in preference to
any other module with the same name.

Likewise a non-intrinsic module can be used:
```
  use, non_intrinsic :: iso_fortran_env
```
This would generate an error if a user-provided `iso_fortran_env` were
unavailable to the compiler.

Best practice is to always use an `only` clause with intrinsic modules,
which enumerates the names required in the current scope. This is a
general rule which limits "namespace pollution", and can be applied to
your own modules too.


## Intrinsic module `iso_fortran_env`

This module provides a number of symbolic constants and functions to
provide information about the local Fortran implementation.

These include:
1. `error_unit`, `input_unit` and `output_unit`: the unit numbers
   associated with standard error, standard input, and standard output.
2. `iostat_end` and `iostat_eor`: error codes for end-fo-file and
   end-of-record.
3. `character_storage_size`, `file_storage_size`, and `numeric_storage_size`
   related to i/o


F2008 included kind type parameters for frequently used intrinsic data
types:
1. `int8`, `int16`, `int32`, `int64`: integer kind type parameter for
   intrinsic integers (in bits);
2. `real32`, `real64`, `real128`: integer kind type parameters for
   intrinsic real data types.

Lists of the kind types available for each intrinsic data type are also
available: `integer_kinds`, `logical_kinds`, `real_kinds`, `character_kinds`.


### Functions

Information on the compiler and the options at compile time can be accessed
via the functions: `compiler_version()` and `compiler_options()`. Both
return a string fixed at compile time.

E.g.,
```
  character (len = *), parameter :: compiler = compiler_version()
```

### Example (3 minutes)

> ## `iso_fortran_env` values
>
> An example program is provided which prints out the values of the various
> symbols available from `iso_fortran_env`.
> ```
> $ ftn print_iso_fortran_env.f90
> ```
> To see the actual values in the kind arrays (`integer_kinds` and so on)
> some extra statements would be required.
{: .challenge}


## IEEE arithmetic support

Fortran provides support for programmers to inquire about support for various
aspects of the IEEE standard for floating point arithmetic. This information
is separated into three modules.

1. `ieee_exceptions` provides handling for IEEE exception types enumerated
   by the values: `ieee_overflow`, `ieee_divide_by_zero`, `ieee_invalid`,
   `ieee_underflow` and `ieee_inexact`.
2. `ieee_arithmetic` contains functionality for identifying different classes
   of floating point values (e.g., `ieee_negative_inf`), rounding modes, and
   so on. The `ieee_arithmetic` module include `ieee_exceptions`.
3. `ieee_features` does not provide names a such by may affect compilation if
   present. E.g., if
   ```
     use, intrinsic :: ieee_features, only : ieee_subnormal
   ```
   is present, then the program unit must provide support for subnormal floating
   point numbers (aka denormalised numbers, with a leading zero in the mantissa).

A full description of the IEEE features will not be attempted here.


{% include links.md %}
