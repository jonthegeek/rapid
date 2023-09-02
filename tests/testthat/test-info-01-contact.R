test_that("api_contact() errors informatively for bad name", {
  expect_snapshot(
    api_contact(name = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(name = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_contact() errors informatively for bad url", {
  expect_snapshot(
    api_contact(name = "A", url = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(name = "A", url = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(name = "A", url = "not a real url"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_contact() errors informatively for bad email", {
  expect_snapshot(
    api_contact(name = "A", url = "https://example.com", email = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(name = "A", url = "https://example.com", email = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_contact(
      name = "A",
      url = "https://example.com",
      email = "not a real email"
    ),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_contact() returns a contact when everything is ok", {
  expect_snapshot({
    test_result <- api_contact(
      name = "A",
      url = "https://example.com",
      email = "real.email@address.place"
    )
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::api_contact", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "email", "url")
  )
})

test_that("api_contact() without args returns an empty api_contact", {
  expect_snapshot({
    test_result <- api_contact()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::api_contact", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c("name", "email", "url")
  )
})

test_that("length() of an api_contact reports the overall length", {
  expect_equal(length(api_contact()), 0)
  expect_equal(length(api_contact(name = "A")), 1)
})

test_that("as_api_contact() errors informatively for unnamed or misnamed input", {
  expect_snapshot(
    as_api_contact(letters),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_api_contact(list(a = "Jon", b = "jonthegeek@gmail.com")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_api_contact(c(a = "Jon", b = "jonthegeek@gmail.com")),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_api_contact() errors informatively for bad classes", {
  expect_snapshot(
    as_api_contact(1:2),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_api_contact(mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    as_api_contact(TRUE),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("as_api_contact() returns expected objects", {
  expect_identical(
    as_api_contact(
      c(
        name = "Jon",
        email = "jonthegeek@gmail.com",
        url = "https://jonthegeek.com"
      )
    ),
    api_contact(
      name = "Jon",
      email = "jonthegeek@gmail.com",
      url = "https://jonthegeek.com"
    )
  )
  expect_identical(
    as_api_contact(
      c(
        name = "Jon",
        email = "jonthegeek@gmail.com",
        x = "https://jonthegeek.com"
      )
    ),
    api_contact(
      name = "Jon",
      email = "jonthegeek@gmail.com"
    )
  )
  expect_identical(
    as_api_contact(
      c(
        email = "jonthegeek@gmail.com",
        name = "Jon",
        x = "https://jonthegeek.com"
      )
    ),
    api_contact(
      name = "Jon",
      email = "jonthegeek@gmail.com"
    )
  )
  expect_identical(
    as_api_contact(
      list(
        name = "Jon",
        email = "jonthegeek@gmail.com",
        x = "https://jonthegeek.com"
      )
    ),
    api_contact(
      name = "Jon",
      email = "jonthegeek@gmail.com"
    )
  )
  expect_identical(
    as_api_contact(list()),
    api_contact()
  )
})
