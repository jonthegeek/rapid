test_that("class_parameters() errors informatively for bad locations", {
  expect_error(
    class_parameters(location = "bad"),
    class = "stbl_error_fct_levels"
  )
})

test_that("class_parameters() requires both parameter_name and location", {
  expect_snapshot(
    class_parameters(location = "query"),
    error = TRUE
  )
})

test_that("class_parameters() without args returns an empty parameters object", {
  expect_snapshot({
    test_result <- class_parameters()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::parameters", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c(
      "parameter_name", "location", "content", "description", "required",
      "allow_empty_value", "deprecated"
    )
  )
})

test_that("length() of a parameters object reports the overall length", {
  expect_equal(length(class_parameters()), 0)
  expect_equal(length(class_parameters(parameter_name = "A", location = "query")), 1)
})
