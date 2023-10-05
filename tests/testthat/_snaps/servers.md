# servers() returns an empty server

    Code
      test_result <- servers()
      test_result
    Output
      <rapid::servers>
       @ url        : chr(0) 
       @ description: chr(0) 
       @ variables  : <rapid::server_variables>  list()

# as_servers() errors informatively for unnamed input

    Code
      as_servers(list(letters))
    Condition
      Error in `purrr::map()`:
      i In index: 1.
      Caused by error in `as_servers()`:
      ! `x[[i]]` must have names "url", "description", or "variables".
      * Any other names are ignored.

# as_servers() errors informatively for bad classes

    Code
      as_servers(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <servers>.

---

    Code
      as_servers(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <servers>.

---

    Code
      as_servers(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <servers>.

