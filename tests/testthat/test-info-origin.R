test_that("class_origin can clean up its input", {
  test_url <- "https://root.url"
  test_result <- class_origin(list(url = test_url))
  expect_identical(
    test_result@url,
    test_url
  )
  expect_identical(
    test_result@format,
    character()
  )
  expect_identical(
    test_result@version,
    character()
  )
})
