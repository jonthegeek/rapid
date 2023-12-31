# class_string_replacements() requires names for optional args

    Code
      class_string_replacements("a", "b", "c")
    Condition
      Error in `class_string_replacements()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "c"
      i Did you forget to name an argument?

# class_string_replacements() requires that default matches name

    Code
      class_string_replacements("a")
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must have the same length as `name`
      - `name` has 1 value.
      - `default` has no values.

---

    Code
      class_string_replacements("a", letters)
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must have the same length as `name`
      - `name` has 1 value.
      - `default` has 26 values.

---

    Code
      class_string_replacements(letters, "a")
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must have the same length as `name`
      - `name` has 26 values.
      - `default` has 1 value.

---

    Code
      class_string_replacements(character(), "a")
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - When `name` is not defined, `default` must be empty.
      - `default` has 1 value.

# class_string_replacements() works with equal-length name/default

    Code
      test_result <- class_string_replacements("a", "b")
      test_result
    Output
      <rapid::string_replacements>
       @ name       : chr "a"
       @ default    : chr "b"
       @ enum       : list()
       @ description: chr(0) 

# class_string_replacements() requires optional args are empty or match

    Code
      class_string_replacements("a", "b", enum = list("a", "b"))
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `enum` must be empty or have the same length as `name`
      - `name` has 1 value.
      - `enum` has 2 values.

---

    Code
      class_string_replacements("a", "b", description = c("a", "b"))
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `description` must be empty or have the same length as `name`
      - `name` has 1 value.
      - `description` has 2 values.

# class_string_replacements() requires default is in enum when given

    Code
      class_string_replacements(name = "a", default = "b", enum = "a")
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must be in `enum`.
      - "b" is not in "a".

---

    Code
      class_string_replacements(name = c("a", "b"), default = c("b", "a"), enum = list(
        "a", "a"))
    Condition
      Error:
      ! <rapid::string_replacements> object is invalid:
      - `default` must be in `enum`.
      - "b" is not in "a".

# class_string_replacements() works for a full object

    Code
      test_result <- class_string_replacements(name = c("username", "port",
        "basePath"), default = c("demo", "8443", "v2"), description = c(
        "The active user's folder.", NA, NA), enum = list(NULL, c("8443", "443"),
      NULL))
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

# as_string_replacements() errors for unnamed input

    Code
      as_string_replacements(letters)
    Condition
      Error in `as_string_replacements()`:
      ! `letters` must have names "name", "default", "enum", or "description".
      * Any other names are ignored.

---

    Code
      as_string_replacements(list("Jon", "jonthegeek@gmail.com"))
    Condition
      Error in `purrr::map_chr()`:
      i In index: 1.
      Caused by error:
      ! Result must be length 1, not 0.

---

    Code
      as_string_replacements(c("Jon", "jonthegeek@gmail.com"))
    Condition
      Error in `as_string_replacements()`:
      ! `c("Jon", "jonthegeek@gmail.com")` must have names "name", "default", "enum", or "description".
      * Any other names are ignored.

# as_string_replacements() errors informatively for bad classes

    Code
      as_string_replacements(1:2)
    Condition
      Error in `as_string_replacements()`:
      ! Can't coerce `1:2` <integer> to <rapid::string_replacements>.

---

    Code
      as_string_replacements(mean)
    Condition
      Error in `as_string_replacements()`:
      ! Can't coerce `mean` <function> to <rapid::string_replacements>.

---

    Code
      as_string_replacements(TRUE)
    Condition
      Error in `as_string_replacements()`:
      ! Can't coerce `TRUE` <logical> to <rapid::string_replacements>.

