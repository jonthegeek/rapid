test_that("class_security() requires parallel parameters", {
  expect_error(
    class_security(required_scopes = "a"),
    "must be empty"
  )
  expect_snapshot(
    class_security(required_scopes = "a"),
    error = TRUE
  )
})

test_that("class_security() rapid_class_requirement field is fixed", {
  expect_snapshot({
    test_result <- class_security()
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

test_that("class_security have expected lengths", {
  expect_equal(length(class_security()), 0)
  expect_equal(length(class_security(letters)), 26)
  expect_equal(
    length(class_security("a", required_scopes = list(letters))),
    1
  )
})

test_that("as_security() fails for bad classes", {
  x <- 1:2
  expect_error(
    as_security(x),
    class = "rapid_error_unknown_coercion"
  )
  expect_snapshot(
    as_security(x),
    error = TRUE
  )
  x <- mean
  expect_error(
    as_security(x),
    class = "rapid_error_unknown_coercion"
  )
  expect_snapshot(
    as_security(x),
    error = TRUE
  )
  x <- TRUE
  expect_error(
    as_security(x),
    class = "rapid_error_unknown_coercion"
  )
  expect_snapshot(
    as_security(x),
    error = TRUE
  )
})

test_that("as_security() works for security", {
  expect_identical(
    as_security(class_security()),
    class_security()
  )
})

test_that("as_security() works for empties", {
  expect_identical(
    as_security(NULL),
    class_security()
  )
  expect_identical(
    as_security(),
    class_security()
  )
})

test_that("as_security() works for the simplest case", {
  x <- list(list(schemeName = list()))
  expect_identical(
    as_security(x),
    class_security("schemeName")
  )
})

test_that("as_security() works for complex cases", {
  x <- list(
    list(
      oauth2 = c("user", "user:email", "user:follow")
    ),
    list(internalApiKey = list())
  )
  expect_identical(
    as_security(x),
    class_security(
      name = c("oauth2", "internalApiKey"),
      required_scopes = list(
        c("user", "user:email", "user:follow"),
        character()
      )
    )
  )
})
