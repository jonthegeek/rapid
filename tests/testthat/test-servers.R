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
        variables = server_variables(string_replacements(
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

test_that("as_servers() errors informatively for unnamed or misnamed input", {
  expect_snapshot(
    as_servers(list(letters)),
    error = TRUE
  )
  expect_snapshot(
    as_servers(list(list(a = "https://example.com", b = "A cool server."))),
    error = TRUE
  )
})

test_that("as_servers() errors informatively for bad classes", {
  expect_snapshot(
    as_servers(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_servers(mean),
    error = TRUE
  )
  expect_snapshot(
    as_servers(TRUE),
    error = TRUE
  )
})

test_that("as_servers() returns expected objects", {
  expect_identical(
    as_servers(
      list(
        list(
          url = "https://example.com",
          description = "The only server."
        )
      )
    ),
    servers(
      url = "https://example.com",
      description = "The only server."
    )
  )
  expect_identical(
    as_servers(
      list(
        list(
          url = "https://{username}.gigantic-server.com:{port}/{basePath}",
          description = "The production API server",
          variables = list(
            username = list(
              default = "demo",
              description = "this value is assigned by the service provider"
            ),
            port = list(enum = c("8443", "443"), default = "8443"),
            basePath = list(default = "v2")
          )
        )
      )
    ),
    servers(
      url = "https://{username}.gigantic-server.com:{port}/{basePath}",
      description = "The production API server",
      variables = server_variables(
        string_replacements(
          name = c("username", "port", "basePath"),
          description = c(
            "this value is assigned by the service provider",
            NA, NA
          ),
          default = c("demo", "8443", "v2"),
          enum = list(NULL, c("8443", "443"), NULL)
        )
      )
    )
  )
  expect_identical(
    as_servers(list()),
    servers()
  )
})

test_that("as_servers() works for servers", {
  expect_identical(
    as_servers(servers()),
    servers()
  )
})
