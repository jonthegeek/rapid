test_that("rapid_spec_version() builds empty spec versions", {
  expect_null(rapid_spec_version())
})

test_that("rapid_spec_version() builds openapi spec versions", {
  expect_snapshot(rapid_spec_version("openapi", 3))
  expect_snapshot(rapid_spec_version("openapi", 3.1))
  expect_snapshot(rapid_spec_version("openapi", "3.0.3"))
})
test_that("rapid_spec_version() errors for bad openapi spec versions", {
  expect_snapshot(rapid_spec_version("openapi", "a"), error = TRUE)
  expect_snapshot(rapid_spec_version("openapi", 1:3), error = TRUE)
})

test_that("rapid_spec_version() builds swagger spec versions", {
  expect_snapshot(rapid_spec_version("swagger", 2))
  expect_snapshot(rapid_spec_version("openapi", "2.0"))
})
test_that("rapid_spec_version() errors for bad swagger spec versions", {
  expect_snapshot(rapid_spec_version("swagger", 1), error = TRUE)
  expect_snapshot(rapid_spec_version("swagger", 2.1), error = TRUE)
  expect_snapshot(rapid_spec_version("swagger", "a"), error = TRUE)
  expect_snapshot(rapid_spec_version("swagger", 1:3), error = TRUE)
})

test_that("rapid_spec_version() builds new spec versions", {
  expect_snapshot(rapid_spec_version("new", 2))
  expect_snapshot(rapid_spec_version("new", "a"))
  expect_snapshot(rapid_spec_version("new", 2, new_type = TRUE))
  expect_snapshot(rapid_spec_version("new", "a", new_type = TRUE))
})
test_that("rapid_spec_version() errors for bad new spec versions", {
  expect_snapshot(rapid_spec_version("new", 1:3), error = TRUE)
})
