test_that("license() errors informatively for bad name", {
  expect_snapshot(
    license(name = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    license(name = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("license() errors informatively for bad url", {
  expect_snapshot(
    license(name = "A", url = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    license(name = "A", url = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    license(name = "A", url = "not a real url"),
    error = TRUE,
    cnd_class = TRUE
  )
})
test_that("license() errors informatively for bad identifier", {
  expect_snapshot(
    license(name = "A", identifier = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    license(name = "A", identifier = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("license() errors informatively when both url and identifier are supplied", {
  expect_snapshot(
    license(name = "A", identifier = "A", url = "https://example.com"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("license() fails when name is missing", {
  expect_snapshot(
    license(identifier = "A"),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    license(url = "https://example.com"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("license() doesn't match identifier by position", {
  expect_snapshot(
    license(name = "A", "https://example.com"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("license() returns a license when everything is ok", {
  expect_snapshot({
    test_result <- license(
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
    test_result <- license(
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

test_that("length() of an license reports the overall length", {
  expect_equal(length(license()), 0)
  expect_equal(length(license(name = "A")), 1)
})

# TODO: Copy/adapt tests from test-info-01-contact.R for as_license (and
# as_* throughout these).

# TODO: Implement as_*.
#
# TODO: Get rid of apid_list args (and maybe apid_url). Maybe as_* should figure
# out if it's a url?
#
# TODO: Prettier printing.
#
# TODO: After all that, I think I want to implement components$securitySchemas
# (etc) to have enough to hit checkpoint 1 for {beekeeper}.
