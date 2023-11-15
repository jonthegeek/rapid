# class_components() returns an empty components

    Code
      test_result <- class_components()
      test_result
    Output
      <rapid::components>
       @ security_schemes: <rapid::security_schemes>
       .. @ name       : chr(0) 
       .. @ details    : <rapid::security_scheme_details>  list()
       .. @ description: chr(0) 

# as_components() errors for unnamed input

    Code
      as_components(as.list(letters))
    Condition
      Error:
      ! `as.list(letters)` must have names "security_schemes".
      * Any other names are ignored.

---

    Code
      as_components(list("My Cool API"))
    Condition
      Error:
      ! `list("My Cool API")` must have names "security_schemes".
      * Any other names are ignored.

# as_components() errors informatively for bad classes

    Code
      as_components(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <rapid::components>.

---

    Code
      as_components(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <rapid::components>.

---

    Code
      as_components(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <rapid::components>.

