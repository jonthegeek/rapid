test_that("security_requirements() requires parallel parameters", {
  expect_error(
    security_requirements(required_scopes = "a"),
    "must be empty"
  )
  expect_snapshot(
    security_requirements(required_scopes = "a"),
    error = TRUE
  )
})

test_that("security_requirements() rapid_class_requirement field is fixed", {
  expect_snapshot({
    test_result <- security_requirements()
    test_result
  })
  expect_error(
    test_result@rapid_class_requirement <- "a",
    "Can't set read-only property"
  )
  expect_identical(
    test_result@rapid_class_requirement,
    "security_scheme"
  )
})

test_that("security_requirements have expected lengths", {
  expect_equal(length(security_requirements()), 0)
  expect_equal(length(security_requirements(letters)), 26)
  expect_equal(
    length(security_requirements("a", required_scopes = list(letters))),
    1
  )
})

test_that("as_security_requirements() fails for bad classes", {
  x <- 1:2
  expect_error(
    as_security_requirements(x),
    class = "rapid_error_unknown_coercion"
  )
  expect_snapshot(
    as_security_requirements(x),
    error = TRUE
  )
  x <- mean
  expect_error(
    as_security_requirements(x),
    class = "rapid_error_unknown_coercion"
  )
  expect_snapshot(
    as_security_requirements(x),
    error = TRUE
  )
  x <- TRUE
  expect_error(
    as_security_requirements(x),
    class = "rapid_error_unknown_coercion"
  )
  expect_snapshot(
    as_security_requirements(x),
    error = TRUE
  )
})

test_that("as_security_requirements() works for security_requirements", {
  expect_identical(
    as_security_requirements(security_requirements()),
    security_requirements()
  )
})

test_that("as_security_requirements() works for empties", {
  expect_identical(
    as_security_requirements(NULL),
    security_requirements()
  )
  expect_identical(
    as_security_requirements(),
    security_requirements()
  )
})

test_that("as_security_requirements() works for the simplest case", {
  x <- list(list(schemeName = list()))
  expect_identical(
    as_security_requirements(x),
    security_requirements("schemeName")
  )
})

test_that("as_security_requirements() works for complex cases", {
  x <- list(
    list(
      oauth2 = c("user", "user:email", "user:follow")
    ),
    list(internalApiKey = list())
  )
  expect_identical(
    as_security_requirements(x),
    security_requirements(
      name = c("oauth2", "internalApiKey"),
      required_scopes = list(
        c("user", "user:email", "user:follow"),
        character()
      )
    )
  )
})
