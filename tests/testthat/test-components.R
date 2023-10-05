test_that("component_collection() returns an empty component_collection", {
  expect_snapshot({
    test_result <- component_collection()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::component_collection", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    "security_schemes"
  )
})

test_that("length() of an security_schemes reports the overall length", {
  expect_equal(length(component_collection()), 0)
  expect_equal(
    length(
      component_collection(
        security_schemes = security_scheme_collection(
          name = "a",
          details = security_scheme_details(
            api_key_security_scheme("parm", "query")
          )
        )
      )
    ),
    1
  )
  expect_equal(
    length(
      component_collection(
        security_schemes = security_scheme_collection(
          name = c("a", "b"),
          details = security_scheme_details(
            api_key_security_scheme("parm", "query"),
            api_key_security_scheme("parm", "query")
          )
        )
      )
    ),
    1
  )
})

test_that("as_component_collection() errors for unnamed or misnamed input", {
  expect_snapshot(
    as_component_collection(as.list(letters)),
    error = TRUE
  )
  expect_snapshot(
    as_component_collection(list(a = "My Cool API")),
    error = TRUE
  )
})

test_that("as_component_collection() errors informatively for bad classes", {
  expect_snapshot(
    as_component_collection(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_component_collection(mean),
    error = TRUE
  )
  expect_snapshot(
    as_component_collection(TRUE),
    error = TRUE
  )
})

test_that("as_component_collection() returns expected objects", {
  expect_identical(
    as_component_collection(list(
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
    component_collection(
      security_schemes = security_scheme_collection(
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
  )

  expect_identical(
    as_component_collection(list()),
    component_collection()
  )
})

test_that("as_component_collection() works with camelCase", {
  expect_identical(
    as_component_collection(list(
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
    component_collection(
      security_schemes = security_scheme_collection(
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
  )
})

test_that("as_component_collection() works for component_collections", {
  expect_identical(
    as_component_collection(component_collection()),
    component_collection()
  )
})
