# scopes() requires that description matches name

    Code
      scopes("a")
    Condition <simpleError>
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 1 value.
      - `description` has no values.

---

    Code
      scopes("a", letters)
    Condition <simpleError>
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 1 value.
      - `description` has 26 values.

---

    Code
      scopes(letters, "a")
    Condition <simpleError>
      Error:
      ! <rapid::scopes> object is invalid:
      - `description` must have the same length as `name`
      - `name` has 26 values.
      - `description` has 1 value.

---

    Code
      scopes(character(), "a")
    Condition <simpleError>
      Error:
      ! <rapid::scopes> object is invalid:
      - When `name` is not defined, `description` must be empty.
      - `description` has 1 value.

---

    Code
      scopes("a", character())
    Condition <simpleError>
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
    Condition <rlang_error>
      Error:
      ! `x` must be a named character vector.

# as_scopes() errors informatively for bad classes

    Code
      as_scopes(1:2)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <integer> to <scopes>.

---

    Code
      as_scopes(mean)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <function> to <scopes>.

---

    Code
      as_scopes(TRUE)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <logical> to <scopes>.
