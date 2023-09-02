# servers() requires URLs for urls

    Code
      servers(url = mean)
    Condition <rlang_error>
      Error in `servers()`:
      ! Can't coerce `url` <function> to <character>.

---

    Code
      servers(url = c("A", "B"))
    Condition <rlang_error>
      Error in `servers()`:
      ! `url` must match the provided regex pattern.
      x Some values do not match.
      * Locations: 1 and 2

---

    Code
      servers(url = "not a real url")
    Condition <rlang_error>
      Error in `servers()`:
      ! `url` must match the provided regex pattern.
      x Some values do not match.
      * Locations: 1

# servers() returns an empty server

    Code
      test_result <- servers()
      test_result
    Output
      <rapid::servers>
       @ url        : chr(0) 
       @ description: chr(0) 
       @ variables  : <rapid::server_variable_list>  list()

