test_that("security_schemes() requires name for description", {
  expect_error(
    security_schemes("a", security_scheme = NULL, "description"),
    class = "rlib_error_dots_nonempty"
  )
  expect_snapshot(
    security_schemes("a", security_scheme = NULL, "description"),
    error = TRUE
  )
})

test_that("security_schemes() requires required parameters", {
  expect_snapshot(
    {
      security_schemes("a")
      security_schemes(security_scheme = api_key_security_scheme("parm", "query"))
    },
    error = TRUE
  )
})
