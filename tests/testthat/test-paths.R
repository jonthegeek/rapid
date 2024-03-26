test_that("class_paths() returns an empty paths", {
  expect_snapshot({
    test_result <- class_paths()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::paths", "data.frame", "S7_object"),
    exact = TRUE
  )
})

test_that("as_paths() errors informatively for bad classes", {
  expect_snapshot(
    as_paths(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_paths(mean),
    error = TRUE
  )
  expect_snapshot(
    as_paths(TRUE),
    error = TRUE
  )
})

test_that("as_paths() returns expected objects", {
  expect_identical(
    as_paths(mtcars),
    class_paths(mtcars)
  )
  expect_identical(
    as_paths(data.frame()),
    class_paths()
  )
  expect_identical(
    as_paths(tibble::tibble()),
    class_paths()
  )
  expect_identical(
    as_paths(),
    class_paths()
  )
})

test_that("as_paths() works for paths", {
  expect_identical(
    as_paths(class_paths()),
    class_paths()
  )
})
