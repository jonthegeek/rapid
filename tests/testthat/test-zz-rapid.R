# I'm building this as I have pieces ready, so the tests will change as I add
# more sub-objects.

test_that("class_rapid() requires info objects for info", {
  expect_snapshot(
    class_rapid(info = mean),
    error = TRUE
  )
})

test_that("class_rapid() requires info when anything is defined", {
  expect_snapshot(
    class_rapid(
      servers = class_servers(
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

test_that("security must reference components@security_schemes", {
  expect_snapshot(
    class_rapid(
      info = class_info(title = "A", version = "1"),
      components = class_components(
        security_schemes = class_security_schemes(
          name = "the_defined_one",
          details = class_security_scheme_details(
            class_api_key_security_scheme("this_one", location = "header")
          )
        )
      ),
      security = class_security(
        name = "an_undefined_one"
      )
    ),
    error = TRUE
  )
})

test_that("class_rapid() returns an empty rapid", {
  expect_snapshot({
    test_result <- class_rapid()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::rapid", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("info", "servers", "components", "security")
  )
})

test_that("length() of a rapid reports the overall length", {
  expect_equal(length(class_rapid()), 0)
  expect_equal(
    length(
      class_rapid(
        info = class_info(title = "A", version = "1"),
        servers = class_servers(
          url = "https://development.gigantic-server.com/v1"
        )
      )
    ),
    1
  )
  expect_equal(
    length(
      class_rapid(
        info = class_info(title = "A", version = "1"),
        servers = class_servers(
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
    as_rapid(class_rapid()),
    class_rapid()
  )
  expect_identical(
    as_rapid(),
    class_rapid()
  )
  expect_identical(
    as_rapid(NULL),
    class_rapid()
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

test_that("as_rapid() errors informatively for unnamed input", {
  expect_snapshot(
    as_rapid(list(letters)),
    error = TRUE
  )
  expect_snapshot(
    as_rapid(list(list("https://example.com", "A cool server."))),
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
    class_rapid(
      info = class_info(
        title = "Sample Pet Store App",
        summary = "A pet store manager.",
        description = "This is a sample server for a pet store.",
        terms_of_service = "https://example.com/terms/",
        contact = class_contact(
          name = "API Support",
          url = "https://www.example.com/support",
          email = "support@example.com"
        ),
        license = class_license(
          name = "Apache 2.0",
          url = "https://www.apache.org/licenses/LICENSE-2.0.html"
        ),
        version = "1.0.1"
      ),
      servers = class_servers(
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
    class_rapid()
  )
})

test_that("as_rapid() works for yaml urls", {
  skip_if_not(Sys.getenv("RAPID_TEST_DL") == "true")
  yaml_url <- "https://api.apis.guru/v2/specs/amazonaws.com/AWSMigrationHub/2017-05-31/openapi.yaml"
  expect_warning(expect_warning(
    expect_warning(
      expect_warning(
        expect_warning(
          expect_warning(
            {
              test_result <- as_rapid(url(yaml_url))
            },
            "x_has_equivalent_paths",
            class = "rapid_warning_extra_names"
          ),
          "x_release",
          class = "rapid_warning_extra_names"
        ),
        "x_twitter",
        class = "rapid_warning_extra_names"
      ),
      "parameters",
      class = "rapid_warning_extra_names"
    ),
    "x_amazon_apigateway_authtype",
    class = "rapid_warning_extra_names"
  ), "x_apisguru_driver", class = "rapid_warning_extra_names")
  expect_snapshot(test_result)
})

test_that("as_rapid() works for json urls", {
  skip_if_not(Sys.getenv("RAPID_TEST_DL") == "true")

  json_url <- "https://api.apis.guru/v2/specs/amazonaws.com/AWSMigrationHub/2017-05-31/openapi.json"
  expect_warning(expect_warning(
    expect_warning(
      expect_warning(
        expect_warning(
          expect_warning(
            {
              test_result <- as_rapid(url(json_url))
            },
            "x_has_equivalent_paths",
            class = "rapid_warning_extra_names"
          ),
          "x_release",
          class = "rapid_warning_extra_names"
        ),
        "x_twitter",
        class = "rapid_warning_extra_names"
      ),
      "parameters",
      class = "rapid_warning_extra_names"
    ),
    "x_amazon_apigateway_authtype",
    class = "rapid_warning_extra_names"
  ), "x_apisguru_driver", class = "rapid_warning_extra_names")
  expect_snapshot(test_result)
})

test_that("as_rapid() stores origin info for urls", {
  skip_if_not(Sys.getenv("RAPID_TEST_DL") == "true")
  test_url <- "https://api.open.fec.gov/swagger/"
  expect_warning(
    {
      test_result <- as_rapid(url(test_url))
    },
    "swagger",
    class = "rapid_warning_extra_names"
  )
  expect_snapshot(test_result)
  expect_identical(test_result@info@origin@url, test_url)
})

test_that("as_rapid() works for empty optional fields", {
  # TODO: Manually generate a more-broken example.
  #
  # x <-
  #   url("https://api.apis.guru/v2/specs/fec.gov/1.0/openapi.yaml") |>
  #   yaml::read_yaml()
  # saveRDS(x, test_path("fixtures", "fec.rds"))
  x <- readRDS(test_path("fixtures", "fec.rds"))

  expect_warning(
    expect_warning(
      expect_warning(
        expect_warning(
          {
            test_result <- as_rapid(x)
          },
          "openapi",
          class = "rapid_warning_extra_names"
        ),
        "x_twitter",
        class = "rapid_warning_extra_names"
      ),
      "x_apisguru_categories",
      class = "rapid_warning_extra_names"
    ),
    "schemas",
    class = "rapid_warning_extra_names"
  )

  expect_snapshot(test_result)
})
