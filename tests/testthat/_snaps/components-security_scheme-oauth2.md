# oauth2_security_scheme() requires names

    Code
      oauth2_security_scheme(oauth2_token_flow())
    Condition
      Error in `oauth2_security_scheme()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = oauth2_token_flow()
      i Did you forget to name an argument?

# oauth2_security_scheme() requires the right types of flows

    Code
      oauth2_security_scheme(implicit_flow = oauth2_token_flow())
    Condition
      Error:
      ! Can't coerce `implicit_flow` <rapid::oauth2_token_flow/rapid::oauth2_flow/S7_object> to <oauth2_implicit_flow>.

---

    Code
      oauth2_security_scheme(password_flow = oauth2_implicit_flow())
    Condition
      Error:
      ! Can't coerce `password_flow` <rapid::oauth2_implicit_flow/rapid::oauth2_flow/S7_object> to <oauth2_token_flow>.

---

    Code
      oauth2_security_scheme(client_credentials_flow = oauth2_implicit_flow())
    Condition
      Error:
      ! Can't coerce `client_credentials_flow` <rapid::oauth2_implicit_flow/rapid::oauth2_flow/S7_object> to <oauth2_token_flow>.

---

    Code
      oauth2_security_scheme(authorization_code_flow = oauth2_implicit_flow())
    Condition
      Error:
      ! Can't coerce `authorization_code_flow` <rapid::oauth2_implicit_flow/rapid::oauth2_flow/S7_object> to <oauth2_authorization_code_flow>.

# oauth2_security_scheme() works with valid objects

    Code
      test_result <- oauth2_security_scheme(password_flow = oauth2_token_flow(
        token_url = "/tokens/passwords"))
      test_result
    Output
      <rapid::oauth2_security_scheme>
       @ implicit_flow          : <rapid::oauth2_implicit_flow>
       .. @ refresh_url      : chr(0) 
       .. @ scopes           : <rapid::scopes>
       .. .. @ name       : chr(0) 
       .. .. @ description: chr(0) 
       .. @ authorization_url: chr(0) 
       @ password_flow          : <rapid::oauth2_token_flow>
       .. @ refresh_url: chr(0) 
       .. @ scopes     : <rapid::scopes>
       .. .. @ name       : chr(0) 
       .. .. @ description: chr(0) 
       .. @ token_url  : chr "/tokens/passwords"
       @ client_credentials_flow: <rapid::oauth2_token_flow>
       .. @ refresh_url: chr(0) 
       .. @ scopes     : <rapid::scopes>
       .. .. @ name       : chr(0) 
       .. .. @ description: chr(0) 
       .. @ token_url  : chr(0) 
       @ authorization_code_flow: <rapid::oauth2_authorization_code_flow>
       .. @ refresh_url      : chr(0) 
       .. @ scopes           : <rapid::scopes>
       .. .. @ name       : chr(0) 
       .. .. @ description: chr(0) 
       .. @ authorization_url: chr(0) 
       .. @ token_url        : chr(0) 

# as_oauth2_security_scheme() errors for unnamed input

    Code
      as_oauth2_security_scheme(list("Jon", "jonthegeek@gmail.com"))
    Condition
      Error:
      ! `x` must contain a named flows object.

# as_oauth2_security_scheme() errors for bad classes

    Code
      as_oauth2_security_scheme(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <oauth2_security_scheme>.

---

    Code
      as_oauth2_security_scheme(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <oauth2_security_scheme>.

---

    Code
      as_oauth2_security_scheme(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <oauth2_security_scheme>.

