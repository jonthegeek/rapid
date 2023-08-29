test_that("api_license() errors informatively for bad name", {
  expect_snapshot(
    api_license(name = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_license(name = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_license() errors informatively for bad url", {
  expect_snapshot(
    api_license(name = "A", url = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_license(name = "A", url = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_license(name = "A", url = "not a real url"),
    error = TRUE,
    cnd_class = TRUE
  )
})
test_that("api_license() errors informatively for bad identifier", {
  expect_snapshot(
    api_license(name = "A", identifier = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_license(name = "A", identifier = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_license() errors informatively when both url and identifier are supplied", {
  expect_snapshot(
    api_license(name = "A", identifier = "A", url = "https://example.com"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_license() doesn't match identifier by position", {
  expect_snapshot(
    api_license(name = "A", "https://example.com"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_license() returns a license when everything is ok", {
  expect_snapshot({
    test_result <- api_license(
      name = "A",
      url = "https://example.com"
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::api_license", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "identifier", "url")
  )

  expect_snapshot({
    test_result <- api_license(
      name = "A",
      identifier = "technically these have a fancy required format"
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::api_license", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "identifier", "url")
  )
})
