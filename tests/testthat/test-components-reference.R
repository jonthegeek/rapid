test_that("class_reference() errors informatively for non-scalar ref_uri", {
  expect_error(
    class_reference(ref_uri = c("a", "b")),
    class = "stbl_error_non_scalar"
  )
})

test_that("class_reference() without args returns an empty schema object", {
  expect_snapshot({
    test_result <- class_reference()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::reference", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("ref_uri", "summary", "description")
  )
})

test_that("length() of a reference object reports the overall length", {
  expect_equal(length(class_reference()), 0)
  expect_equal(length(class_reference(ref_uri = "a")), 1)
})

test_that("as_reference() returns expected objects", {
  expect_identical(
    as_reference(list(ref_uri = "a")),
    class_reference(ref_uri = "a")
  )

  expect_identical(
    as_reference(list(`$ref` = "a")),
    class_reference(ref_uri = "a")
  )

  expect_identical(
    as_reference(list()),
    class_reference()
  )
})
