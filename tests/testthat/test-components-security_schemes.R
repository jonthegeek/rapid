test_that("class_security_schemes() requires name for description", {
  expect_error(
    class_security_schemes("a", details = NULL, "description"),
    class = "rlib_error_dots_nonempty"
  )
  expect_snapshot(
    class_security_schemes("a", details = NULL, "description"),
    error = TRUE
  )
})

test_that("class_security_schemes() requires required parameters", {
  expect_snapshot(
    {
      class_security_schemes("a")
      class_security_schemes(
        details = class_security_scheme_details(
          class_api_key_security_scheme("parm", "query")
        )
      )
    },
    error = TRUE
  )
})

test_that("class_security_schemes() -> empty security_schemes", {
  expect_snapshot({
    test_result <- class_security_schemes()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::security_schemes", "S7_object"),
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

test_that("length() of security_schemes reports the overall length", {
  expect_equal(length(class_security_schemes()), 0)
  expect_equal(
    length(
      class_security_schemes(
        name = "a",
        details = class_security_scheme_details(
          class_api_key_security_scheme("parm", "query")
        )
      )
    ),
    1
  )
  expect_equal(
    length(
      class_security_schemes(
        name = c("a", "b"),
        details = class_security_scheme_details(
          class_api_key_security_scheme("parm", "query"),
          class_api_key_security_scheme("parm", "query")
        )
      )
    ),
    2
  )
})

test_that("as_security_schemes() errors for unnamed input", {
  expect_snapshot(
    as_security_schemes(as.list(letters)),
    error = TRUE
  )
})

test_that("as_security_schemes() errors for bad classes", {
  expect_snapshot(
    as_security_schemes(letters),
    error = TRUE
  )
  expect_snapshot(
    as_security_schemes(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_security_schemes(mean),
    error = TRUE
  )
  expect_snapshot(
    as_security_schemes(TRUE),
    error = TRUE
  )
})

test_that("as_security_schemes() returns expected objects", {
  expect_identical(
    as_security_schemes(
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
    class_security_schemes(
      name = c(
        "accountAuth",
        "profileAuth",
        "resetPasswordAuth",
        "verifyEmailAuth"
      ),
      details = class_security_scheme_details(
        class_oauth2_security_scheme(
          password_flow = class_oauth2_token_flow(
            token_url = "/account/authorization",
            scopes = class_scopes(
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
        class_oauth2_security_scheme(
          password_flow = class_oauth2_token_flow(
            token_url = "/account/profile/authorization",
            scopes = class_scopes(
              name = "Catalog",
              description = "Modify profile preferences and activity"
            )
          )
        ),
        class_api_key_security_scheme(
          parameter_name = "authorization",
          location = "header"
        ),
        class_api_key_security_scheme(
          parameter_name = "authorization",
          location = "header"
        )
      ),
      description = c("Account JWT token", "Profile JWT token", NA, NA)
    )
  )
  expect_identical(
    as_security_schemes(list()),
    class_security_schemes()
  )
})

test_that("as_security_schemes() ok w security_schemes", {
  expect_identical(
    as_security_schemes(class_security_schemes()),
    class_security_schemes()
  )
})
