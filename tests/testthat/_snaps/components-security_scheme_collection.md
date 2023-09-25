# security_scheme_collection() requires name for description

    Code
      security_scheme_collection("a", security_scheme = NULL, "description")
    Condition
      Error in `security_scheme_collection()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "description"
      i Did you forget to name an argument?

# security_scheme_collection() requires required parameters

    Code
      security_scheme_collection("a")
    Condition
      Error:
      ! <rapid::security_scheme_collection> object is invalid:
      - `security_scheme` must have the same length as `name`
      - `name` has 1 value.
      - `security_scheme` has no values.
    Code
      security_scheme_collection(security_scheme = api_key_security_scheme("parm",
        "query"))
    Condition
      Error:
      ! <rapid::security_scheme_collection> object is invalid:
      - When `name` is not defined, `security_scheme` must be empty.
      - `security_scheme` has 1 value.

