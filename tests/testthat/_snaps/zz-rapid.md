# rapid() requires info objects for info

    Code
      rapid(info = mean)
    Condition <simpleError>
      Error:
      ! <rapid::rapid> object properties are invalid:
      - @info must be <rapid::info>, not <closure>

# rapid() requires info when anything is defined

    Code
      rapid(servers = servers(url = c("https://development.gigantic-server.com/v1",
        "https://staging.gigantic-server.com/v1",
        "https://api.gigantic-server.com/v1"), description = c("Development server",
        "Staging server", "Production server")))
    Condition
      Error:
      ! <rapid::rapid> object is invalid:
      - When `info` is not defined, `servers` must be empty.
      - `servers` has 3 values.

# rapid() returns an empty rapid

    Code
      test_result <- rapid()
      test_result
    Output
      <rapid::rapid>
       @ info   : <rapid::info>
       .. @ contact         : <rapid::contact>
       .. .. @ name : chr(0) 
       .. .. @ email: chr(0) 
       .. .. @ url  : chr(0) 
       .. @ description     : chr(0) 
       .. @ license         : <rapid::license>
       .. .. @ name      : chr(0) 
       .. .. @ identifier: chr(0) 
       .. .. @ url       : chr(0) 
       .. @ summary         : chr(0) 
       .. @ terms_of_service: chr(0) 
       .. @ title           : chr(0) 
       .. @ version         : chr(0) 
       @ servers: <rapid::servers>
       .. @ url        : chr(0) 
       .. @ description: chr(0) 
       .. @ variables  : <rapid::server_variable_list>  list()

