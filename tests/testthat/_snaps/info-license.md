# api_license() errors informatively for bad name

    Code
      api_license(name = mean)
    Condition <rlang_error>
      Error in `api_license()`:
      ! Can't coerce `name` <function> to <character>.

---

    Code
      api_license(name = c("A", "B"))
    Condition <rlang_error>
      Error in `api_license()`:
      ! `name` must be a single <character>.
      x `name` has 2 values.

# api_license() errors informatively for bad url

    Code
      api_license(name = "A", url = mean)
    Condition <rlang_error>
      Error in `api_license()`:
      ! Can't coerce `url` <function> to <character>.

---

    Code
      api_license(name = "A", url = c("A", "B"))
    Condition <rlang_error>
      Error in `api_license()`:
      ! `url` must be a single <character>.
      x `url` has 2 values.

---

    Code
      api_license(name = "A", url = "not a real url")
    Condition <rlang_error>
      Error in `api_license()`:
      ! `url` must match the provided regex pattern.
      x Some values do not match.
      * Locations: 1

# api_license() errors informatively for bad email

    Code
      api_license(name = "A", identifier = mean)
    Condition <rlang_error>
      Error in `api_license()`:
      ! Can't coerce `identifier` <function> to <character>.

---

    Code
      api_license(name = "A", identifier = c("A", "B"))
    Condition <rlang_error>
      Error in `api_license()`:
      ! `identifier` must be a single <character>.
      x `identifier` has 2 values.

# api_license() errors informatively when both url and identifier are supplied

    Code
      api_license(name = "A", identifier = "A", url = "https://example.com")
    Condition <rlang_error>
      Error in `api_license()`:
      ! Exactly one of `identifier` or `url` must be supplied.

# api_license() doesn't match identifier by position

    Code
      api_license(name = "A", "https://example.com")
    Condition <rlib_error_dots_nonempty>
      Error in `api_license()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "https://example.com"
      i Did you forget to name an argument?

