test_that("class_info() validates property length.", {
  expect_snapshot(
    class_info(title = "My API"),
    error = TRUE
  )
  expect_snapshot(
    class_info(version = "My API"),
    error = TRUE
  )
  expect_snapshot(
    class_info(summary = "My API"),
    error = TRUE
  )
})

test_that("class_info() returns an empty info", {
  expect_snapshot({
    test_result <- class_info()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::info", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c(
      "title",
      "version",
      "contact",
      "description",
      "license",
      "summary",
      "terms_of_service",
      "origin"
    )
  )
})

test_that("length() of an info reports the overall length", {
  expect_equal(length(class_info()), 0)
  expect_equal(
    length(
      class_info(
        title = "My Cool API",
        version = "one",
        license = class_license(
          name = "Apache 2.0",
          url = "https://opensource.org/license/apache-2-0/"
        )
      )
    ),
    1
  )
})

test_that("as_info() errors informatively for unnamed input", {
  expect_snapshot(
    as_info(letters),
    error = TRUE
  )
  expect_snapshot(
    as_info(list("My Cool API")),
    error = TRUE
  )
})

test_that("as_info() errors informatively for bad classes", {
  expect_snapshot(
    as_info(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_info(mean),
    error = TRUE
  )
  expect_snapshot(
    as_info(TRUE),
    error = TRUE
  )
})

test_that("as_info() returns expected objects", {
  expect_identical(
    as_info(c(
      title = "My API",
      version = "1"
    )),
    class_info(
      title = "My API",
      version = "1"
    )
  )
  expect_identical(
    as_info(list(
      title = "My API",
      version = "1",
      contact = c(
        name = "Jon",
        email = "jonthegeek@gmail.com"
      ),
      license = c(
        name = "Apache 2.0",
        identifier = "Apache-2.0"
      )
    )),
    class_info(
      title = "My API",
      version = "1",
      contact = class_contact(
        name = "Jon",
        email = "jonthegeek@gmail.com"
      ),
      license = class_license(
        name = "Apache 2.0",
        identifier = "Apache-2.0"
      )
    )
  )
  expect_identical(
    as_info(list()),
    class_info()
  )
})

test_that("as_info() works for infos", {
  expect_identical(
    as_info(class_info()),
    class_info()
  )
})

test_that("as_info() converts x-origin to origin", {
  expect_identical(
    as_info(list(
      title = "My API",
      version = "1",
      x_origin = "https://root.url"
    )),
    class_info(
      title = "My API",
      version = "1",
      origin = class_origin("https://root.url")
    )
  )
})
