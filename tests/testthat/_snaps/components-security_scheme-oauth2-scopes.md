# scopes() requires that description matches name

    Code
      scopes("a")
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 1 value.
      - `description` has no values.

---

    Code
      scopes("a", letters)
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 1 value.
      - `description` has 26 values.

---

    Code
      scopes(letters, "a")
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 26 values.
      - `description` has 1 value.

---

    Code
      scopes(character(), "a")
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - When `name` is not defined, `description` must be empty.
      - `description` has 1 value.

---

    Code
      scopes("a", character())
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 1 value.
      - `description` has no values.

# scopes() works with equal-length name/descript

    Code
      test_result <- scopes("a", "b")
      test_result
    Output
      <rapid::scopes>
       @ name       : chr "a"
       @ description: chr "b"

# as_scopes() errors informatively for unnamed input

    Code
      as_scopes("a")
    Condition
      Error:
      ! `x` must be a named character vector.

# as_scopes() errors informatively for bad classes

    Code
      as_scopes(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <scopes>.

---

    Code
      as_scopes(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <scopes>.

---

    Code
      as_scopes(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <scopes>.

