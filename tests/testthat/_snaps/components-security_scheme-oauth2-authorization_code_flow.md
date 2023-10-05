# oauth2_authorization_code_flow() requires compatible lengths

    Code
      oauth2_authorization_code_flow("a")
    Condition
      Error:
      ! <rapid::oauth2_authorization_code_flow> object is invalid:
      - `token_url` must have the same length as `authorization_url`
      - `authorization_url` has 1 value.
      - `token_url` has no values.

---

    Code
      oauth2_authorization_code_flow(token_url = "a")
    Condition
      Error:
      ! <rapid::oauth2_authorization_code_flow> object is invalid:
      - When `authorization_url` is not defined, `token_url` must be empty.
      - `token_url` has 1 value.

---

    Code
      oauth2_authorization_code_flow(refresh_url = "a")
    Condition
      Error:
      ! <rapid::oauth2_authorization_code_flow> object is invalid:
      - When `authorization_url` is not defined, `refresh_url` must be empty.
      - `refresh_url` has 1 value.

---

    Code
      oauth2_authorization_code_flow(scopes = c(a = "a"))
    Condition
      Error:
      ! <rapid::oauth2_authorization_code_flow> object is invalid:
      - When `authorization_url` is not defined, `scopes` must be empty.
      - `scopes` has 1 value.

# oauth2_authorization_code_flow() returns empty

    Code
      oauth2_authorization_code_flow()
    Output
      <rapid::oauth2_authorization_code_flow>
       @ refresh_url      : chr(0) 
       @ scopes           : <rapid::scopes>
       .. @ name       : chr(0) 
       .. @ description: chr(0) 
       @ authorization_url: chr(0) 
       @ token_url        : chr(0) 

# oauth2_authorization_code_flow() requires names for optionals

    Code
      oauth2_authorization_code_flow("a", "b", "c")
    Condition
      Error in `oauth2_authorization_code_flow()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = "c"
      i Did you forget to name an argument?

---

    Code
      oauth2_authorization_code_flow("a", "b", refresh_url = "c", c(d = "d"))
    Condition
      Error in `oauth2_authorization_code_flow()`:
      ! `...` must be empty.
      x Problematic argument:
      * ..1 = c(d = "d")
      i Did you forget to name an argument?

# oauth2_authorization_code_flow() errors for bad classes

    Code
      oauth2_authorization_code_flow(mean, mean)
    Condition
      Error in `oauth2_authorization_code_flow()`:
      ! Can't coerce `authorization_url` <function> to <character>.

---

    Code
      oauth2_authorization_code_flow("a", mean)
    Condition
      Error in `oauth2_authorization_code_flow()`:
      ! Can't coerce `token_url` <function> to <character>.

---

    Code
      oauth2_authorization_code_flow("a", "b", refresh_url = mean)
    Condition
      Error in `oauth2_authorization_code_flow()`:
      ! Can't coerce `refresh_url` <function> to <character>.

---

    Code
      oauth2_authorization_code_flow("a", "b", refresh_url = "c", scopes = "d")
    Condition
      Error:
      ! `scopes` must be a named character vector.

# oauth2_authorization_code_flow() returns expected objects

    Code
      test_result <- oauth2_authorization_code_flow(authorization_url = "https://auth.ebay.com/oauth2/authorize",
        token_url = "https://api.ebay.com/identity/v1/oauth2/token", scopes = c(
          sell.account = "View and manage your account settings",
          sell.account.readonly = "View your account settings"), refresh_url = "https://api.ebay.com/identity/v1/oauth2/refresh")
      test_result
    Output
      <rapid::oauth2_authorization_code_flow>
       @ refresh_url      : chr "https://api.ebay.com/identity/v1/oauth2/refresh"
       @ scopes           : <rapid::scopes>
       .. @ name       : chr [1:2] "sell.account" "sell.account.readonly"
       .. @ description: chr [1:2] "View and manage your account settings" ...
       @ authorization_url: chr "https://auth.ebay.com/oauth2/authorize"
       @ token_url        : chr "https://api.ebay.com/identity/v1/oauth2/token"

# as_oauth2_authorization_code_flow() errors for un/misnamed input

    Code
      as_oauth2_authorization_code_flow("a")
    Condition
      Error:
      ! `x` must have names "refresh_url", "scopes", "authorization_url", or "token_url".
      * Any other names are ignored.

---

    Code
      as_oauth2_authorization_code_flow(list(a = "Jon", b = "jtg@gmail.com"))
    Condition
      Error:
      ! `x` must have names "refresh_url", "scopes", "authorization_url", or "token_url".
      * Any other names are ignored.

# as_oauth2_authorization_code_flow() errors for bad classes

    Code
      as_oauth2_authorization_code_flow(1:2)
    Condition
      Error:
      ! Can't coerce `1:2` <integer> to <oauth2_authorization_code_flow>.

---

    Code
      as_oauth2_authorization_code_flow(mean)
    Condition
      Error:
      ! Can't coerce `mean` <function> to <oauth2_authorization_code_flow>.

---

    Code
      as_oauth2_authorization_code_flow(TRUE)
    Condition
      Error:
      ! Can't coerce `TRUE` <logical> to <oauth2_authorization_code_flow>.

