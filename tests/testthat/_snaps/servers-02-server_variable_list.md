# server_variable_list() errors informatively for bad contents

    Code
      server_variable_list(letters)
    Condition
      Error:
      ! <rapid::server_variable_list> object is invalid:
      - All values must be <server_variable> objects.
      - Bad values at 1.

---

    Code
      server_variable_list(list(letters, letters))
    Condition
      Error:
      ! <rapid::server_variable_list> object is invalid:
      - All values must be <server_variable> objects.
      - Bad values at 1 and 2.

---

    Code
      server_variable_list(server_variable(), letters, server_variable(), letters)
    Condition
      Error:
      ! <rapid::server_variable_list> object is invalid:
      - All values must be <server_variable> objects.
      - Bad values at 2 and 4.

# server_variable_list() returns an empty server_variable_list

    Code
      server_variable_list()
    Output
      <rapid::server_variable_list>  list()

# server_variable_list() accepts bare server_variables

    Code
      server_variable_list(server_variable())
    Output
      <rapid::server_variable_list> List of 1
       $ : <rapid::server_variable>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

---

    Code
      server_variable_list(server_variable(), server_variable())
    Output
      <rapid::server_variable_list> List of 2
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

# server_variable_list() accepts lists of server_variables

    Code
      server_variable_list(list(server_variable()))
    Output
      <rapid::server_variable_list> List of 1
       $ : <rapid::server_variable>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

---

    Code
      server_variable_list(list(server_variable(), server_variable()))
    Output
      <rapid::server_variable_list> List of 2
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

