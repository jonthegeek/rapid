test_that("variables() errors informatively for bad contents", {
  expect_snapshot(
    variables(letters),
    error = TRUE
  )
  expect_snapshot(
    variables(list(letters, letters)),
    error = TRUE
  )
  expect_snapshot(
    variables(
      string_replacements(),
      letters,
      string_replacements(),
      letters
    ),
    error = TRUE
  )
})

test_that("variables() returns an empty variables", {
  expect_snapshot(variables())
})

test_that("variables() accepts bare string_replacements", {
  expect_snapshot(variables(string_replacements()))
  expect_snapshot(variables(string_replacements(), string_replacements()))
})

test_that("variables() accepts lists of string_replacements", {
  expect_snapshot(variables(list(string_replacements())))
  expect_snapshot(
    variables(list(string_replacements(), string_replacements()))
  )
})

test_that("as_variables() errors informatively for bad classes", {
  expect_snapshot(
    as_variables(1:2),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_variables(mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_variables(TRUE),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_variables() returns expected objects", {
  expect_identical(
    as_variables(
      list(
        list(
          username = c(default = "demo", description = "Name of the user.")
        )
      )
    ),
    variables(
      string_replacements(
        name = "username",
        default = "demo",
        description = "Name of the user."
      )
    )
  )
  expect_identical(
    as_variables(
      list(
        list(
          username = c(default = "demo", description = "Name of the user.")
        ),
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
      )
    ),
    variables(
      string_replacements(
        name = "username",
        default = "demo",
        description = "Name of the user."
      ),
      string_replacements(
        name = c("username", "port"),
        default = c("demo", 8443),
        description = c("Name of the user.", NA),
        enum = list(NULL, c(8443, 443))
      )
    )
  )
  expect_identical(
    as_variables(list()),
    variables()
  )
})

test_that("as_variables() works for variables", {
  expect_identical(
    as_variables(variables()),
    variables()
  )
})
