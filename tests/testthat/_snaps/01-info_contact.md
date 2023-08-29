# api_contact() errors informatively for bad name

    Code
      api_contact(name = mean)
    Condition <rlang_error>
      Error in `api_contact()`:
      ! Can't coerce `name` <function> to <character>.

---

    Code
      api_contact(name = c("A", "B"))
    Condition <rlang_error>
      Error in `api_contact()`:
      ! `name` must be a single <character>.
      x `name` has 2 values.

# api_contact() errors informatively for bad url

    Code
      api_contact(name = "A", url = mean)
    Condition <rlang_error>
      Error in `api_contact()`:
      ! Can't coerce `url` <function> to <character>.

---

    Code
      api_contact(name = "A", url = c("A", "B"))
    Condition <rlang_error>
      Error in `api_contact()`:
      ! `url` must be a single <character>.
      x `url` has 2 values.

---

    Code
      api_contact(name = "A", url = "not a real url")
    Condition <rlang_error>
      Error in `api_contact()`:
      ! `url` must match the provided regex pattern.
      x Some values do not match.
      * Locations: 1

# api_contact() errors informatively for bad email

    Code
      api_contact(name = "A", url = "https://example.com", email = mean)
    Condition <rlang_error>
      Error in `api_contact()`:
      ! Can't coerce `email` <function> to <character>.

---

    Code
      api_contact(name = "A", url = "https://example.com", email = c("A", "B"))
    Condition <rlang_error>
      Error in `api_contact()`:
      ! `email` must be a single <character>.
      x `email` has 2 values.

---

    Code
      api_contact(name = "A", url = "https://example.com", email = "not a real email")
    Condition <rlang_error>
      Error in `api_contact()`:
      ! `email` must match the provided regex pattern.
      x Some values do not match.
      * Locations: 1

# api_contact() returns a contact when everything is ok

    Code
      test_result <- api_contact(name = "A", url = "https://example.com", email = "real.email@address.place")
      test_result
    Output
      <rapid::api_contact>
       @ name : chr "A"
       @ email: chr "real.email@address.place"
       @ url  : chr "https://example.com"

# api_contact() without args returns an empty api_contact

    Code
      test_result <- api_contact()
      test_result
    Output
      <rapid::api_contact>
       @ name : chr(0) 
       @ email: chr(0) 
       @ url  : chr(0) 

