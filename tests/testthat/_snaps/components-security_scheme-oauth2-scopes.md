# class_scopes() requires that description matches name

    Code
      class_scopes("a")
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 1 value.
      - `description` has no values.

---

    Code
      class_scopes("a", letters)
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 1 value.
      - `description` has 26 values.

---

    Code
      class_scopes(letters, "a")
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 26 values.
      - `description` has 1 value.

---

    Code
      class_scopes(character(), "a")
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - When `name` is not defined, `description` must be empty.
      - `description` has 1 value.

---

    Code
      class_scopes("a", character())
    Condition
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 1 value.
      - `description` has no values.

# class_scopes() works with equal-length name/descript

    Code
      test_result <- class_scopes("a", "b")
      test_result
    Output
      <rapid::scopes>
       @ name       : chr "a"
       @ description: chr "b"

# as_scopes() errors informatively for unnamed input

    Code
      as_scopes("a")
    Condition
      Error in `as_scopes()`:
      ! `"a"` must be a named character vector.

# as_scopes() errors informatively for bad classes

    Code
      as_scopes(1:2)
    Condition
      Error in `as_scopes()`:
      ! Can't coerce `1:2` <integer> to <rapid::scopes>.

---

    Code
      as_scopes(mean)
    Condition
      Error in `as_scopes()`:
      ! Can't coerce `mean` <function> to <rapid::scopes>.

---

    Code
      as_scopes(TRUE)
    Condition
      Error in `as_scopes()`:
      ! Can't coerce `TRUE` <logical> to <rapid::scopes>.

