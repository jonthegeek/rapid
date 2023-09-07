# TODO: Implement as_*.

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
      "contact",
      "description",
      "license",
      "summary",
      "terms_of_service",
      "title",
      "version"
    )
  )
})

test_that("length() of an info reports the overall length", {
  expect_equal(length(info()), 0)
  expect_equal(
    length(
      info(
        title = "My Cool API",
        license = license(
          name = "Apache 2.0",
          url = "https://opensource.org/license/apache-2-0/"
        )
      )
    ),
    1
  )
})
