# class_security_scheme_details() errors informatively for bad contents

    Code
      class_security_scheme_details(letters)
    Condition
      Error:
      ! <rapid::security_scheme_details> object is invalid:
      - All values must be <security_scheme> objects.
      - Bad values at 1.

---

    Code
      class_security_scheme_details(list(letters, letters))
    Condition
      Error:
      ! <rapid::security_scheme_details> object is invalid:
      - All values must be <security_scheme> objects.
      - Bad values at 1 and 2.

---

    Code
      class_security_scheme_details(class_api_key_security_scheme(), letters,
      class_oauth2_security_scheme(), letters)
    Condition
      Error:
      ! <rapid::security_scheme_details> object is invalid:
      - All values must be <security_scheme> objects.
      - Bad values at 2 and 4.

# class_security_scheme_details() returns empty security_scheme_details

    Code
      class_security_scheme_details()
    Output
      <rapid::security_scheme_details>  list()

# class_security_scheme_details() accepts bare security_schemes

    Code
      class_security_scheme_details(class_api_key_security_scheme())
    Output
      <rapid::security_scheme_details> List of 1
       $ : <rapid::api_key_security_scheme>
        ..@ parameter_name: chr(0) 
        ..@ location      : chr(0) 

---

    Code
      class_security_scheme_details(class_api_key_security_scheme(),
      class_oauth2_security_scheme())
    Output
      <rapid::security_scheme_details> List of 2
       $ : <rapid::api_key_security_scheme>
        ..@ parameter_name: chr(0) 
        ..@ location      : chr(0) 
       $ : <rapid::oauth2_security_scheme>
        ..@ implicit_flow          : <rapid::oauth2_implicit_flow>
       .. .. @ refresh_url      : chr(0) 
       .. .. @ scopes           : <rapid::scopes>
       .. .. .. @ name       : chr(0) 
       .. .. .. @ description: chr(0) 
       .. .. @ authorization_url: chr(0) 
        ..@ password_flow          : <rapid::oauth2_token_flow>
       .. .. @ refresh_url: chr(0) 
       .. .. @ scopes     : <rapid::scopes>
       .. .. .. @ name       : chr(0) 
       .. .. .. @ description: chr(0) 
       .. .. @ token_url  : chr(0) 
        ..@ client_credentials_flow: <rapid::oauth2_token_flow>
       .. .. @ refresh_url: chr(0) 
       .. .. @ scopes     : <rapid::scopes>
       .. .. .. @ name       : chr(0) 
       .. .. .. @ description: chr(0) 
       .. .. @ token_url  : chr(0) 
        ..@ authorization_code_flow: <rapid::oauth2_authorization_code_flow>
       .. .. @ refresh_url      : chr(0) 
       .. .. @ scopes           : <rapid::scopes>
       .. .. .. @ name       : chr(0) 
       .. .. .. @ description: chr(0) 
       .. .. @ authorization_url: chr(0) 
       .. .. @ token_url        : chr(0) 

# class_security_scheme_details() accepts lists of security_schemes

    Code
      class_security_scheme_details(list(class_api_key_security_scheme()))
    Output
      <rapid::security_scheme_details> List of 1
       $ : <rapid::api_key_security_scheme>
        ..@ parameter_name: chr(0) 
        ..@ location      : chr(0) 

---

    Code
      class_security_scheme_details(list(class_api_key_security_scheme(),
      class_oauth2_security_scheme()))
    Output
      <rapid::security_scheme_details> List of 2
       $ : <rapid::api_key_security_scheme>
        ..@ parameter_name: chr(0) 
        ..@ location      : chr(0) 
       $ : <rapid::oauth2_security_scheme>
        ..@ implicit_flow          : <rapid::oauth2_implicit_flow>
       .. .. @ refresh_url      : chr(0) 
       .. .. @ scopes           : <rapid::scopes>
       .. .. .. @ name       : chr(0) 
       .. .. .. @ description: chr(0) 
       .. .. @ authorization_url: chr(0) 
        ..@ password_flow          : <rapid::oauth2_token_flow>
       .. .. @ refresh_url: chr(0) 
       .. .. @ scopes     : <rapid::scopes>
       .. .. .. @ name       : chr(0) 
       .. .. .. @ description: chr(0) 
       .. .. @ token_url  : chr(0) 
        ..@ client_credentials_flow: <rapid::oauth2_token_flow>
       .. .. @ refresh_url: chr(0) 
       .. .. @ scopes     : <rapid::scopes>
       .. .. .. @ name       : chr(0) 
       .. .. .. @ description: chr(0) 
       .. .. @ token_url  : chr(0) 
        ..@ authorization_code_flow: <rapid::oauth2_authorization_code_flow>
       .. .. @ refresh_url      : chr(0) 
       .. .. @ scopes           : <rapid::scopes>
       .. .. .. @ name       : chr(0) 
       .. .. .. @ description: chr(0) 
       .. .. @ authorization_url: chr(0) 
       .. .. @ token_url        : chr(0) 

# as_security_scheme_details() errors informatively for bad classes

    Code
      as_security_scheme_details(1:2)
    Condition
      Error in `as_security_scheme_details()`:
      ! Can't coerce `1:2` <integer> to <rapid::security_scheme_details>.

---

    Code
      as_security_scheme_details(mean)
    Condition
      Error in `as_security_scheme_details()`:
      ! Can't coerce `mean` <function> to <rapid::security_scheme_details>.

---

    Code
      as_security_scheme_details(TRUE)
    Condition
      Error in `as_security_scheme_details()`:
      ! Can't coerce `TRUE` <logical> to <rapid::security_scheme_details>.

