test_that("class_scopes() requires that description matches name", {
  expect_snapshot(
    class_scopes("a"),
    error = TRUE
  )
  expect_snapshot(
    class_scopes("a", letters),
    error = TRUE
  )
  expect_snapshot(
    class_scopes(letters, "a"),
    error = TRUE
  )
  expect_snapshot(
    class_scopes(character(), "a"),
    error = TRUE
  )
  expect_snapshot(
    class_scopes("a", character()),
    error = TRUE
  )
})

test_that("class_scopes() works with equal-length name/descript", {
  expect_snapshot({
    test_result <- class_scopes("a", "b")
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::scopes", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "description")
  )
})

test_that("length() of a scopes reports the overall length", {
  expect_equal(length(class_scopes()), 0)
  expect_equal(length(class_scopes(name = "A", description = "A")), 1)
  expect_equal(length(class_scopes(name = letters, description = LETTERS)), 26)
})

test_that("as_scopes() errors informatively for unnamed input", {
  expect_snapshot(
    as_scopes("a"),
    error = TRUE
  )
})

test_that("as_scopes() errors informatively for bad classes", {
  expect_snapshot(
    as_scopes(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_scopes(mean),
    error = TRUE
  )
  expect_snapshot(
    as_scopes(TRUE),
    error = TRUE
  )
})

test_that("as_scopes() errors informatively for weird lists", {
  expect_error(
    as_scopes(list(a = mean)),
    class = "stbl_error_coerce_character"
  )
})

test_that("as_scopes() returns expected objects", {
  expect_identical(
    as_scopes(
      list(
        a = "aa",
        b = "bb"
      )
    ),
    class_scopes(
      name = c("a", "b"),
      description = c("aa", "bb")
    )
  )
  expect_identical(
    as_scopes(
      c(
        a = "aa",
        b = "bb"
      )
    ),
    class_scopes(
      name = c("a", "b"),
      description = c("aa", "bb")
    )
  )

  expect_identical(
    as_scopes(list()),
    class_scopes()
  )

  expect_identical(
    as_scopes(character()),
    class_scopes()
  )
})

test_that("as_scopes() works for scopes", {
  expect_identical(
    as_scopes(class_scopes()),
    class_scopes()
  )
})
