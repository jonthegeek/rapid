# class_server_variables() errors informatively for bad contents

    Code
      class_server_variables(letters)
    Condition
      Error:
      ! <rapid::server_variables> object is invalid:
      - All values must be <string_replacements> objects.
      - Bad values at 1.

---

    Code
      class_server_variables(list(letters, letters))
    Condition
      Error:
      ! <rapid::server_variables> object is invalid:
      - All values must be <string_replacements> objects.
      - Bad values at 1 and 2.

---

    Code
      class_server_variables(class_string_replacements(), letters,
      class_string_replacements(), letters)
    Condition
      Error:
      ! <rapid::server_variables> object is invalid:
      - All values must be <string_replacements> objects.
      - Bad values at 2 and 4.

# class_server_variables() returns an empty server_variables

    Code
      class_server_variables()
    Output
      <rapid::server_variables>  list()

# class_server_variables() accepts bare string_replacements

    Code
      class_server_variables(class_string_replacements())
    Output
      <rapid::server_variables> List of 1
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

---

    Code
      class_server_variables(class_string_replacements(), class_string_replacements())
    Output
      <rapid::server_variables> List of 2
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

# class_server_variables() accepts lists of string_replacements

    Code
      class_server_variables(list(class_string_replacements()))
    Output
      <rapid::server_variables> List of 1
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

---

    Code
      class_server_variables(list(class_string_replacements(),
      class_string_replacements()))
    Output
      <rapid::server_variables> List of 2
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 
       $ : <rapid::string_replacements>
        ..@ name       : chr(0) 
        ..@ default    : chr(0) 
        ..@ enum       : list()
        ..@ description: chr(0) 

# as_server_variables() errors informatively for bad classes

    Code
      as_server_variables(1:2)
    Condition
      Error in `as_server_variables()`:
      ! Can't coerce `1:2` <integer> to <rapid::server_variables>.

---

    Code
      as_server_variables(mean)
    Condition
      Error in `as_server_variables()`:
      ! Can't coerce `mean` <function> to <rapid::server_variables>.

---

    Code
      as_server_variables(TRUE)
    Condition
      Error in `as_server_variables()`:
      ! Can't coerce `TRUE` <logical> to <rapid::server_variables>.

