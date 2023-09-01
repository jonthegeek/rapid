# I'm building this as I have pieces ready, so the tests will change as I add
# more sub-objects.

test_that("rapid() requires api_info objects for info", {
  expect_snapshot(
    rapid(info = mean),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("rapid() requires info when anything is defined", {
  expect_snapshot(
    rapid(
      servers = servers(
        url = c(
          "https://development.gigantic-server.com/v1",
          "https://staging.gigantic-server.com/v1",
          "https://api.gigantic-server.com/v1"
        ),
        description = c(
          "Development server",
          "Staging server",
          "Production server"
        )
      )
    ),
    error = TRUE
  )
})

test_that("rapid() returns an empty rapid", {
  expect_snapshot({
    test_result <- rapid()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::rapid", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c(
      "info",
      "servers"
    )
  )
})

test_that("length() of a rapid reports the overall length", {
  expect_equal(length(rapid()), 0)
  expect_equal(
    length(
      rapid(
        info = api_info(title = "A", version = "1"),
        servers(
          url = "https://development.gigantic-server.com/v1"
        )
      )
    ),
    1
  )
  expect_equal(
    length(
      rapid(
        info = api_info(title = "A", version = "1"),
        servers(
          url = c(
            "https://development.gigantic-server.com/v1",
            "https://staging.gigantic-server.com/v1",
            "https://api.gigantic-server.com/v1"
          ),
          description = c(
            "Development server",
            "Staging server",
            "Production server"
          )
        )
      )
    ),
    1
  )
})
