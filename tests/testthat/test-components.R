test_that("class_components() returns an empty components", {
  expect_snapshot({
    test_result <- class_components()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::components", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    "security_schemes"
  )
})

test_that("length() of an security_schemes reports the overall length", {
  expect_equal(length(class_components()), 0)
  expect_equal(
    length(
      class_components(
        security_schemes = class_security_schemes(
          name = "a",
          details = class_security_scheme_details(
            class_api_key_security_scheme("parm", "query")
          )
        )
      )
    ),
    1
  )
  expect_equal(
    length(
      class_components(
        security_schemes = class_security_schemes(
          name = c("a", "b"),
          details = class_security_scheme_details(
            class_api_key_security_scheme("parm", "query"),
            class_api_key_security_scheme("parm", "query")
          )
        )
      )
    ),
    1
  )
})

test_that("as_components() errors for unnamed input", {
  expect_snapshot(
    as_components(as.list(letters)),
    error = TRUE
  )
  expect_snapshot(
    as_components(list("My Cool API")),
    error = TRUE
  )
})

test_that("as_components() errors informatively for bad classes", {
  expect_snapshot(
    as_components(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_components(mean),
    error = TRUE
  )
  expect_snapshot(
    as_components(TRUE),
    error = TRUE
  )
})

test_that("as_components() returns expected objects", {
  expect_identical(
    as_components(list(
      security_schemes = list(
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
    )),
    class_components(
      security_schemes = class_security_schemes(
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
  )

  expect_identical(
    as_components(list()),
    class_components()
  )
})

test_that("as_components() works with camelCase", {
  expect_identical(
    as_components(list(
      securitySchemes = list(
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
    )),
    class_components(
      security_schemes = class_security_schemes(
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
  )
})

test_that("as_components() works for components", {
  expect_identical(
    as_components(class_components()),
    class_components()
  )
})
