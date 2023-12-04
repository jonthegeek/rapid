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

test_that("enum_property_rename() returns expected object", {
  local_mocked_bindings(
    `prop<-` = function(self, name, value, check = FALSE) {
      force(check)
      self[[name]] <- value
      self
    }
  )
  expect_snapshot({
    test_result <- enum_property_rename("propname")
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
