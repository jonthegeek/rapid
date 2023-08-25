test_that("api_contact() errors informatively for bad name", {
  expect_snapshot(
    api_contact(name = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(name = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_contact() errors informatively for bad url", {
  expect_snapshot(
    api_contact(name = "A", url = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(name = "A", url = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(name = "A", url = "not a real url"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_contact() errors informatively for bad email", {
  expect_snapshot(
    api_contact(name = "A", url = "https://example.com", email = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(name = "A", url = "https://example.com", email = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(
      name = "A",
      url = "https://example.com",
      email = "not a real email"
    ),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_contact() returns a rapid_contact when everything is ok", {
  expect_snapshot({
    test_result <- api_contact(
      name = "A",
      url = "https://example.com",
      email = "real.email@address.place"
    )
  })
  expect_s3_class(test_result, class = c("rapid_contact", "list"), exact = TRUE)
})

test_that("api_contact() without args returns an empty rapid_contact.", {
  expect_snapshot({
    test_result <- api_contact()
    test_result
  })
  expect_s3_class(test_result, class = c("rapid_contact", "list"), exact = TRUE)
})
