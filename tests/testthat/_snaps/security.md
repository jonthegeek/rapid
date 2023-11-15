# class_security() requires parallel parameters

    Code
      class_security(required_scopes = "a")
    Condition
      Error:
      ! <rapid::security> object is invalid:
      - When `name` is not defined, `required_scopes` must be empty.
      - `required_scopes` has 1 value.

# class_security() rapid_class_requirement field is fixed

    Code
      test_result <- class_security()
      test_result
    Output
      <rapid::security>
       @ name                   : chr(0) 
       @ required_scopes        : list()
       @ rapid_class_requirement: chr "security_scheme"

# as_security() fails for bad classes

    Code
      as_security(x)
    Condition
      Error in `as_security()`:
      ! Can't coerce `x` <integer> to <rapid::security>.

---

    Code
      as_security(x)
    Condition
      Error in `as_security()`:
      ! Can't coerce `x` <function> to <rapid::security>.

---

    Code
      as_security(x)
    Condition
      Error in `as_security()`:
      ! Can't coerce `x` <logical> to <rapid::security>.

