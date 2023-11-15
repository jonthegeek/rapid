test_that("class_server_variables() errors informatively for bad contents", {
  expect_snapshot(
    class_server_variables(letters),
    error = TRUE
  )
  expect_snapshot(
    class_server_variables(list(letters, letters)),
    error = TRUE
  )
  expect_snapshot(
    class_server_variables(
      class_string_replacements(),
      letters,
      class_string_replacements(),
      letters
    ),
    error = TRUE
  )
})

test_that("class_server_variables() returns an empty server_variables", {
  expect_snapshot(class_server_variables())
})

test_that("class_server_variables() accepts bare string_replacements", {
  expect_snapshot(class_server_variables(class_string_replacements()))
  expect_snapshot(
    class_server_variables(
      class_string_replacements(),
      class_string_replacements()
    )
  )
})

test_that("class_server_variables() accepts lists of string_replacements", {
  expect_snapshot(class_server_variables(list(class_string_replacements())))
  expect_snapshot(
    class_server_variables(
      list(class_string_replacements(), class_string_replacements())
    )
  )
})

test_that("as_server_variables() errors informatively for bad classes", {
  expect_snapshot(
    as_server_variables(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_server_variables(mean),
    error = TRUE
  )
  expect_snapshot(
    as_server_variables(TRUE),
    error = TRUE
  )
})

test_that("as_server_variables() returns expected objects", {
  expect_identical(
    as_server_variables(
      list(
        list(
          username = c(default = "demo", description = "Name of the user.")
        )
      )
    ),
    class_server_variables(
      class_string_replacements(
        name = "username",
        default = "demo",
        description = "Name of the user."
      )
    )
  )
  expect_identical(
    as_server_variables(
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
    class_server_variables(
      class_string_replacements(
        name = "username",
        default = "demo",
        description = "Name of the user."
      ),
      class_string_replacements(
        name = c("username", "port"),
        default = c("demo", 8443),
        description = c("Name of the user.", NA),
        enum = list(NULL, c(8443, 443))
      )
    )
  )
  expect_identical(
    as_server_variables(list()),
    class_server_variables()
  )
})

test_that("as_server_variables() works for server_variables", {
  expect_identical(
    as_server_variables(class_server_variables()),
    class_server_variables()
  )
})
