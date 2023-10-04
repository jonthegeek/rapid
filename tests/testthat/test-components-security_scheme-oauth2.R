test_that("oauth2_security_scheme() requires names", {
  expect_snapshot(
    oauth2_security_scheme(oauth2_token_flow()),
    error = TRUE
  )
})

test_that("oauth2_security_scheme() requires the right types of flows", {
  expect_snapshot(
    oauth2_security_scheme(
      implicit_flow = oauth2_token_flow()
    ),
    error = TRUE
  )
  expect_snapshot(
    oauth2_security_scheme(
      password_flow = oauth2_implicit_flow()
    ),
    error = TRUE
  )
  expect_snapshot(
    oauth2_security_scheme(
      client_credentials_flow = oauth2_implicit_flow()
    ),
    error = TRUE
  )
  expect_snapshot(
    oauth2_security_scheme(
      authorization_code_flow = oauth2_implicit_flow()
    ),
    error = TRUE
  )
})

test_that("oauth2_security_scheme() works with valid objects", {
  expect_snapshot({
    test_result <- oauth2_security_scheme(
      password_flow = oauth2_token_flow(token_url = "/tokens/passwords")
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c(
      "rapid::oauth2_security_scheme",
      "rapid::security_scheme",
      "S7_object"
    ),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c(
      "implicit_flow", "password_flow",
      "client_credentials_flow", "authorization_code_flow"
    )
  )
})

test_that("length() of a oauth2_security_scheme reports the proper length", {
  expect_equal(length(oauth2_security_scheme()), 0)
  expect_equal(
    length(
      oauth2_security_scheme(
        password_flow = oauth2_token_flow(token_url = "/tokens/passwords")
      )
    ),
    1
  )
})

test_that("as_oauth2_security_scheme() errors informatively for unnamed or misnamed input", {
  expect_snapshot(
    as_oauth2_security_scheme(
      list(a = "Jon", b = "jonthegeek@gmail.com")
    ),
    error = TRUE
  )
})

test_that("as_oauth2_security_scheme() errors informatively for bad classes", {
  expect_snapshot(
    as_oauth2_security_scheme(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_oauth2_security_scheme(mean),
    error = TRUE
  )
  expect_snapshot(
    as_oauth2_security_scheme(TRUE),
    error = TRUE
  )
})

test_that("as_oauth2_security_scheme() returns expected objects", {
  expect_identical(
    as_oauth2_security_scheme(
      list(
        flows = list(
          authorizationCode = list(
            authorizationUrl = "https://api.gettyimages.com/v4/oauth2/auth",
            refreshUrl = "https://api.gettyimages.com/v4/oauth2/token",
            tokenUrl = "https://api.gettyimages.com/v4/oauth2/token"
          ),
          clientCredentials = list(
            tokenUrl = "https://api.gettyimages.com/v4/oauth2/token"
          ),
          implicit = list(
            authorizationUrl = "https://api.gettyimages.com/v4/oauth2/auth",
            scopes = list()
          ),
          password = list(
            refreshUrl = "https://api.gettyimages.com/v4/oauth2/token",
            tokenUrl = "https://api.gettyimages.com/v4/oauth2/token"
          )
        ),
        type = "oauth2"
      )
    ),
    oauth2_security_scheme(
      implicit_flow = oauth2_implicit_flow(
        authorization_url = "https://api.gettyimages.com/v4/oauth2/auth"
      ),
      password_flow = oauth2_token_flow(
        token_url = "https://api.gettyimages.com/v4/oauth2/token",
        refresh_url = "https://api.gettyimages.com/v4/oauth2/token"
      ),
      client_credentials_flow = oauth2_token_flow(
        token_url = "https://api.gettyimages.com/v4/oauth2/token"
      ),
      authorization_code_flow = oauth2_authorization_code_flow(
        token_url = "https://api.gettyimages.com/v4/oauth2/token",
        refresh_url = "https://api.gettyimages.com/v4/oauth2/token",
        authorization_url = "https://api.gettyimages.com/v4/oauth2/auth"
      )
    )
  )

  expect_identical(
    as_oauth2_security_scheme(list()),
    oauth2_security_scheme()
  )
})

test_that("as_oauth2_security_scheme() works for oauth2_security_scheme", {
  expect_identical(
    as_oauth2_security_scheme(oauth2_security_scheme()),
    oauth2_security_scheme()
  )
})
