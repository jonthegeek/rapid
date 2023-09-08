# servers() returns an empty server

    Code
      test_result <- servers()
      test_result
    Output
      <rapid::servers>
       @ url        : chr(0) 
       @ description: chr(0) 
       @ variables  : <rapid::variables>  list()

# as_servers() errors informatively for unnamed or misnamed input

    Code
      as_servers(letters)
    Condition <rlang_error>
      Error:
      ! `x` must have names "url", "description", or "variables".
      * Any other names are ignored.

---

    Code
      as_servers(list(a = "https://example.com", b = "A cool server."))
    Condition <rlang_error>
      Error:
      ! `x` must have names "url", "description", or "variables".
      * Any other names are ignored.

---

    Code
      as_servers(c(a = "https://example.com", b = "A cool server."))
    Condition <rlang_error>
      Error:
      ! `x` must have names "url", "description", or "variables".
      * Any other names are ignored.

