# info() validates property length.

    Code
      info(title = "My API")
    Condition
      Error:
      ! <rapid::info> object is invalid:
      - `version` must have the same length as `title`
      - `title` has 1 value.
      - `version` has no values.

---

    Code
      info(version = "My API")
    Condition
      Error:
      ! <rapid::info> object is invalid:
      - When `title` is not defined, `version` must be empty.
      - `version` has 1 value.

---

    Code
      info(summary = "My API")
    Condition
      Error:
      ! <rapid::info> object is invalid:
      - When `title` is not defined, `summary` must be empty.
      - `summary` has 1 value.

# info() returns an empty info

    Code
      test_result <- info()
      test_result
    Output
      <rapid::info>
       @ title           : chr(0) 
       @ version         : chr(0) 
       @ contact         : <rapid::contact>
       .. @ name : chr(0) 
       .. @ email: chr(0) 
       .. @ url  : chr(0) 
       @ description     : chr(0) 
       @ license         : <rapid::license>
       .. @ name      : chr(0) 
       .. @ identifier: chr(0) 
       .. @ url       : chr(0) 
       @ summary         : chr(0) 
       @ terms_of_service: chr(0) 

# as_info() errors informatively for unnamed input

    Code
      as_info(letters)
    Condition
      Error:
      ! `x` must have names "title", "version", "contact", "description", "license", "summary", or "terms_of_service".
      * Any other names are ignored.

---

    Code
      as_info(list("My Cool API"))
    Condition
      Error:
      ! `x` must have names "title", "version", "contact", "description", "license", "summary", or "terms_of_service".
      * Any other names are ignored.

# as_info() errors informatively for bad classes

    Code
      as_info(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <info>.

---

    Code
      as_info(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <info>.

---

    Code
      as_info(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <info>.

