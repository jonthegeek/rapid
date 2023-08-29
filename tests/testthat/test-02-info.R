# It was tempting to try to check requirements in this (and presumably both
# above and below here), but many APIDs fail to properly follow specs. This
# object should allow issues, and then we can check what's missing that should
# be there and report on it, likely via a subclass.

test_that("api_info() requires URLs for TOS", {
  expect_snapshot(
    api_info(terms_of_service = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_info(terms_of_service = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_info(terms_of_service = "not a real url"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_info() returns an empty api_info", {
  expect_snapshot({
    test_result <- api_info()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::api_info", "S7_object"),
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
