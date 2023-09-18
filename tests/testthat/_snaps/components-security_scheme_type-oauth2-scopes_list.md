# scopes_list() errors informatively for bad contents

    Code
      scopes_list(letters)
    Condition
      Error:
      ! <rapid::scopes_list> object is invalid:
      - All values must be <scopes> objects.
      - Bad values at 1.

---

    Code
      scopes_list(list(letters, letters))
    Condition
      Error:
      ! <rapid::scopes_list> object is invalid:
      - All values must be <scopes> objects.
      - Bad values at 1 and 2.

---

    Code
      scopes_list(scopes(), letters, scopes(), letters)
    Condition
      Error:
      ! <rapid::scopes_list> object is invalid:
      - All values must be <scopes> objects.
      - Bad values at 2 and 4.

# scopes_list() returns an empty scopes_list

    Code
      scopes_list()
    Output
      <rapid::scopes_list>  list()

# scopes_list() accepts bare scopes

    Code
      scopes_list(scopes())
    Output
      <rapid::scopes_list> List of 1
       $ : <rapid::scopes>
        ..@ name       : chr(0) 
        ..@ description: chr(0) 

---

    Code
      scopes_list(scopes(), scopes())
    Output
      <rapid::scopes_list> List of 2
       $ : <rapid::scopes>
        ..@ name       : chr(0) 
        ..@ description: chr(0) 
       $ : <rapid::scopes>
        ..@ name       : chr(0) 
        ..@ description: chr(0) 

# scopes_list() accepts lists of scopes

    Code
      scopes_list(list(scopes()))
    Output
      <rapid::scopes_list> List of 1
       $ : <rapid::scopes>
        ..@ name       : chr(0) 
        ..@ description: chr(0) 

---

    Code
      scopes_list(list(scopes(), scopes()))
    Output
      <rapid::scopes_list> List of 2
       $ : <rapid::scopes>
        ..@ name       : chr(0) 
        ..@ description: chr(0) 
       $ : <rapid::scopes>
        ..@ name       : chr(0) 
        ..@ description: chr(0) 

# as_scopes_list() errors informatively for bad classes

    Code
      as_scopes_list(1:2)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <integer> to <scopes_list>.

---

    Code
      as_scopes_list(mean)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <function> to <scopes_list>.

---

    Code
      as_scopes_list(TRUE)
    Condition <rlang_error>
      Error:
      ! Can't coerce `x` <logical> to <scopes_list>.

