test_that("api_key_security_scheme requires names for optional arguments", {
  expect_snapshot(
    api_key_security_scheme("a", "b", "c", `in` = "header"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_key_security_scheme() requires that `in` is valid", {
  expect_snapshot(
    api_key_security_scheme(
      name = c("my_key", "other"),
      description = c("desc", "desc2"),
      'in' = c("query", "invalid place"),
      parameter_name = c("parm1", "parm2")
    ),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_key_security_scheme() works with valid objects", {
  expect_snapshot({
    test_result <- api_key_security_scheme(
      name = c("my_key", "other"),
      description = c("desc", "desc2"),
      'in' = c("query", "header"),
      parameter_name = c("parm1", "parm2")
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c(
      "rapid::api_key_security_scheme", "rapid::security_scheme", "S7_object"
    ),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "description", "parameter_name", "in")
  )
})

test_that("length() of a api_key_security_scheme reports the proper length", {
  expect_equal(length(api_key_security_scheme()), 0)
  expect_equal(
    length(
      api_key_security_scheme(
        name = c("my_key", "other"),
        description = c("desc", "desc2"),
        'in' = c("query", "header"),
        parameter_name = c("parm1", "parm2")
      )
    ),
    2
  )
})

test_that("as_api_key_security_scheme() errors informatively for unnamed or misnamed input", {
  expect_snapshot(
    as_api_key_security_scheme(
      list(first = list(a = "Jon", b = "jonthegeek@gmail.com"))
    ),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_api_key_security_scheme() errors informatively for bad classes", {
  expect_snapshot(
    as_api_key_security_scheme(letters),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_api_key_security_scheme(1:2),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_api_key_security_scheme(mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_api_key_security_scheme(TRUE),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_api_key_security_scheme() returns expected objects", {
  expect_identical(
    as_api_key_security_scheme(
      list(
        `amazonaws.com:alexaforbusiness_hmac` = list(
          type = "apiKey",
          name = "Authorization",
          `in` = "header",
          description = "Amazon Signature authorization v4",
          `x-amazon-apigateway-authtype` = "awsSigv4"
        ),
        `apisetu.gov.in:landrecordskar_clientId` = list(
          `in` = "cookie",
          name = "X-APISETU-CLIENTID",
          type = "apiKey"
        ),
        `apisetu.gov.in:transportkl_apiKey` = list(
          `in` = "query",
          name = "X-APISETU-APIKEY",
          type = "apiKey"
        )
      )
    ),
    api_key_security_scheme(
      name = c(
        "amazonaws.com:alexaforbusiness_hmac",
        "apisetu.gov.in:landrecordskar_clientId",
        "apisetu.gov.in:transportkl_apiKey"
      ),
      description = c("Amazon Signature authorization v4", NA, NA),
      parameter_name = c(
        "Authorization",
        "X-APISETU-CLIENTID",
        "X-APISETU-APIKEY"
      ),
      `in` = c("header", "cookie", "query")
    )
  )

  expect_identical(
    as_api_key_security_scheme(list()),
    api_key_security_scheme()
  )
})

test_that("as_api_key_security_scheme() works for api_key_security_scheme", {
  expect_identical(
    as_api_key_security_scheme(api_key_security_scheme()),
    api_key_security_scheme()
  )
})
