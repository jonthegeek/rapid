test_that("Can create rapid objects", {
  given_info <- list(
    title = "Sample API"
  )
  expect_snapshot(
    {
      test_result <- rapid(info = given_info)
      test_result
    }
  )
  expect_identical(
    unclass(test_result),
    list(info = given_info)
  )

  expect_snapshot(rapid())
})
