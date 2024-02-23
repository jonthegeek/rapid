test_that("class_parameter() errors informatively for non-scalar parameter_name", {
  expect_error(
    class_parameter(parameter_name = c("a", "b")),
    class = "stbl_error_non_scalar"
  )
})

test_that("class_parameter() requires required/automatic fields", {
  expect_snapshot(
    class_parameter(parameter_name = "a"),
    error = TRUE
  )
  expect_snapshot(
    class_parameter(
      parameter_name = "a",
      schema = class_schema(type = "string"),
      location = "bad"
    ),
    error = TRUE
  )
  expect_snapshot(
    class_parameter(
      parameter_name = "a",
      schema = class_schema(type = "string"),
      allow_empty_value = c(TRUE, FALSE)
    ),
    error = TRUE
  )
  expect_error(
    class_parameter(
      parameter_name = "a",
      schema = class_schema(type = "string"),
      style = "bad"
    ),
    class = "stbl_error_fct_levels"
  )
})

test_that("class_parameter() without args returns an empty parameter object", {
  expect_snapshot({
    test_result <- class_parameter()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::parameter", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c(
      "parameter_name", "location", "schema", "style", "description",
      "required", "allow_empty_value", "allow_reserved", "explode",
      "deprecated"
    )
  )
})

test_that("length() of a parameter object reports the overall length", {
  expect_equal(length(class_parameter()), 0)
  expect_equal(
    length(
      class_parameter(
        parameter_name = "a",
        schema = class_schema(type = "string")
      )
    ),
    1
  )
})

test_that("as_parameter() returns expected objects", {
  expect_identical(
    as_parameter(list(parameter_name = "a", schema = list(type = "string"))),
    class_parameter(
      parameter_name = "a",
      schema = class_schema(type = "string")
    )
  )
  expect_identical(
    as_parameter(list(name = "a", schema = list(type = "string"))),
    class_parameter(
      parameter_name = "a",
      schema = class_schema(type = "string")
    )
  )

  expect_identical(
    as_parameter(list()),
    class_parameter()
  )
})
