# class_api_key_security_scheme() requires that location is valid

    Code
      class_api_key_security_scheme(location = "invalid place", parameter_name = "parm1")
    Condition
      Error in `class_api_key_security_scheme()`:
      ! `location` must be one of "query", "header", or "cookie", not "invalid place".

# class_api_key_security_scheme() works with valid objects

    Code
      test_result <- class_api_key_security_scheme(location = "query",
        parameter_name = "parm1")
      test_result
    Output
      <rapid::api_key_security_scheme>
       @ parameter_name: chr "parm1"
       @ location      : chr "query"

# as_api_key_security_scheme() errors for unnamed input

    Code
      as_api_key_security_scheme(list("Jon", "jonthegeek@gmail.com"))
    Condition
      Error:
      ! `list("Jon", "jonthegeek@gmail.com")` must have names "parameter_name", "location", "in", or "name".
      * Any other names are ignored.

# as_api_key_security_scheme() errors informatively for bad classes

    Code
      as_api_key_security_scheme(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <rapid::api_key_security_scheme>.

---

    Code
      as_api_key_security_scheme(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <rapid::api_key_security_scheme>.

---

    Code
      as_api_key_security_scheme(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <rapid::api_key_security_scheme>.

