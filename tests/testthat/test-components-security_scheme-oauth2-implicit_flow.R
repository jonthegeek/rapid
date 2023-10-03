test_that("oauth2_implicit_flow() requires compatible lengths", {
  expect_snapshot(
    oauth2_implicit_flow(refresh_url = "a"),
    error = TRUE
  )
  expect_snapshot(
    oauth2_implicit_flow(scopes = c("a" = "a")),
    error = TRUE
  )
})

test_that("oauth2_implicit_flow() returns an empty oauth2_implicit_flow", {
  expect_snapshot(oauth2_implicit_flow())
})

test_that("oauth2_implicit_flow() requires names for optionals", {
  expect_snapshot(
    oauth2_implicit_flow("a", "b", "c"),
    error = TRUE
  )
  expect_snapshot(
    oauth2_implicit_flow("a", refresh_url = "c", c("d" = "d")),
    error = TRUE
  )
})

test_that("oauth2_implicit_flow() errors informatively for bad classes", {
  expect_snapshot(
    oauth2_implicit_flow(mean),
    error = TRUE
  )
  expect_snapshot(
    oauth2_implicit_flow("a", refresh_url = mean),
    error = TRUE
  )
  expect_snapshot(
    oauth2_implicit_flow("a", refresh_url = "c", scopes = "d"),
    error = TRUE
  )
})

test_that("oauth2_implicit_flow() returns expected objects", {
  expect_snapshot({
    test_result <- oauth2_implicit_flow(
      authorization_url = "https://auth.ebay.com/oauth2/authorize",
      scopes = c(
        sell.account = "View and manage your account settings",
        sell.account.readonly = "View your account settings"
      ),
      refresh_url = "https://api.ebay.com/identity/v1/oauth2/refresh"
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c(
      "rapid::oauth2_implicit_flow",
      "rapid::oauth2_flow",
      "S7_object"
    ),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("refresh_url", "scopes", "authorization_url")
  )
})

test_that("length() of an oauth2_implicit_flow reports the overall length", {
  expect_equal(length(oauth2_implicit_flow()), 0)
  expect_equal(length(oauth2_implicit_flow("A")), 1)
  expect_equal(
    length(oauth2_implicit_flow("A", scopes = c("a" = "a", "b" = "b"))),
    1
  )
})

test_that("as_oauth2_implicit_flow() errors informatively for unnamed or misnamed input", {
  expect_error(
    as_oauth2_implicit_flow("a"),
    class = "x"
  )
  expect_snapshot(
    as_oauth2_implicit_flow(list(a = "Jon", b = "jonthegeek@gmail.com")),
    error = TRUE
  )
})
