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

test_that("length() of a servers reports the overall length", {
  expect_equal(length(servers()), 0)
  expect_equal(
    length(
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
    ),
    3
  )
  expect_equal(
    length(
      servers(
        url = "https://{username}.gigantic-server.com:{port}/{basePath}",
        description = "The production API server",
        variables = server_variable_list(server_variable(
          name = c("username", "port", "basePath"),
          default = c("demo", "8443", "v2"),
          description = c(
            "The active user's folder.",
            NA, NA
          ),
          enum = list(
            NULL,
            c("8443", "443"),
            NULL
          )
        ))
      )
    ),
    1
  )
})
