test_that("class_license() errors informatively for bad name", {
  expect_snapshot(
    class_license(name = mean),
    error = TRUE
  )
  expect_snapshot(
    class_license(name = c("A", "B")),
    error = TRUE
  )
})

test_that("class_license() errors informatively for bad url", {
  expect_snapshot(
    class_license(name = "A", url = mean),
    error = TRUE
  )
  expect_snapshot(
    class_license(name = "A", url = c("A", "B")),
    error = TRUE
  )
})
test_that("class_license() errors informatively for bad identifier", {
  expect_snapshot(
    class_license(name = "A", identifier = mean),
    error = TRUE
  )
  expect_snapshot(
    class_license(name = "A", identifier = c("A", "B")),
    error = TRUE
  )
})

test_that("class_license() errors when both url and identifier are supplied", {
  expect_snapshot(
    class_license(name = "A", identifier = "A", url = "https://example.com"),
    error = TRUE
  )
})

test_that("class_license() fails when name is missing", {
  expect_snapshot(
    class_license(identifier = "A"),
    error = TRUE
  )
  expect_snapshot(
    class_license(url = "https://example.com"),
    error = TRUE
  )
})

test_that("class_license() doesn't match identifier by position", {
  expect_snapshot(
    class_license(name = "A", "https://example.com"),
    error = TRUE
  )
})

test_that("class_license() returns a license when everything is ok", {
  expect_snapshot({
    test_result <- class_license(
      name = "A",
      url = "https://example.com"
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::license", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "identifier", "url")
  )

  expect_snapshot({
    test_result <- class_license(
      name = "A",
      identifier = "technically these have a fancy required format"
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::license", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "identifier", "url")
  )
})

test_that("length() of a license reports the overall length", {
  expect_equal(length(class_license()), 0)
  expect_equal(length(class_license(name = "A")), 1)
})

test_that("as_license() errors informatively for unnamed input", {
  expect_snapshot(
    as_license(letters),
    error = TRUE
  )
})

test_that("as_license() errors informatively for bad classes", {
  expect_snapshot(
    as_license(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_license(mean),
    error = TRUE
  )
  expect_snapshot(
    as_license(TRUE),
    error = TRUE
  )
})

test_that("as_license() returns expected objects", {
  expect_identical(
    as_license(c(
      name = "Apache 2.0",
      identifier = "Apache-2.0"
    )),
    class_license(
      name = "Apache 2.0",
      identifier = "Apache-2.0"
    )
  )
  expect_warning(
    as_license(c(
      name = "Apache 2.0",
      identifier = "Apache-2.0",
      x = "https://jonthegeek.com"
    )),
    class = "rapid_warning_extra_names"
  )
  expect_identical(
    suppressWarnings(
      as_license(c(
        name = "Apache 2.0",
        identifier = "Apache-2.0",
        x = "https://jonthegeek.com"
      ))
    ),
    class_license(
      name = "Apache 2.0",
      identifier = "Apache-2.0"
    )
  )

  expect_identical(
    as_license(list()),
    class_license()
  )
})

test_that("as_license() works for licenses", {
  expect_identical(
    as_license(class_license()),
    class_license()
  )
})
