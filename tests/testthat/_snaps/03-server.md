# server() requires URLs for url

    Code
      server(url = mean)
    Condition <rlang_error>
      Error in `server()`:
      ! Can't coerce `url` <function> to <character>.

---

    Code
      server(url = c("A", "B"))
    Condition <rlang_error>
      Error in `server()`:
      ! `url` must match the provided regex pattern.
      x Some values do not match.
      * Locations: 1 and 2

---

    Code
      server(url = "not a real url")
    Condition <rlang_error>
      Error in `server()`:
      ! `url` must match the provided regex pattern.
      x Some values do not match.
      * Locations: 1

# server() returns an empty server

    Code
      test_result <- server()
      test_result
    Output
      <rapid::server>
       @ url        : chr(0) 
       @ description: chr(0) 
       @ variables  : <rapid::server_variable_list>  list()

