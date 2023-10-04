# api_key_security_scheme() requires that location is valid

    Code
      api_key_security_scheme(location = "invalid place", parameter_name = "parm1")
    Condition
      Error:
      ! <rapid::api_key_security_scheme> object is invalid:
      - `location` must be one of "query", "header", or "cookie".
      - "invalid place" is not in "query", "header", and "cookie".

# api_key_security_scheme() works with valid objects

    Code
      test_result <- api_key_security_scheme(location = "query", parameter_name = "parm1")
      test_result
    Output
      <rapid::api_key_security_scheme>
       @ parameter_name: chr "parm1"
       @ location      : chr "query"

# as_api_key_security_scheme() errors informatively for unnamed or misnamed input

    Code
      as_api_key_security_scheme(list(a = "Jon", b = "jonthegeek@gmail.com"))
    Condition
      Error:
      ! `x` must have names "parameter_name", "location", "in", or "name".
      * Any other names are ignored.

# as_api_key_security_scheme() errors informatively for bad classes

    Code
      as_api_key_security_scheme(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <api_key_security_scheme>.

---

    Code
      as_api_key_security_scheme(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <api_key_security_scheme>.

---

    Code
      as_api_key_security_scheme(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <api_key_security_scheme>.

