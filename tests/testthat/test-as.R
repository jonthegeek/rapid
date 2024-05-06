test_that("as_api_object() fails informatively with bad x", {
  simple_class <- S7::new_class(
    "range",
    properties = list(
      start = S7::class_numeric,
      end = S7::class_numeric
    )
  )
  expect_no_error(as_api_object(NULL, simple_class))
  expect_error(
    as_api_object(1, simple_class),
    class = "rapid_error_unknown_coercion"
  )
})

test_that("as_api_object() warns about unexpected fields", {
  simple_class <- S7::new_class(
    "range",
    properties = list(
      start = S7::class_numeric,
      end = S7::class_numeric
    )
  )
  expect_warning(
    {as_api_object(list(start = 1, end = 2, a = 1), simple_class)},
    class = "rapid_warning_extra_names"
  )
})
