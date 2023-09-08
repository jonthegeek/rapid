# servers() returns an empty server

    Code
      test_result <- servers()
      test_result
    Output
      <rapid::servers>
       @ url        : chr(0) 
       @ description: chr(0) 
       @ variables  : <rapid::server_variables>  list()

# as_servers() errors informatively for unnamed or misnamed input

    Code
      as_servers(letters)
    Condition <purrr_error_indexed>
      Error in `purrr::map_chr()`:
      i In index: 1.
      Caused by error:
      ! Result must be length 1, not 0.

---

    Code
      as_servers(list(a = "https://example.com", b = "A cool server."))
    Condition <purrr_error_indexed>
      Error in `purrr::map_chr()`:
      i In index: 1.
      i With name: a.
      Caused by error:
      ! Result must be length 1, not 0.

---

    Code
      as_servers(c(a = "https://example.com", b = "A cool server."))
    Condition <purrr_error_indexed>
      Error in `purrr::map_chr()`:
      i In index: 1.
      i With name: a.
      Caused by error:
      ! Result must be length 1, not 0.

