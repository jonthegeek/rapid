test_that("security_scheme_collection() requires name for description", {
  expect_error(
    security_scheme_collection("a", security_scheme = NULL, "description"),
    class = "rlib_error_dots_nonempty"
  )
  expect_snapshot(
    security_scheme_collection("a", security_scheme = NULL, "description"),
    error = TRUE
  )
})

test_that("security_scheme_collection() requires required parameters", {
  expect_snapshot(
    {
      security_scheme_collection("a")
      security_scheme_collection(
        security_scheme = api_key_security_scheme("parm", "query")
      )
    },
    error = TRUE
  )
})
