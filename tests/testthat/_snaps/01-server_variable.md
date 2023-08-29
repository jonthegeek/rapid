# server_variable() requires names for optional args

    Code
      server_variable("a", "b", "c")
    Condition
      Error in `server_variable()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "c"
      i Did you forget to name an argument?

# server_variable() requires that default matches name

    Code
      server_variable("a")
    Condition
      Error:
      ! <rapid::server_variable> object is invalid:
      - `default` must have the same length as `name`
      - `name` has 1 value.
      - `default` has no values.

---

    Code
      server_variable("a", letters)
    Condition
      Error:
      ! <rapid::server_variable> object is invalid:
      - `default` must have the same length as `name`
      - `name` has 1 value.
      - `default` has 26 values.

---

    Code
      server_variable(letters, "a")
    Condition
      Error:
      ! <rapid::server_variable> object is invalid:
      - `default` must have the same length as `name`
      - `name` has 26 values.
      - `default` has 1 value.

---

    Code
      server_variable(character(), "a")
    Condition
      Error:
      ! <rapid::server_variable> object is invalid:
      - `default` must have the same length as `name`
      - `name` has no values.
      - `default` has 1 value.

# server_variable() works with equal-length name/default

    Code
      test_result <- server_variable("a", "b")
      test_result
    Output
      <rapid::server_variable>
       @ name       : chr "a"
       @ default    : chr "b"
       @ enum       : list()
       @ description: chr(0) 

# server_variable() requires that optional args are empty or match

    Code
      server_variable("a", "b", enum = list("a", "b"))
    Condition
      Error:
      ! <rapid::server_variable> object is invalid:
      - `enum` must be empty or have the same length as `name`
      - `name` has 1 value.
      - `enum` has 2 values.

---

    Code
      server_variable("a", "b", description = c("a", "b"))
    Condition
      Error:
      ! <rapid::server_variable> object is invalid:
      - `description` must be empty or have the same length as `name`
      - `name` has 1 value.
      - `description` has 2 values.

# server_variable() requires that the default is in enum when given

    Code
      server_variable(name = "a", default = "b", enum = "a")
    Condition
      Error:
      ! <rapid::server_variable> object is invalid:
      - `default` must be in `enum`.
      - "b" is not in "a".

---

    Code
      server_variable(name = c("a", "b"), default = c("b", "a"), enum = list("a", "a"))
    Condition
      Error:
      ! <rapid::server_variable> object is invalid:
      - `default` must be in `enum`.
      - "b" is not in "a".

# server_variable() works for a full object

    Code
      test_result <- server_variable(name = c("username", "port", "basePath"),
      default = c("demo", "8443", "v2"), description = c(
        "this value is assigned by the service provider, in this example `gigantic-server.com`",
        NA, NA), enum = list(NULL, c("8443", "443"), NULL))
      test_result
    Output
      <rapid::server_variable>
       @ name       : chr [1:3] "username" "port" "basePath"
       @ default    : chr [1:3] "demo" "8443" "v2"
       @ enum       :List of 3
       .. $ : NULL
       .. $ : chr [1:2] "8443" "443"
       .. $ : NULL
       @ description: chr [1:3] "this value is assigned by the service provider, in this example `gigantic-server.com`" ...

