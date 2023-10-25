# component_collection() returns an empty component_collection

    Code
      test_result <- component_collection()
      test_result
    Output
      <rapid::component_collection>
       @ security_schemes: <rapid::security_scheme_collection>
       .. @ name       : chr(0) 
       .. @ details    : <rapid::security_scheme_details>  list()
       .. @ description: chr(0) 

# as_component_collection() errors for unnamed input

    Code
      as_component_collection(as.list(letters))
    Condition
      Error:
      ! `as.list(letters)` must have names "security_schemes".
      * Any other names are ignored.

---

    Code
      as_component_collection(list("My Cool API"))
    Condition
      Error:
      ! `list("My Cool API")` must have names "security_schemes".
      * Any other names are ignored.

# as_component_collection() errors informatively for bad classes

    Code
      as_component_collection(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <rapid::component_collection>.

---

    Code
      as_component_collection(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <rapid::component_collection>.

---

    Code
      as_component_collection(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <rapid::component_collection>.
