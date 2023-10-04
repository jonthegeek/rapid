# contact() errors informatively for bad name

    Code
      contact(name = mean)
    Condition
      Error in `contact()`:
      ! Can't coerce `name` <function> to <character>.

---

    Code
      contact(name = c("A", "B"))
    Condition
      Error in `contact()`:
      ! `name` must be a single <character>.
      x `name` has 2 values.

# contact() errors informatively for bad email

    Code
      contact(name = "A", url = "https://example.com", email = mean)
    Condition
      Error in `contact()`:
      ! Can't coerce `email` <function> to <character>.

---

    Code
      contact(name = "A", url = "https://example.com", email = c("A", "B"))
    Condition
      Error in `contact()`:
      ! `email` must be a single <character>.
      x `email` has 2 values.

---

    Code
      contact(name = "A", url = "https://example.com", email = "not a real email")
    Condition
      Error in `contact()`:
      ! `email` must match the provided regex pattern.
      x Some values do not match.
      * Locations: 1

# contact() returns a contact when everything is ok

    Code
      test_result <- contact(name = "A", url = "https://example.com", email = "real.email@address.place")
      test_result
    Output
      <rapid::contact>
       @ name : chr "A"
       @ email: chr "real.email@address.place"
       @ url  : chr "https://example.com"

# contact() without args returns an empty contact

    Code
      test_result <- contact()
      test_result
    Output
      <rapid::contact>
       @ name : chr(0) 
       @ email: chr(0) 
       @ url  : chr(0) 

# as_contact() errors informatively for unnamed or misnamed input

    Code
      as_contact(letters)
    Condition
      Error:
      ! `x` must have names "name", "email", or "url".
      * Any other names are ignored.

---

    Code
      as_contact(list(a = "Jon", b = "jonthegeek@gmail.com"))
    Condition
      Error:
      ! `x` must have names "name", "email", or "url".
      * Any other names are ignored.

---

    Code
      as_contact(c(a = "Jon", b = "jonthegeek@gmail.com"))
    Condition
      Error:
      ! `x` must have names "name", "email", or "url".
      * Any other names are ignored.

# as_contact() errors informatively for bad classes

    Code
      as_contact(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <contact>.

---

    Code
      as_contact(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <contact>.

---

    Code
      as_contact(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <contact>.

