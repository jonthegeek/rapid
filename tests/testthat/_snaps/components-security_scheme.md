# as_security_scheme() errors informatively for bad classes

    Code
      as_security_scheme(1:2)
    Condition
      Error:
      ! Can't coerce `x` <integer> to <security_scheme>.

---

    Code
      as_security_scheme(mean)
    Condition
      Error:
      ! Can't coerce `x` <function> to <security_scheme>.

---

    Code
      as_security_scheme(TRUE)
    Condition
      Error:
      ! Can't coerce `x` <logical> to <security_scheme>.

