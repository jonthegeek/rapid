# variables() errors informatively for bad contents

    Code
      variables(letters)
    Condition
      Error:
      ! <rapid::variables> object is invalid:
      - All values must be <server_variable> objects.
      - Bad values at 1.

---

    Code
      variables(list(letters, letters))
    Condition
      Error:
      ! <rapid::variables> object is invalid:
      - All values must be <server_variable> objects.
      - Bad values at 1 and 2.

---

    Code
      variables(server_variable(), letters, server_variable(), letters)
    Condition
      Error:
      ! <rapid::variables> object is invalid:
      - All values must be <server_variable> objects.
      - Bad values at 2 and 4.

# variables() returns an empty variables

    Code
      variables()
    Output
      <rapid::variables>  list()

# variables() accepts bare server_variables

    Code
      variables(server_variable())
    Output
      <rapid::variables> List of 1
       $ : <rapid::server_variable>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

---

    Code
      variables(server_variable(), server_variable())
    Output
      <rapid::variables> List of 2
       $ : <rapid::server_variable>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 
       $ : <rapid::server_variable>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

# variables() accepts lists of server_variables

    Code
      variables(list(server_variable()))
    Output
      <rapid::variables> List of 1
       $ : <rapid::server_variable>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

---

    Code
      variables(list(server_variable(), server_variable()))
    Output
      <rapid::variables> List of 2
       $ : <rapid::server_variable>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 
       $ : <rapid::server_variable>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

# as_variables() errors informatively for bad classes

    Code
      as_variables(1:2)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <integer> to <variables>.

---

    Code
      as_variables(mean)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <function> to <variables>.

---

    Code
      as_variables(TRUE)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <logical> to <variables>.

