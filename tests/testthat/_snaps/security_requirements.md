# security_requirements() requires parallel parameters

    Code
      security_requirements(required_scopes = "a")
    Condition
      Error:
      ! <rapid::security_requirements> object is invalid:
      - When `name` is not defined, `required_scopes` must be empty.
      - `required_scopes` has 1 value.

# security_requirements() rapid_class_requirement field is fixed

    Code
      test_result <- security_requirements()
      test_result
    Output
      <rapid::security_requirements>
       @ name                   : chr(0) 
       @ required_scopes        : list()
       @ rapid_class_requirement: chr "security_scheme"

# as_security_requirements() fails for bad classes

    Code
      as_security_requirements(x)
    Condition
      Error:
      ! Can't coerce `x` <integer> to <security_requirements>.

---

    Code
      as_security_requirements(x)
    Condition
      Error:
      ! Can't coerce `x` <function> to <security_requirements>.

---

    Code
      as_security_requirements(x)
    Condition
      Error:
      ! Can't coerce `x` <logical> to <security_requirements>.

