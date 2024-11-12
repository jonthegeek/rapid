# class_license() errors informatively for bad name

    Code
      class_license(name = mean)
    Condition
      Error:
      ! Can't coerce `name` <function> to <character>.

---

    Code
      class_license(name = c("A", "B"))
    Condition
      Error:
      ! `name` must be a single <character>.
      x `name` has 2 values.

# class_license() errors informatively for bad url

    Code
      class_license(name = "A", url = mean)
    Condition
      Error:
      ! Can't coerce `url` <function> to <character>.

---

    Code
      class_license(name = "A", url = c("A", "B"))
    Condition
      Error:
      ! `url` must be a single <character>.
      x `url` has 2 values.

# class_license() errors informatively for bad identifier

    Code
      class_license(name = "A", identifier = mean)
    Condition
      Error:
      ! Can't coerce `identifier` <function> to <character>.

---

    Code
      class_license(name = "A", identifier = c("A", "B"))
    Condition
      Error:
      ! `identifier` must be a single <character>.
      x `identifier` has 2 values.

# class_license() errors when both url and identifier are supplied

    Code
      class_license(name = "A", identifier = "A", url = "https://example.com")
    Condition
      Error:
      ! <rapid::license> object is invalid:
      - At most one of @identifier and @url must be supplied.

# class_license() fails when name is missing

    Code
      class_license(identifier = "A")
    Condition
      Error:
      ! <rapid::license> object is invalid:
      - When `name` is not defined, `identifier` must be empty.
      - `identifier` has 1 value.

---

    Code
      class_license(url = "https://example.com")
    Condition
      Error:
      ! <rapid::license> object is invalid:
      - When `name` is not defined, `url` must be empty.
      - `url` has 1 value.

# class_license() doesn't match identifier by position

    Code
      class_license(name = "A", "https://example.com")
    Condition
      Error in `class_license()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "https://example.com"
      i Did you forget to name an argument?

# class_license() returns a license when everything is ok

    Code
      test_result <- class_license(name = "A", url = "https://example.com")
      test_result
    Output
      <rapid::license>
       @ name      : chr "A"
       @ identifier: chr(0) 
       @ url       : chr "https://example.com"

---

    Code
      test_result <- class_license(name = "A", identifier = "technically these have a fancy required format")
      test_result
    Output
      <rapid::license>
       @ name      : chr "A"
       @ identifier: chr "technically these have a fancy required format"
       @ url       : chr(0) 

# as_license() errors informatively for unnamed input

    Code
      as_license(letters)
    Condition
      Error:
      ! `letters` must have names "name", "identifier", or "url".
      * Any other names are ignored.

# as_license() errors informatively for bad classes

    Code
      as_license(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <rapid::license>.

---

    Code
      as_license(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <rapid::license>.

---

    Code
      as_license(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <rapid::license>.

