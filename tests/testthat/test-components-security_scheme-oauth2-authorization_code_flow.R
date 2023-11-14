test_that("class_oauth2_authorization_code_flow() requires compatible lengths", {
  expect_snapshot(
    class_oauth2_authorization_code_flow("a"),
    error = TRUE
  )
  expect_snapshot(
    class_oauth2_authorization_code_flow(token_url = "a"),
    error = TRUE
  )
  expect_snapshot(
    class_oauth2_authorization_code_flow(refresh_url = "a"),
    error = TRUE
  )
  expect_snapshot(
    class_oauth2_authorization_code_flow(scopes = c("a" = "a")),
    error = TRUE
  )
})

test_that("class_oauth2_authorization_code_flow() returns empty", {
  expect_snapshot(class_oauth2_authorization_code_flow())
})

test_that("class_oauth2_authorization_code_flow() requires names for optionals", {
  expect_snapshot(
    class_oauth2_authorization_code_flow("a", "b", "c"),
    error = TRUE
  )
  expect_snapshot(
    class_oauth2_authorization_code_flow("a", "b", refresh_url = "c", c("d" = "d")),
    error = TRUE
  )
})

test_that("class_oauth2_authorization_code_flow() errors for bad classes", {
  expect_snapshot(
    class_oauth2_authorization_code_flow(mean, mean),
    error = TRUE
  )
  expect_snapshot(
    class_oauth2_authorization_code_flow("a", mean),
    error = TRUE
  )
  expect_snapshot(
    class_oauth2_authorization_code_flow("a", "b", refresh_url = mean),
    error = TRUE
  )
  expect_snapshot(
    class_oauth2_authorization_code_flow("a", "b", refresh_url = "c", scopes = "d"),
    error = TRUE
  )
})

test_that("class_oauth2_authorization_code_flow() returns expected objects", {
  expect_snapshot({
    test_result <- class_oauth2_authorization_code_flow(
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

test_that("length() of oauth2_authorization_code_flow reports overall length", {
  expect_equal(length(class_oauth2_authorization_code_flow()), 0)
  expect_equal(length(class_oauth2_authorization_code_flow("A", "B")), 1)
  expect_equal(
    length(
      class_oauth2_authorization_code_flow("A", "B", scopes = c("a" = "a", "b" = "b"))
    ),
    1
  )
})

test_that("as_oauth2_authorization_code_flow() errors for unnamed input", {
  expect_snapshot(
    as_oauth2_authorization_code_flow("a"),
    error = TRUE
  )
})

test_that("as_oauth2_authorization_code_flow() errors for bad classes", {
  expect_snapshot(
    as_oauth2_authorization_code_flow(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_oauth2_authorization_code_flow(mean),
    error = TRUE
  )
  expect_snapshot(
    as_oauth2_authorization_code_flow(TRUE),
    error = TRUE
  )
})

test_that("as_oauth2_authorization_code_flow() returns expected objects", {
  expect_identical(
    as_oauth2_authorization_code_flow(
      list(
        authorization_url = "https://auth.ebay.com/oauth2/authorize",
        scopes = list(
          sell.account = "View and manage your account settings",
          sell.account.readonly = "View your account settings"
        ),
        token_url = "https://api.ebay.com/identity/v1/oauth2/token"
      )
    ),
    class_oauth2_authorization_code_flow(
      authorization_url = "https://auth.ebay.com/oauth2/authorize",
      scopes = c(
        sell.account = "View and manage your account settings",
        sell.account.readonly = "View your account settings"
      ),
      token_url = "https://api.ebay.com/identity/v1/oauth2/token"
    )
  )

  expect_identical(
    as_oauth2_authorization_code_flow(list()),
    class_oauth2_authorization_code_flow()
  )

  expect_identical(
    as_oauth2_authorization_code_flow(character()),
    class_oauth2_authorization_code_flow()
  )
})

test_that("as_oauth2_authorization_code_flow() works for alternate names", {
  expect_identical(
    as_oauth2_authorization_code_flow(
      list(
        authorizationUrl = "https://auth.ebay.com/oauth2/authorize",
        scopes = list(
          sell.account = "View and manage your account settings",
          sell.account.readonly = "View your account settings"
        ),
        tokenUrl = "https://api.ebay.com/identity/v1/oauth2/token"
      )
    ),
    class_oauth2_authorization_code_flow(
      authorization_url = "https://auth.ebay.com/oauth2/authorize",
      scopes = c(
        sell.account = "View and manage your account settings",
        sell.account.readonly = "View your account settings"
      ),
      token_url = "https://api.ebay.com/identity/v1/oauth2/token"
    )
  )
})

test_that("as_oauth2_authorization_code_flow() works w/ itself", {
  expect_identical(
    as_oauth2_authorization_code_flow(class_oauth2_authorization_code_flow()),
    class_oauth2_authorization_code_flow()
  )
})
