test_that("as_security_scheme() errors informatively for bad classes", {
  expect_snapshot(
    as_security_scheme(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_security_scheme(mean),
    error = TRUE
  )
  expect_snapshot(
    as_security_scheme(TRUE),
    error = TRUE
  )
})

test_that("as_security_scheme() works for security_schemes", {
  expect_identical(
    as_security_scheme(oauth2_security_scheme()),
    oauth2_security_scheme()
  )
  expect_identical(
    as_security_scheme(api_key_security_scheme()),
    api_key_security_scheme()
  )
})

test_that("as_security_scheme() returns expected objects", {
  expect_identical(
    as_security_scheme(
      list(
        description = "Account JWT token",
        flows = list(
          password = list(
            scopes = list(
              Catalog = "Access all read-only content",
              Commerce = "Perform account-level transactions",
              Playback = "Allow playback of restricted content",
              Settings = "Modify account settings"
            ),
            tokenUrl = "/account/authorization"
          )
        ),
        type = "oauth2"
      )
    ),
    oauth2_security_scheme(
      password_flow = oauth2_token_flow(
        token_url = "/account/authorization",
        scopes = scopes(
          name = c("Catalog", "Commerce", "Playback", "Settings"),
          description = c(
            "Access all read-only content",
            "Perform account-level transactions",
            "Allow playback of restricted content",
            "Modify account settings"
          )
        )
      )
    )
  )

  expect_identical(
    as_security_scheme(
      list(
        description = "Profile JWT token",
        flows = list(
          password = list(
            scopes = list(
              Catalog = "Modify profile preferences and activity"
            ),
            tokenUrl = "/account/profile/authorization"
          )
        ),
        type = "oauth2"
      )
    ),
    oauth2_security_scheme(
      password_flow = oauth2_token_flow(
        token_url = "/account/profile/authorization",
        scopes = scopes(
          name = "Catalog",
          description = "Modify profile preferences and activity"
        )
      )
    )
  )

  expect_identical(
    as_security_scheme(list()),
    NULL
  )
})

test_that("as_security_scheme() works for re-named parameters", {
  expect_identical(
    as_security_scheme(
      list(
        `in` = "header",
        name = "authorization",
        type = "apiKey"
      )
    ),
    api_key_security_scheme(
      parameter_name = "authorization",
      location = "header"
    )
  )
})
