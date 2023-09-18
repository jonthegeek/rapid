test_that("contact() errors informatively for bad name", {
  expect_snapshot(
    contact(name = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    contact(name = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("contact() errors informatively for bad email", {
  expect_snapshot(
    contact(name = "A", url = "https://example.com", email = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    contact(name = "A", url = "https://example.com", email = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    contact(
      name = "A",
      url = "https://example.com",
      email = "not a real email"
    ),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("contact() returns a contact when everything is ok", {
  expect_snapshot({
    test_result <- contact(
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

test_that("contact() without args returns an empty contact", {
  expect_snapshot({
    test_result <- contact()
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
  expect_equal(length(contact()), 0)
  expect_equal(length(contact(name = "A")), 1)
})

test_that("as_contact() errors informatively for unnamed or misnamed input", {
  expect_snapshot(
    as_contact(letters),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_contact(list(a = "Jon", b = "jonthegeek@gmail.com")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_contact(c(a = "Jon", b = "jonthegeek@gmail.com")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_contact() errors informatively for bad classes", {
  expect_snapshot(
    as_contact(1:2),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_contact(mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_contact(TRUE),
    error = TRUE,
    cnd_class = TRUE
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
    contact(
      name = "Jon",
      email = "jonthegeek@gmail.com",
      url = "https://jonthegeek.com"
    )
  )
  expect_identical(
    as_contact(
      c(
        name = "Jon",
        email = "jonthegeek@gmail.com",
        x = "https://jonthegeek.com"
      )
    ),
    contact(
      name = "Jon",
      email = "jonthegeek@gmail.com"
    )
  )
  expect_identical(
    as_contact(
      c(
        email = "jonthegeek@gmail.com",
        name = "Jon",
        x = "https://jonthegeek.com"
      )
    ),
    contact(
      name = "Jon",
      email = "jonthegeek@gmail.com"
    )
  )
  expect_identical(
    as_contact(
      list(
        name = "Jon",
        email = "jonthegeek@gmail.com",
        x = "https://jonthegeek.com"
      )
    ),
    contact(
      name = "Jon",
      email = "jonthegeek@gmail.com"
    )
  )
  expect_identical(
    as_contact(list()),
    contact()
  )
})

test_that("as_contact() works for contacts", {
  expect_identical(
    as_contact(contact()),
    contact()
  )
})
