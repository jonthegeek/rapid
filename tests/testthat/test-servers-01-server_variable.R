test_that("server_variable() requires names for optional args", {
  expect_snapshot(
    server_variable("a", "b", "c"),
    error = TRUE
  )
})

test_that("server_variable() requires that default matches name", {
  expect_snapshot(
    server_variable("a"),
    error = TRUE
  )
  expect_snapshot(
    server_variable("a", letters),
    error = TRUE
  )
  expect_snapshot(
    server_variable(letters, "a"),
    error = TRUE
  )
  expect_snapshot(
    server_variable(character(), "a"),
    error = TRUE
  )
})

test_that("server_variable() works with equal-length name/default", {
  expect_snapshot({
    test_result <- server_variable("a", "b")
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::server_variable", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "default", "enum", "description")
  )
})

test_that("server_variable() requires that optional args are empty or match", {
  expect_snapshot(
    server_variable("a", "b", enum = list("a", "b")),
    error = TRUE
  )
  expect_snapshot(
    server_variable("a", "b", description = c("a", "b")),
    error = TRUE
  )
})

test_that("server_variable() requires that the default is in enum when given", {
  expect_snapshot(
    server_variable(name = "a", default = "b", enum = "a"),
    error = TRUE
  )
  expect_snapshot(
    server_variable(
      name = c("a", "b"),
      default = c("b", "a"),
      enum = list("a", "a")
    ),
    error = TRUE
  )
})

test_that("server_variable() works for a full object", {
  expect_snapshot({
    test_result <- server_variable(
      name = c("username", "port", "basePath"),
      default = c("demo", "8443", "v2"),
      description = c(
        "The active user's folder.",
        NA, NA
      ),
      enum = list(
        NULL,
        c("8443", "443"),
        NULL
      )
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::server_variable", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "default", "enum", "description")
  )
})

test_that("length() of a server_variable reports the overall length", {
  expect_equal(length(server_variable()), 0)
  expect_equal(length(server_variable(name = "A", default = "A")), 1)
})
