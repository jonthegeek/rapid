test_that("scopes() requires that description matches name", {
  expect_snapshot(
    scopes("a"),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    scopes("a", letters),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    scopes(letters, "a"),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    scopes(character(), "a"),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    scopes("a", character()),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("scopes() works with equal-length name/descript", {
  expect_snapshot({
    test_result <- scopes("a", "b")
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
  expect_equal(length(scopes()), 0)
  expect_equal(length(scopes(name = "A", description = "A")), 1)
  expect_equal(length(scopes(name = letters, description = LETTERS)), 26)
})

test_that("as_scopes() errors informatively for unnamed input", {
  expect_snapshot(
    as_scopes("a"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_scopes() errors informatively for bad classes", {
  expect_snapshot(
    as_scopes(1:2),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_scopes(mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_scopes(TRUE),
    error = TRUE,
    cnd_class = TRUE
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
    scopes(
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
    scopes(
      name = c("a", "b"),
      description = c("aa", "bb")
    )
  )

  expect_identical(
    as_scopes(list()),
    scopes()
  )

  expect_identical(
    as_scopes(character()),
    scopes()
  )
})

test_that("as_scopes() works for scopes", {
  expect_identical(
    as_scopes(scopes()),
    scopes()
  )
})
