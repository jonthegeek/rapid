test_that("security_scheme_details() errors informatively for bad contents", {
  expect_snapshot(
    security_scheme_details(letters),
    error = TRUE
  )
  expect_snapshot(
    security_scheme_details(list(letters, letters)),
    error = TRUE
  )
  expect_snapshot(
    security_scheme_details(
      api_key_security_scheme(),
      letters,
      oauth2_security_scheme(),
      letters
    ),
    error = TRUE
  )
})

test_that("security_scheme_details() returns an empty security_scheme_details", {
  expect_snapshot(security_scheme_details())
})

test_that("security_scheme_details() accepts bare security_schemes", {
  expect_snapshot(security_scheme_details(api_key_security_scheme()))
  expect_snapshot(
    security_scheme_details(api_key_security_scheme(), oauth2_security_scheme())
  )
})

test_that("security_scheme_details() accepts lists of security_schemes", {
  expect_snapshot(security_scheme_details(list(api_key_security_scheme())))
  expect_snapshot(
    security_scheme_details(list(
      api_key_security_scheme(), oauth2_security_scheme()
    ))
  )
})

test_that("as_security_scheme_details() errors informatively for bad classes", {
  expect_snapshot(
    as_security_scheme_details(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_security_scheme_details(mean),
    error = TRUE
  )
  expect_snapshot(
    as_security_scheme_details(TRUE),
    error = TRUE
  )
})

test_that("as_security_scheme_details() works for security_scheme_details", {
  expect_identical(
    as_security_scheme_details(security_scheme_details()),
    security_scheme_details()
  )
})

test_that("as_security_scheme_details() returns expected objects", {
  expect_identical(
    as_security_scheme_details(
      list(
        accountAuth = list(
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
        ),
        profileAuth = list(
          description = "Profile JWT token",
          flows = list(
            password = list(
              scopes = list(
                Catalog = "Modify profile preferences and activity (bookmarks, watch list)"
              ),
              tokenUrl = "/account/profile/authorization"
            )
          ),
          type = "oauth2"
        ),
        resetPasswordAuth = list(
          `in` = "header",
          name = "authorization",
          type = "apiKey"
        ),
        verifyEmailAuth = list(
          `in` = "header",
          name = "authorization",
          type = "apiKey"
        )
      )
    ),
    security_scheme_details(
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
      ),
      oauth2_security_scheme(
        password_flow = oauth2_token_flow(
          token_url = "/account/profile/authorization",
          scopes = scopes(
            name = "Catalog",
            description = "Modify profile preferences and activity (bookmarks, watch list)"
          )
        )
      ),
      api_key_security_scheme(
        parameter_name = "authorization",
        location = "header"
      ),
      api_key_security_scheme(
        parameter_name = "authorization",
        location = "header"
      )
    )
  )
  expect_identical(
    as_security_scheme_details(list()),
    security_scheme_details()
  )
})
