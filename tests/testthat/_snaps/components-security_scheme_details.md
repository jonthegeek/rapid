# security_scheme_details() errors informatively for bad contents

    Code
      security_scheme_details(letters)
    Condition
      Error:
      ! <rapid::security_scheme_details> object is invalid:
      - All values must be <security_scheme> objects.
      - Bad values at 1.

---

    Code
      security_scheme_details(list(letters, letters))
    Condition
      Error:
      ! <rapid::security_scheme_details> object is invalid:
      - All values must be <security_scheme> objects.
      - Bad values at 1 and 2.

---

    Code
      security_scheme_details(api_key_security_scheme(), letters,
      oauth2_security_scheme(), letters)
    Condition
      Error:
      ! <rapid::security_scheme_details> object is invalid:
      - All values must be <security_scheme> objects.
      - Bad values at 2 and 4.

# security_scheme_details() returns an empty security_scheme_details

    Code
      security_scheme_details()
    Output
      <rapid::security_scheme_details>  list()

# security_scheme_details() accepts bare security_schemes

    Code
      security_scheme_details(api_key_security_scheme())
    Output
      <rapid::security_scheme_details> List of 1
       $ : <rapid::api_key_security_scheme>
        ..@ parameter_name: chr(0) 
        ..@ location      : chr(0) 

---

    Code
      security_scheme_details(api_key_security_scheme(), oauth2_security_scheme())
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
        ..@ authorization_code_flow: <rapid::oauth2_token_flow>
       .. .. @ refresh_url      : chr(0) 
       .. .. @ scopes           : <rapid::scopes>
       .. .. .. @ name       : chr(0) 
       .. .. .. @ description: chr(0) 
       .. .. @ authorization_url: chr(0) 
       .. .. @ token_url        : chr(0) 

# security_scheme_details() accepts lists of security_schemes

    Code
      security_scheme_details(list(api_key_security_scheme()))
    Output
      <rapid::security_scheme_details> List of 1
       $ : <rapid::api_key_security_scheme>
        ..@ parameter_name: chr(0) 
        ..@ location      : chr(0) 

---

    Code
      security_scheme_details(list(api_key_security_scheme(), oauth2_security_scheme()))
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
        ..@ authorization_code_flow: <rapid::oauth2_token_flow>
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
      Error:
      ! Can't coerce `x` <integer> to <security_scheme_details>.

---

    Code
      as_security_scheme_details(mean)
    Condition
      Error:
      ! Can't coerce `x` <function> to <security_scheme_details>.

---

    Code
      as_security_scheme_details(TRUE)
    Condition
      Error:
      ! Can't coerce `x` <logical> to <security_scheme_details>.

