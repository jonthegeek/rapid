test_that("oauth2_token_flow() requires compatible lengths", {
  expect_snapshot(
    oauth2_token_flow(refresh_url = "a"),
    error = TRUE
  )
  expect_snapshot(
    oauth2_token_flow(scopes = c("a" = "a")),
    error = TRUE
  )
})

test_that("oauth2_token_flow() returns an empty oauth2_token_flow", {
  expect_snapshot(oauth2_token_flow())
})

test_that("oauth2_token_flow() requires names for optionals", {
  expect_snapshot(
    oauth2_token_flow("a", "b", "c"),
    error = TRUE
  )
  expect_snapshot(
    oauth2_token_flow("a", refresh_url = "c", c("d" = "d")),
    error = TRUE
  )
})

test_that("oauth2_token_flow() errors informatively for bad classes", {
  expect_snapshot(
    oauth2_token_flow(mean),
    error = TRUE
  )
  expect_snapshot(
    oauth2_token_flow("a", refresh_url = mean),
    error = TRUE
  )
  expect_snapshot(
    oauth2_token_flow("a", refresh_url = "c", scopes = "d"),
    error = TRUE
  )
})

test_that("oauth2_token_flow() returns expected objects", {
  expect_snapshot({
    test_result <- oauth2_token_flow(
      token_url = "https://auth.ebay.com/oauth2/token",
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
      "rapid::oauth2_token_flow",
      "rapid::oauth2_flow",
      "S7_object"
    ),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("refresh_url", "scopes", "token_url")
  )
})

test_that("length() of an oauth2_token_flow reports the overall length", {
  expect_equal(length(oauth2_token_flow()), 0)
  expect_equal(length(oauth2_token_flow("A")), 1)
  expect_equal(
    length(oauth2_token_flow("A", scopes = c("a" = "a", "b" = "b"))),
    1
  )
})

test_that("as_oauth2_token_flow() errors for unnamed input", {
  expect_snapshot(
    as_oauth2_token_flow(list("Jon", "jonthegeek@gmail.com")),
    error = TRUE
  )
})

test_that("as_oauth2_token_flow() errors informatively for bad classes", {
  expect_snapshot(
    as_oauth2_token_flow(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_oauth2_token_flow(mean),
    error = TRUE
  )
  expect_snapshot(
    as_oauth2_token_flow(TRUE),
    error = TRUE
  )
})

test_that("as_oauth2_token_flow() returns expected objects", {
  expect_identical(
    as_oauth2_token_flow(
      list(
        token_url = "https://auth.ebay.com/oauth2/token",
        scopes = list(
          sell.account = "View and manage your account settings",
          sell.account.readonly = "View your account settings"
        ),
        refresh_url = "https://api.ebay.com/identity/v1/oauth2/refresh"
      )
    ),
    oauth2_token_flow(
      token_url = "https://auth.ebay.com/oauth2/token",
      scopes = c(
        sell.account = "View and manage your account settings",
        sell.account.readonly = "View your account settings"
      ),
      refresh_url = "https://api.ebay.com/identity/v1/oauth2/refresh"
    )
  )

  expect_identical(
    as_oauth2_token_flow(list()),
    oauth2_token_flow()
  )

  expect_identical(
    as_oauth2_token_flow(character()),
    oauth2_token_flow()
  )
})

test_that("as_oauth2_token_flow() works for alternate names", {
  expect_identical(
    as_oauth2_token_flow(
      list(
        tokenUrl = "https://auth.ebay.com/oauth2/token",
        scopes = list(
          sell.account = "View and manage your account settings",
          sell.account.readonly = "View your account settings"
        ),
        refreshUrl = "https://api.ebay.com/identity/v1/oauth2/refresh"
      )
    ),
    oauth2_token_flow(
      token_url = "https://auth.ebay.com/oauth2/token",
      scopes = c(
        sell.account = "View and manage your account settings",
        sell.account.readonly = "View your account settings"
      ),
      refresh_url = "https://api.ebay.com/identity/v1/oauth2/refresh"
    )
  )
})

test_that("as_oauth2_token_flow() works for oauth2_token_flow", {
  expect_identical(
    as_oauth2_token_flow(oauth2_token_flow()),
    oauth2_token_flow()
  )
})
