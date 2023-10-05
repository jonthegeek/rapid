# security_scheme_collection() requires name for description

    Code
      security_scheme_collection("a", details = NULL, "description")
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
      - `details` must have the same length as `name`
      - `name` has 1 value.
      - `details` has no values.
    Code
      security_scheme_collection(details = security_scheme_details(
        api_key_security_scheme("parm", "query")))
    Condition
      Error:
      ! <rapid::security_scheme_collection> object is invalid:
      - When `name` is not defined, `details` must be empty.
      - `details` has 1 value.

# security_scheme_collection() -> empty security_scheme_collection

    Code
      test_result <- security_scheme_collection()
      test_result
    Output
      <rapid::security_scheme_collection>
       @ name       : chr(0) 
       @ details    : <rapid::security_scheme_details>  list()
       @ description: chr(0) 

# as_security_scheme_collection() errors for unnamed input

    Code
      as_security_scheme_collection(as.list(letters))
    Condition
      Error:
      ! `a`, `b`, `c`, `d`, `e`, `f`, `g`, `h`, `i`, `j`, `k`, `l`, `m`, `n`, `o`, `p`, `q`, `r`, ..., `y`, and `z` must have names.

# as_security_scheme_collection() errors for bad classes

    Code
      as_security_scheme_collection(letters)
    Condition
      Error:
      ! Can't coerce `letters` <character> to <security_scheme_collection>.

---

    Code
      as_security_scheme_collection(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <security_scheme_collection>.

---

    Code
      as_security_scheme_collection(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <security_scheme_collection>.

---

    Code
      as_security_scheme_collection(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <security_scheme_collection>.

