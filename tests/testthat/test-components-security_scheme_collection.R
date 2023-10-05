test_that("security_scheme_collection() requires name for description", {
  expect_error(
    security_scheme_collection("a", details = NULL, "description"),
    class = "rlib_error_dots_nonempty"
  )
  expect_snapshot(
    security_scheme_collection("a", details = NULL, "description"),
    error = TRUE
  )
})

test_that("security_scheme_collection() requires required parameters", {
  expect_snapshot(
    {
      security_scheme_collection("a")
      security_scheme_collection(
        details = security_scheme_details(
          api_key_security_scheme("parm", "query")
        )
      )
    },
    error = TRUE
  )
})

test_that("security_scheme_collection() -> empty security_scheme_collection", {
  expect_snapshot({
    test_result <- security_scheme_collection()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::security_scheme_collection", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c(
      "name",
      "details",
      "description"
    )
  )
})

test_that("length() of security_scheme_collection reports the overall length", {
  expect_equal(length(security_scheme_collection()), 0)
  expect_equal(
    length(
      security_scheme_collection(
        name = "a",
        details = security_scheme_details(
          api_key_security_scheme("parm", "query")
        )
      )
    ),
    1
  )
  expect_equal(
    length(
      security_scheme_collection(
        name = c("a", "b"),
        details = security_scheme_details(
          api_key_security_scheme("parm", "query"),
          api_key_security_scheme("parm", "query")
        )
      )
    ),
    2
  )
})

test_that("as_security_scheme_collection() errors for unnamed input", {
  expect_snapshot(
    as_security_scheme_collection(as.list(letters)),
    error = TRUE
  )
})

test_that("as_security_scheme_collection() errors for bad classes", {
  expect_snapshot(
    as_security_scheme_collection(letters),
    error = TRUE
  )
  expect_snapshot(
    as_security_scheme_collection(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_security_scheme_collection(mean),
    error = TRUE
  )
  expect_snapshot(
    as_security_scheme_collection(TRUE),
    error = TRUE
  )
})

test_that("as_security_scheme_collection() returns expected objects", {
  expect_identical(
    as_security_scheme_collection(
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
                Catalog = "Modify profile preferences and activity"
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
    security_scheme_collection(
      name = c(
        "accountAuth",
        "profileAuth",
        "resetPasswordAuth",
        "verifyEmailAuth"
      ),
      details = security_scheme_details(
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
              description = "Modify profile preferences and activity"
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
      ),
      description = c("Account JWT token", "Profile JWT token", NA, NA)
    )
  )
  expect_identical(
    as_security_scheme_collection(list()),
    security_scheme_collection()
  )
})

test_that("as_security_scheme_collection() ok w security_scheme_collections", {
  expect_identical(
    as_security_scheme_collection(security_scheme_collection()),
    security_scheme_collection()
  )
})
