test_that("oauth2_authorization_code_flow() requires compatible lengths", {
  expect_snapshot(
    oauth2_authorization_code_flow("a"),
    error = TRUE
  )
  expect_snapshot(
    oauth2_authorization_code_flow(token_url = "a"),
    error = TRUE
  )
  expect_snapshot(
    oauth2_authorization_code_flow(refresh_url = "a"),
    error = TRUE
  )
  expect_snapshot(
    oauth2_authorization_code_flow(scopes = c("a" = "a")),
    error = TRUE
  )
})

test_that("oauth2_authorization_code_flow() returns an empty oauth2_authorization_code_flow", {
  expect_snapshot(oauth2_authorization_code_flow())
})

test_that("oauth2_authorization_code_flow() requires names for optionals", {
  expect_snapshot(
    oauth2_authorization_code_flow("a", "b", "c"),
    error = TRUE
  )
  expect_snapshot(
    oauth2_authorization_code_flow("a", "b", refresh_url = "c", c("d" = "d")),
    error = TRUE
  )
})

test_that("oauth2_authorization_code_flow() errors informatively for bad classes", {
  expect_snapshot(
    oauth2_authorization_code_flow(mean, mean),
    error = TRUE
  )
  expect_snapshot(
    oauth2_authorization_code_flow("a", mean),
    error = TRUE
  )
  expect_snapshot(
    oauth2_authorization_code_flow("a", "b", refresh_url = mean),
    error = TRUE
  )
  expect_snapshot(
    oauth2_authorization_code_flow("a", "b", refresh_url = "c", scopes = "d"),
    error = TRUE
  )
})

test_that("oauth2_authorization_code_flow() returns expected objects", {
  expect_snapshot({
    test_result <- oauth2_authorization_code_flow(
      authorization_url = "https://auth.ebay.com/oauth2/authorize",
      token_url = "https://api.ebay.com/identity/v1/oauth2/token",
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
      "rapid::oauth2_authorization_code_flow",
      "rapid::oauth2_flow",
      "S7_object"
    ),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("refresh_url", "scopes", "authorization_url", "token_url")
  )
})
