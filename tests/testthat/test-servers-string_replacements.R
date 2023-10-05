test_that("string_replacements() requires names for optional args", {
  expect_snapshot(
    string_replacements("a", "b", "c"),
    error = TRUE
  )
})

test_that("string_replacements() requires that default matches name", {
  expect_snapshot(
    string_replacements("a"),
    error = TRUE
  )
  expect_snapshot(
    string_replacements("a", letters),
    error = TRUE
  )
  expect_snapshot(
    string_replacements(letters, "a"),
    error = TRUE
  )
  expect_snapshot(
    string_replacements(character(), "a"),
    error = TRUE
  )
})

test_that("string_replacements() works with equal-length name/default", {
  expect_snapshot({
    test_result <- string_replacements("a", "b")
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::string_replacements", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "default", "enum", "description")
  )
})

test_that("string_replacements() requires optional args are empty or match", {
  expect_snapshot(
    string_replacements("a", "b", enum = list("a", "b")),
    error = TRUE
  )
  expect_snapshot(
    string_replacements("a", "b", description = c("a", "b")),
    error = TRUE
  )
})

test_that("string_replacements() requires default is in enum when given", {
  expect_snapshot(
    string_replacements(name = "a", default = "b", enum = "a"),
    error = TRUE
  )
  expect_snapshot(
    string_replacements(
      name = c("a", "b"),
      default = c("b", "a"),
      enum = list("a", "a")
    ),
    error = TRUE
  )
})

test_that("string_replacements() works for a full object", {
  expect_snapshot({
    test_result <- string_replacements(
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
    class = c("rapid::string_replacements", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "default", "enum", "description")
  )
})

test_that("length() of a string_replacements reports the overall length", {
  expect_equal(length(string_replacements()), 0)
  expect_equal(length(string_replacements(name = "A", default = "A")), 1)
})

test_that("as_string_replacements() errors for un/misnamed input", {
  expect_snapshot(
    as_string_replacements(letters),
    error = TRUE
  )
  expect_snapshot(
    as_string_replacements(list(a = "Jon", b = "jonthegeek@gmail.com")),
    error = TRUE
  )
  expect_snapshot(
    as_string_replacements(c(a = "Jon", b = "jonthegeek@gmail.com")),
    error = TRUE
  )
})

test_that("as_string_replacements() errors informatively for bad classes", {
  expect_snapshot(
    as_string_replacements(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_string_replacements(mean),
    error = TRUE
  )
  expect_snapshot(
    as_string_replacements(TRUE),
    error = TRUE
  )
})

test_that("as_string_replacements() returns expected objects", {
  expect_identical(
    as_string_replacements(
      list(
        username = c(
          default = "demo",
          description = "Name of the user."
        )
      )
    ),
    string_replacements(
      name = "username",
      default = "demo",
      description = "Name of the user."
    )
  )
  expect_identical(
    as_string_replacements(
      list(
        username = c(
          default = "demo",
          description = "Name of the user.",
          x = "https://jonthegeek.com"
        )
      )
    ),
    string_replacements(
      name = "username",
      default = "demo",
      description = "Name of the user."
    )
  )
  expect_identical(
    as_string_replacements(
      list(
        username = c(
          default = "demo",
          description = "Name of the user.",
          x = "https://jonthegeek.com"
        ),
        port = list(
          default = "8443",
          enum = c("8443", "443")
        )
      )
    ),
    string_replacements(
      name = c("username", "port"),
      default = c("demo", 8443),
      enum = list(NULL, c(8443, 443)),
      description = c("Name of the user.", NA)
    )
  )

  expect_identical(
    as_string_replacements(list()),
    string_replacements()
  )
})

test_that("as_string_replacements() works for string_replacements", {
  expect_identical(
    as_string_replacements(string_replacements()),
    string_replacements()
  )
})
