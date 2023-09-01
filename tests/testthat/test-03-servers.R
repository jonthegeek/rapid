test_that("servers() requires URLs for urls", {
  expect_snapshot(
    servers(url = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    servers(url = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    servers(url = "not a real url"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("servers() returns an empty server", {
  expect_snapshot({
    test_result <- servers()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::servers", "S7_object"),
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
