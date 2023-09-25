# oauth2_authorization_code_flow() requires names for optional params

    Code
      api_key_security_scheme(location = "invalid place", parameter_name = "parm1")
    Condition
      Error:
      ! <rapid::api_key_security_scheme> object is invalid:
      - `location` must be one of "query", "header", or "cookie".
      - "invalid place" is not in "query", "header", and "cookie".

