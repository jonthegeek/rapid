# as_security_scheme() errors informatively for bad classes

    Code
      as_security_scheme(1:2)
    Condition
      Error in `as_security_scheme()`:
      ! Can't coerce `1:2` <integer> to <rapid::security_scheme>.

---

    Code
      as_security_scheme(mean)
    Condition
      Error in `as_security_scheme()`:
      ! Can't coerce `mean` <function> to <rapid::security_scheme>.

---

    Code
      as_security_scheme(TRUE)
    Condition
      Error in `as_security_scheme()`:
      ! Can't coerce `TRUE` <logical> to <rapid::security_scheme>.

