# server_variables() errors informatively for bad contents

    Code
      server_variables(letters)
    Condition
      Error:
      ! <rapid::server_variables> object is invalid:
      - All values must be <string_replacements> objects.
      - Bad values at 1.

---

    Code
      server_variables(list(letters, letters))
    Condition
      Error:
      ! <rapid::server_variables> object is invalid:
      - All values must be <string_replacements> objects.
      - Bad values at 1 and 2.

---

    Code
      server_variables(string_replacements(), letters, string_replacements(), letters)
    Condition
      Error:
      ! <rapid::server_variables> object is invalid:
      - All values must be <string_replacements> objects.
      - Bad values at 2 and 4.

# server_variables() returns an empty server_variables

    Code
      server_variables()
    Output
      <rapid::server_variables>  list()

# server_variables() accepts bare string_replacements

    Code
      server_variables(string_replacements())
    Output
      <rapid::server_variables> List of 1
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : NULL
        ..@ description: chr(0) 

---

    Code
      server_variables(string_replacements(), string_replacements())
    Output
      <rapid::server_variables> List of 2
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : NULL
        ..@ description: chr(0) 
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : NULL
        ..@ description: chr(0) 

# server_variables() accepts lists of string_replacements

    Code
      server_variables(list(string_replacements()))
    Output
      <rapid::server_variables> List of 1
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : NULL
        ..@ description: chr(0) 

---

    Code
      server_variables(list(string_replacements(), string_replacements()))
    Output
      <rapid::server_variables> List of 2
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : NULL
        ..@ description: chr(0) 
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : NULL
        ..@ description: chr(0) 

# as_server_variables() errors informatively for bad classes

    Code
      as_server_variables(1:2)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <integer> to <server_variables>.

---

    Code
      as_server_variables(mean)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <function> to <server_variables>.

---

    Code
      as_server_variables(TRUE)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <logical> to <server_variables>.

