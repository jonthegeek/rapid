test_that("scopes_list() errors informatively for bad contents", {
  expect_snapshot(
    scopes_list(letters),
    error = TRUE
  )
  expect_snapshot(
    scopes_list(list(letters, letters)),
    error = TRUE
  )
  expect_snapshot(
    scopes_list(
      scopes(),
      letters,
      scopes(),
      letters
    ),
    error = TRUE
  )
})

test_that("scopes_list() returns an empty scopes_list", {
  expect_snapshot(scopes_list())
})

test_that("scopes_list() accepts bare scopes", {
  expect_snapshot(scopes_list(scopes()))
  expect_snapshot(
    scopes_list(scopes(), scopes())
  )
})

test_that("scopes_list() accepts lists of scopes", {
  expect_snapshot(scopes_list(list(scopes())))
  expect_snapshot(
    scopes_list(list(scopes(), scopes()))
  )
})

test_that("as_scopes_list() errors informatively for bad classes", {
  expect_snapshot(
    as_scopes_list(1:2),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_scopes_list(mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_scopes_list(TRUE),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_scopes_list() returns expected objects", {
  expect_identical(
    as_scopes_list(
      list(
        list(
          "scopename" = "do things",
          "scopename2" = "do other things"
        ),
        list(
          "scopename3" = "do more things",
          "scopename4" = "do even more things"
        )
      )
    ),
    scopes_list(
      scopes(
        name = c("scopename", "scopename2"),
        description = c("do things", "do other things")
      ),
      scopes(
        name = c("scopename3", "scopename4"),
        description = c("do more things", "do even more things")
      )
    )
  )
  expect_identical(
    as_scopes_list(
      list(
        c(
          "scopename" = "do things",
          "scopename2" = "do other things"
        ),
        c(
          "scopename3" = "do more things",
          "scopename4" = "do even more things"
        )
      )
    ),
    scopes_list(
      scopes(
        name = c("scopename", "scopename2"),
        description = c("do things", "do other things")
      ),
      scopes(
        name = c("scopename3", "scopename4"),
        description = c("do more things", "do even more things")
      )
    )
  )

  expect_identical(
    as_scopes_list(list()),
    scopes_list()
  )
  expect_identical(
    as_scopes_list(list(character(), character())),
    scopes_list()
  )
})

test_that("as_scopes_list() works for scopes_list", {
  expect_identical(
    as_scopes_list(scopes_list()),
    scopes_list()
  )
})
