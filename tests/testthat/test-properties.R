test_that("character_scalar_property() returns expected object", {
  local_mocked_bindings(
    `prop<-` = function(self, name, value) {
      self[[name]] <- value
      self
    }
  )
  expect_snapshot({
    test_result <- character_scalar_property("propname")
    test_result
  })
  expect_s3_class(test_result, "S7_property", exact = TRUE)
  expect_identical(
    test_result$setter(list(), 12),
    list(propname = "12")
  )
})

test_that("logical_scalar_property() returns expected object", {
  local_mocked_bindings(
    `prop<-` = function(self, name, value) {
      self[[name]] <- value
      self
    }
  )
  expect_snapshot({
    test_result <- logical_scalar_property("propname")
    test_result
  })
  expect_s3_class(test_result, "S7_property", exact = TRUE)
  expect_identical(
    test_result$setter(list(), 1),
    list(propname = TRUE)
  )
})

test_that("factor_property() returns expected object", {
  local_mocked_bindings(
    `prop<-` = function(self, name, value) {
      self[[name]] <- value
      self
    }
  )
  factor_levels <- c("a", "b", "c")
  expect_snapshot({
    test_result <- factor_property("propname", levels = factor_levels)
    test_result
  })
  expect_s3_class(test_result, "S7_property", exact = TRUE)
})

test_that("factor_property() updates properly", {
  local_mocked_bindings(
    `prop<-` = function(self, name, value) {
      self[[name]] <- value
      self
    },
    prop = function(self, name) {
      self[[name]]
    },
    validate = function(self) {
      cli::cli_warn("Validating.")
      self
    }
  )
  factor_levels <- c("a", "b", "c")
  test_result <- factor_property("propname", levels = factor_levels)
  expected_prop <- factor("a", levels = factor_levels)
  attr(expected_prop, "initialized") <- TRUE
  expected_obj <- list(propname = expected_prop)
  expect_identical(
    {
      test_result_set <- test_result$setter(list(), "a")
      test_result_set
    },
    expected_obj
  )
  expected_prop <- factor("b", levels = factor_levels)
  attr(expected_prop, "initialized") <- TRUE
  expected_obj <- list(propname = expected_prop)
  expect_warning(
    expect_identical(
      test_result$setter(test_result_set, "b"),
      expected_obj
    ),
    "Validating."
  )
})

test_that("factor_property() validates", {
  local_mocked_bindings(
    `prop<-` = function(self, name, value) {
      self[[name]] <- value
      self
    },
    prop = function(self, name) {
      self[[name]]
    },
    validate = function(self) {
      cli::cli_warn("Validating.")
      self
    }
  )
  factor_levels <- c("a", "b", "c")
  test_result <- factor_property("propname", levels = factor_levels)
  expect_null(test_result$validator(NULL))
  expect_null(test_result$validator(sample(factor_levels, 10, replace = TRUE)))
  expect_snapshot({
    test_result$validator("d")
  })
})

test_that("enum_property() returns expected object", {
  local_mocked_bindings(
    `prop<-` = function(self, name, value, check = FALSE) {
      force(check)
      self[[name]] <- value
      self
    }
  )
  expect_snapshot({
    test_result <- enum_property("propname")
    test_result
  })
  expect_s3_class(test_result, "S7_property", exact = TRUE)
  expect_identical(
    test_result$setter(list(), 12),
    list(propname = list("12"))
  )
  expect_identical(
    test_result$setter(list(), rep(list(integer()), 5)),
    list(propname = list())
  )
})

test_that("list_of_characters() returns expected object", {
  local_mocked_bindings(
    `prop<-` = function(self, name, value) {
      self[[name]] <- value
      self
    }
  )
  expect_snapshot({
    test_result <- list_of_characters("propname")
    test_result
  })
  expect_s3_class(test_result, "S7_property", exact = TRUE)
  expect_identical(
    test_result$setter(list(), 12),
    list(propname = list("12"))
  )
})
