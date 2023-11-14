# class_security_schemes() requires name for description

    Code
      class_security_schemes("a", details = NULL, "description")
    Condition
      Error in `class_security_schemes()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "description"
      i Did you forget to name an argument?

# class_security_schemes() requires required parameters

    Code
      class_security_schemes("a")
    Condition
      Error:
      ! <rapid::security_schemes> object is invalid:
      - `details` must have the same length as `name`
      - `name` has 1 value.
      - `details` has no values.
    Code
      class_security_schemes(details = class_security_scheme_details(
        class_api_key_security_scheme("parm", "query")))
    Condition
      Error:
      ! <rapid::security_schemes> object is invalid:
      - When `name` is not defined, `details` must be empty.
      - `details` has 1 value.

# class_security_schemes() -> empty security_schemes

    Code
      test_result <- class_security_schemes()
      test_result
    Output
      <rapid::security_schemes>
       @ name       : chr(0) 
       @ details    : <rapid::security_scheme_details>  list()
       @ description: chr(0) 

# as_security_schemes() errors for unnamed input

    Code
      as_security_schemes(as.list(letters))
    Condition
      Error in `as_security_schemes()`:
      ! `as.list(letters)` must have names.

# as_security_schemes() errors for bad classes

    Code
      as_security_schemes(letters)
    Condition
      Error in `as_security_schemes()`:
      ! `letters` must have names "name", "details", or "description".
      * Any other names are ignored.

---

    Code
      as_security_schemes(1:2)
    Condition
      Error in `as_security_schemes()`:
      ! Can't coerce `1:2` <integer> to <rapid::security_schemes>.

---

    Code
      as_security_schemes(mean)
    Condition
      Error in `as_security_schemes()`:
      ! Can't coerce `mean` <function> to <rapid::security_schemes>.

---

    Code
      as_security_schemes(TRUE)
    Condition
      Error in `as_security_schemes()`:
      ! Can't coerce `TRUE` <logical> to <rapid::security_schemes>.

