# license() errors informatively for bad name

    Code
      license(name = mean)
    Condition <rlang_error>
      Error in `license()`:
      ! Can't coerce `name` <function> to <character>.

---

    Code
      license(name = c("A", "B"))
    Condition <rlang_error>
      Error in `license()`:
      ! `name` must be a single <character>.
      x `name` has 2 values.

# license() errors informatively for bad url

    Code
      license(name = "A", url = mean)
    Condition <rlang_error>
      Error in `license()`:
      ! Can't coerce `url` <function> to <character>.

---

    Code
      license(name = "A", url = c("A", "B"))
    Condition <rlang_error>
      Error in `license()`:
      ! `url` must be a single <character>.
      x `url` has 2 values.

# license() errors informatively for bad identifier

    Code
      license(name = "A", identifier = mean)
    Condition <rlang_error>
      Error in `license()`:
      ! Can't coerce `identifier` <function> to <character>.

---

    Code
      license(name = "A", identifier = c("A", "B"))
    Condition <rlang_error>
      Error in `license()`:
      ! `identifier` must be a single <character>.
      x `identifier` has 2 values.

# license() errors informatively when both url and identifier are supplied

    Code
      license(name = "A", identifier = "A", url = "https://example.com")
    Condition <simpleError>
      Error:
      ! <rapid::license> object is invalid:
      - At most one of @identifier and @url must be supplied.

# license() fails when name is missing

    Code
      license(identifier = "A")
    Condition <simpleError>
      Error:
      ! <rapid::license> object is invalid:
      - When `name` is not defined, `identifier` must be empty.
      - `identifier` has 1 value.

---

    Code
      license(url = "https://example.com")
    Condition <simpleError>
      Error:
      ! <rapid::license> object is invalid:
      - When `name` is not defined, `url` must be empty.
      - `url` has 1 value.

# license() doesn't match identifier by position

    Code
      license(name = "A", "https://example.com")
    Condition <rlib_error_dots_nonempty>
      Error in `license()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "https://example.com"
      i Did you forget to name an argument?

# license() returns a license when everything is ok

    Code
      test_result <- license(name = "A", url = "https://example.com")
      test_result
    Output
      <rapid::license>
       @ name      : chr "A"
       @ identifier: chr(0) 
       @ url       : chr "https://example.com"

---

    Code
      test_result <- license(name = "A", identifier = "technically these have a fancy required format")
      test_result
    Output
      <rapid::license>
       @ name      : chr "A"
       @ identifier: chr "technically these have a fancy required format"
       @ url       : chr(0) 

# as_license() errors informatively for unnamed or misnamed input

    Code
      as_license(letters)
    Condition <rlang_error>
      Error:
      ! `x` must have names "name", "identifier", or "url".
      * Any other names are ignored.

---

    Code
      as_license(list(a = "Apache 2.0", b = "https://opensource.org/license/apache-2-0/"))
    Condition <rlang_error>
      Error:
      ! `x` must have names "name", "identifier", or "url".
      * Any other names are ignored.

# as_license() errors informatively for bad classes

    Code
      as_license(1:2)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <integer> to <license>.

---

    Code
      as_license(mean)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <function> to <license>.

---

    Code
      as_license(TRUE)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <logical> to <license>.

