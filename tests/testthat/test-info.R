test_that("info() validates property length.", {
  expect_snapshot(
    info(title = "My API"),
    error = TRUE
  )
  expect_snapshot(
    info(version = "My API"),
    error = TRUE
  )
  expect_snapshot(
    info(summary = "My API"),
    error = TRUE
  )
})

test_that("info() returns an empty info", {
  expect_snapshot({
    test_result <- info()
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
      "terms_of_service"
    )
  )
})

test_that("length() of an info reports the overall length", {
  expect_equal(length(info()), 0)
  expect_equal(
    length(
      info(
        title = "My Cool API",
        version = "one",
        license = license(
          name = "Apache 2.0",
          url = "https://opensource.org/license/apache-2-0/"
        )
      )
    ),
    1
  )
})

test_that("as_info() errors informatively for unnamed or misnamed input", {
  expect_snapshot(
    as_info(letters),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_info(list(a = "My Cool API")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_info() errors informatively for bad classes", {
  expect_snapshot(
    as_info(1:2),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_info(mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_info(TRUE),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_info() returns expected objects", {
  expect_identical(
    as_info(c(
      title = "My API",
      version = "1"
    )),
    info(
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
    info(
      title = "My API",
      version = "1",
      contact = contact(
        name = "Jon",
        email = "jonthegeek@gmail.com"
      ),
      license = license(
        name = "Apache 2.0",
        identifier = "Apache-2.0"
      )
    )
  )
  expect_identical(
    as_info(list()),
    info()
  )
})

test_that("as_info() works for infos", {
  expect_identical(
    as_info(info()),
    info()
  )
})
