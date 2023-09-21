# api_key_security_scheme requires names for optional arguments

    Code
      api_key_security_scheme("a", "b", "c", location = "header")
    Condition <rlib_error_dots_nonempty>
      Error in `api_key_security_scheme()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "c"
      i Did you forget to name an argument?

# api_key_security_scheme() requires that location is valid

    Code
      api_key_security_scheme(name = c("my_key", "other"), description = c("desc",
        "desc2"), location = c("query", "invalid place"), parameter_name = c("parm1",
        "parm2"))
    Condition <simpleError>
      Error:
      ! <rapid::api_key_security_scheme> object is invalid:
      - `location` must be one of "query", "header", or "cookie".
      - "invalid place" is not in "query", "header", and "cookie".

# api_key_security_scheme() works with valid objects

    Code
      test_result <- api_key_security_scheme(name = c("my_key", "other"),
      description = c("desc", "desc2"), location = c("query", "header"),
      parameter_name = c("parm1", "parm2"))
      test_result
    Output
      <rapid::api_key_security_scheme>
       @ name          : chr [1:2] "my_key" "other"
       @ description   : chr [1:2] "desc" "desc2"
       @ parameter_name: chr [1:2] "parm1" "parm2"
       @ location      : chr [1:2] "query" "header"

# as_api_key_security_scheme() errors informatively for unnamed or misnamed input

    Code
      as_api_key_security_scheme(list(first = list(a = "Jon", b = "jonthegeek@gmail.com")))
    Condition <purrr_error_indexed>
      Error in `purrr::map()`:
      i In index: 1.
      i With name: first.
      Caused by error in `as_api_key_security_scheme()`:
      ! `x[[i]]` must have names "name", "description", "parameter_name", "location", or "in".
      * Any other names are ignored.

# as_api_key_security_scheme() errors informatively for bad classes

    Code
      as_api_key_security_scheme(letters)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <character> to <api_key_security_scheme>.

---

    Code
      as_api_key_security_scheme(1:2)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <integer> to <api_key_security_scheme>.

---

    Code
      as_api_key_security_scheme(mean)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <function> to <api_key_security_scheme>.

---

    Code
      as_api_key_security_scheme(TRUE)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <logical> to <api_key_security_scheme>.

