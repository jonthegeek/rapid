test_that("server_variable_list() errors informatively for bad contents", {
  expect_snapshot(
    server_variable_list(letters),
    error = TRUE
  )
  expect_snapshot(
    server_variable_list(list(letters, letters)),
    error = TRUE
  )
  expect_snapshot(
    server_variable_list(
      server_variable(),
      letters,
      server_variable(),
      letters
    ),
    error = TRUE
  )
})

test_that("server_variable_list() returns an empty server_variable_list", {
  expect_snapshot(server_variable_list())
})

test_that("server_variable_list() accepts bare server_variables", {
  expect_snapshot(server_variable_list(server_variable()))
  expect_snapshot(server_variable_list(server_variable(), server_variable()))
})

test_that("server_variable_list() accepts lists of server_variables", {
  expect_snapshot(server_variable_list(list(server_variable())))
  expect_snapshot(
    server_variable_list(list(server_variable(), server_variable()))
  )
})
