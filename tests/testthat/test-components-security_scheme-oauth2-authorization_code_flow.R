test_that("oauth2_authorization_code_flow() requires names for optional params", {
  expect_snapshot(
    api_key_security_scheme(
      location = "invalid place",
      parameter_name = "parm1"
    ),
    error = TRUE
  )
})
