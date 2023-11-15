test_that("class_api_key_security_scheme() requires that location is valid", {
  expect_snapshot(
    class_api_key_security_scheme(
      location = "invalid place",
      parameter_name = "parm1"
    ),
    error = TRUE
  )
})

test_that("class_api_key_security_scheme() works with valid objects", {
  expect_snapshot({
    test_result <- class_api_key_security_scheme(
      location = "query",
      parameter_name = "parm1"
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c(
      "rapid::api_key_security_scheme",
      "rapid::security_scheme",
      "S7_object"
    ),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("parameter_name", "location")
  )
})

test_that("length() of a api_key_security_scheme reports the proper length", {
  expect_equal(length(class_api_key_security_scheme()), 0)
  expect_equal(
    length(
      class_api_key_security_scheme(location = "header", parameter_name = "parm2")
    ),
    1
  )
})

test_that("as_api_key_security_scheme() errors for unnamed input", {
  expect_snapshot(
    as_api_key_security_scheme(list("Jon", "jonthegeek@gmail.com")),
    error = TRUE
  )
})

test_that("as_api_key_security_scheme() errors informatively for bad classes", {
  expect_snapshot(
    as_api_key_security_scheme(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_api_key_security_scheme(mean),
    error = TRUE
  )
  expect_snapshot(
    as_api_key_security_scheme(TRUE),
    error = TRUE
  )
})

test_that("as_api_key_security_scheme() returns expected objects", {
  expect_warning(
    as_api_key_security_scheme(
      list(
        name = "Authorization",
        `in` = "header",
        `x-amazon-apigateway-authtype` = "awsSigv4"
      )
    ),
    regexp = "x_amazon_apigateway_authtype",
    class = "rapid_warning_extra_names"
  )

  expect_identical(
    suppressWarnings(as_api_key_security_scheme(
      list(
        name = "Authorization",
        `in` = "header",
        `x-amazon-apigateway-authtype` = "awsSigv4"
      )
    )),
    class_api_key_security_scheme(
      parameter_name = "Authorization",
      location = "header"
    )
  )
  expect_identical(
    as_api_key_security_scheme(
      list(
        name = "X-APISETU-CLIENTID",
        `in` = "cookie"
      )
    ),
    class_api_key_security_scheme(
      parameter_name = "X-APISETU-CLIENTID",
      location = "cookie"
    )
  )
  expect_identical(
    as_api_key_security_scheme(
      c(
        parameter_name = "X-APISETU-APIKEY",
        location = "query"
      )
    ),
    class_api_key_security_scheme(
      parameter_name = "X-APISETU-APIKEY",
      location = "query"
    )
  )

  expect_identical(
    as_api_key_security_scheme(list()),
    class_api_key_security_scheme()
  )
})

test_that("as_api_key_security_scheme() works for api_key_security_scheme", {
  expect_identical(
    as_api_key_security_scheme(class_api_key_security_scheme()),
    class_api_key_security_scheme()
  )
})
