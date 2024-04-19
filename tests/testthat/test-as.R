test_that("as_api_object() checks argument `x` ", {
  expect_error(as_api_object())
  expect_error(as_api_object(NULL))
  expect_error(as_api_object(list()))

  L <- list(a = "one") # named list
  M <- c(a = "one") # named character vector
  expect_error(as_api_object(L))
  expect_error(as_api_object(M))
})
