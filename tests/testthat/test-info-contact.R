test_that("class_contact() errors informatively for bad name", {
  expect_snapshot(
    class_contact(name = mean),
    error = TRUE
  )
  expect_snapshot(
    class_contact(name = c("A", "B")),
    error = TRUE
  )
})

test_that("class_contact() errors informatively for bad email", {
  expect_snapshot(
    class_contact(name = "A", url = "https://example.com", email = mean),
    error = TRUE
  )
  expect_snapshot(
    class_contact(name = "A", url = "https://example.com", email = c("A", "B")),
    error = TRUE
  )
  expect_snapshot(
    class_contact(
      name = "A",
      url = "https://example.com",
      email = "not a real email"
    ),
    error = TRUE
  )
})

test_that("class_contact() returns a contact when everything is ok", {
  expect_snapshot({
    test_result <- class_contact(
      name = "A",
      url = "https://example.com",
      email = "real.email@address.place"
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::contact", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "email", "url")
  )
})

test_that("class_contact() without args returns an empty contact", {
  expect_snapshot({
    test_result <- class_contact()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::contact", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "email", "url")
  )
})

test_that("length() of a contact reports the overall length", {
  expect_equal(length(class_contact()), 0)
  expect_equal(length(class_contact(name = "A")), 1)
})

test_that("as_contact() errors informatively for unnamed input", {
  expect_snapshot(
    as_contact(letters),
    error = TRUE
  )
  expect_snapshot(
    as_contact(list("Jon", "jonthegeek@gmail.com")),
    error = TRUE
  )
  expect_snapshot(
    as_contact(c("Jon", "jonthegeek@gmail.com")),
    error = TRUE
  )
})

test_that("as_contact() errors informatively for bad classes", {
  expect_snapshot(
    as_contact(1:2),
    error = TRUE
  )
  expect_snapshot(
    as_contact(mean),
    error = TRUE
  )
  expect_snapshot(
    as_contact(TRUE),
    error = TRUE
  )
})

test_that("as_contact() returns expected objects", {
  expect_identical(
    as_contact(
      c(
        name = "Jon",
        email = "jonthegeek@gmail.com",
        url = "https://jonthegeek.com"
      )
    ),
    class_contact(
      name = "Jon",
      email = "jonthegeek@gmail.com",
      url = "https://jonthegeek.com"
    )
  )
  expect_identical(
    as_contact(
      c(
        name = "Jon",
        email = "jonthegeek@gmail.com"
      )
    ),
    class_contact(
      name = "Jon",
      email = "jonthegeek@gmail.com"
    )
  )
  expect_identical(
    as_contact(
      c(
        email = "jonthegeek@gmail.com",
        name = "Jon"
      )
    ),
    class_contact(
      name = "Jon",
      email = "jonthegeek@gmail.com"
    )
  )
  expect_identical(
    as_contact(
      list(
        name = "Jon",
        email = "jonthegeek@gmail.com"
      )
    ),
    class_contact(
      name = "Jon",
      email = "jonthegeek@gmail.com"
    )
  )
  expect_identical(
    as_contact(list()),
    class_contact()
  )
})

test_that("as_contact() works for contacts", {
  expect_identical(
    as_contact(class_contact()),
    class_contact()
  )
})
