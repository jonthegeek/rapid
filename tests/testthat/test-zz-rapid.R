# I'm building this as I have pieces ready, so the tests will change as I add
# more sub-objects.

test_that("rapid() requires info objects for info", {
  expect_snapshot(
    rapid(info = mean),
    error = TRUE
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
    c("info", "servers", "components")
  )
})

test_that("length() of a rapid reports the overall length", {
  expect_equal(length(rapid()), 0)
  expect_equal(
    length(
      rapid(
        info = info(title = "A", version = "1"),
        servers = servers(
          url = "https://development.gigantic-server.com/v1"
        )
      )
    ),
    1
  )
  expect_equal(
    length(
      rapid(
        info = info(title = "A", version = "1"),
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
      )
    ),
    1
  )
})

test_that("as_rapid() works for rapid, missing, and empty", {
  expect_identical(
    as_rapid(rapid()),
    rapid()
  )
  expect_identical(
    as_rapid(),
    rapid()
  )
  expect_identical(
    as_rapid(NULL),
    rapid()
  )
})

test_that("as_rapid() errors informatively for bad classes", {
  expect_snapshot(
    as_rapid(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_rapid(mean),
    error = TRUE
  )
  expect_snapshot(
    as_rapid(TRUE),
    error = TRUE
  )
})

test_that("as_rapid() errors informatively for unnamed or misnamed input", {
  expect_snapshot(
    as_rapid(list(letters)),
    error = TRUE
  )
  expect_snapshot(
    as_rapid(list(list(a = "https://example.com", b = "A cool server."))),
    error = TRUE
  )
})

test_that("as_rapid() works for lists", {
  expect_identical(
    as_rapid(
      list(
        info = list(
          title = "Sample Pet Store App",
          summary = "A pet store manager.",
          description = "This is a sample server for a pet store.",
          termsOfService = "https://example.com/terms/",
          contact = list(
            name = "API Support",
            url = "https://www.example.com/support",
            email = "support@example.com"
          ),
          license = list(
            name = "Apache 2.0",
            url = "https://www.apache.org/licenses/LICENSE-2.0.html"
          ),
          version = "1.0.1"
        ),
        servers = list(
          list(
            url = "https://development.gigantic-server.com/v1",
            description = "Development server"
          ),
          list(
            url = "https://staging.gigantic-server.com/v1",
            description = "Staging server"
          ),
          list(
            url = "https://api.gigantic-server.com/v1",
            description = "Production server"
          )
        )
      )
    ),
    rapid(
      info = info(
        title = "Sample Pet Store App",
        summary = "A pet store manager.",
        description = "This is a sample server for a pet store.",
        terms_of_service = "https://example.com/terms/",
        contact = contact(
          name = "API Support",
          url = "https://www.example.com/support",
          email = "support@example.com"
        ),
        license = license(
          name = "Apache 2.0",
          url = "https://www.apache.org/licenses/LICENSE-2.0.html"
        ),
        version = "1.0.1"
      ),
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
    )
  )
  expect_identical(
    as_rapid(list()),
    rapid()
  )
})

test_that("as_rapid() fails gracefully for unsupported urls", {
  skip_if_not(Sys.getenv("RAPID_TEST_DL") == "true")
  expect_error(
    as_rapid(url("https://api.apis.guru/v2/openapi.yaml")),
    class = "rapid_missing_names"
  )
  expect_snapshot(
    as_rapid(url("https://api.apis.guru/v2/openapi.yaml")),
    error = TRUE
  )
})

test_that("as_rapid() works for urls", {
  skip_if_not(Sys.getenv("RAPID_TEST_DL") == "true")
  expect_snapshot(
    as_rapid(
      url(
        "https://api.apis.guru/v2/specs/amazonaws.com/AWSMigrationHub/2017-05-31/openapi.yaml"
      )
    )
  )
})
