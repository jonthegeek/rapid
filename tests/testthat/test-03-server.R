test_that("server() requires URLs for url", {
  expect_snapshot(
    server(url = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    server(url = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    server(url = "not a real url"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("server() returns an empty server", {
  expect_snapshot({
    test_result <- server()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::server", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c(
      "url",
      "description",
      "variables"
    )
  )
})
