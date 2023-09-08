test_that("variables() errors informatively for bad contents", {
  expect_snapshot(
    variables(letters),
    error = TRUE
  )
  expect_snapshot(
    variables(list(letters, letters)),
    error = TRUE
  )
  expect_snapshot(
    variables(
      server_variable(),
      letters,
      server_variable(),
      letters
    ),
    error = TRUE
  )
})

test_that("variables() returns an empty variables", {
  expect_snapshot(variables())
})

test_that("variables() accepts bare server_variables", {
  expect_snapshot(variables(server_variable()))
  expect_snapshot(variables(server_variable(), server_variable()))
})

test_that("variables() accepts lists of server_variables", {
  expect_snapshot(variables(list(server_variable())))
  expect_snapshot(
    variables(list(server_variable(), server_variable()))
  )
})
