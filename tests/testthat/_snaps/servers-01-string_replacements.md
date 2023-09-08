# string_replacements() requires names for optional args

    Code
      string_replacements("a", "b", "c")
    Condition
      Error in `string_replacements()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "c"
      i Did you forget to name an argument?

# string_replacements() requires that default matches name

    Code
      string_replacements("a")
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must have the same length as `name`
      - `name` has 1 value.
      - `default` has no values.

---

    Code
      string_replacements("a", letters)
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must have the same length as `name`
      - `name` has 1 value.
      - `default` has 26 values.

---

    Code
      string_replacements(letters, "a")
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must have the same length as `name`
      - `name` has 26 values.
      - `default` has 1 value.

---

    Code
      string_replacements(character(), "a")
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - When `name` is not defined, `default` must be empty.
      - `default` has 1 value.

# string_replacements() works with equal-length name/default

    Code
      test_result <- string_replacements("a", "b")
      test_result
    Output
      <rapid::string_replacements>
       @ name       : chr "a"
       @ default    : chr "b"
       @ enum       : NULL
       @ description: chr(0) 

# string_replacements() requires that optional args are empty or match

    Code
      string_replacements("a", "b", enum = list("a", "b"))
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `enum` must be empty or have the same length as `name`
      - `name` has 1 value.
      - `enum` has 2 values.

---

    Code
      string_replacements("a", "b", description = c("a", "b"))
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `description` must be empty or have the same length as `name`
      - `name` has 1 value.
      - `description` has 2 values.

# string_replacements() requires that the default is in enum when given

    Code
      string_replacements(name = "a", default = "b", enum = "a")
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must be in `enum`.
      - "b" is not in "a".

---

    Code
      string_replacements(name = c("a", "b"), default = c("b", "a"), enum = list("a",
        "a"))
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must be in `enum`.
      - "b" is not in "a".

# string_replacements() works for a full object

    Code
      test_result <- string_replacements(name = c("username", "port", "basePath"),
      default = c("demo", "8443", "v2"), description = c("The active user's folder.",
        NA, NA), enum = list(NULL, c("8443", "443"), NULL))
      test_result
    Output
      <rapid::string_replacements>
       @ name       : chr [1:3] "username" "port" "basePath"
       @ default    : chr [1:3] "demo" "8443" "v2"
       @ enum       :List of 3
       .. $ : NULL
       .. $ : chr [1:2] "8443" "443"
       .. $ : NULL
       @ description: chr [1:3] "The active user's folder." NA NA

# as_string_replacements() errors informatively for unnamed or misnamed input

    Code
      as_string_replacements(letters)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <character> to <string_replacements>.

---

    Code
      as_string_replacements(list(a = "Jon", b = "jonthegeek@gmail.com"))
    Condition <purrr_error_indexed>
      Error in `purrr::map_chr()`:
      i In index: 1.
      Caused by error:
      ! Result must be length 1, not 0.

---

    Code
      as_string_replacements(c(a = "Jon", b = "jonthegeek@gmail.com"))
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <character> to <string_replacements>.

# as_string_replacements() errors informatively for bad classes

    Code
      as_string_replacements(1:2)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <integer> to <string_replacements>.

---

    Code
      as_string_replacements(mean)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <function> to <string_replacements>.

---

    Code
      as_string_replacements(TRUE)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <logical> to <string_replacements>.

