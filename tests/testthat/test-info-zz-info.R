# It was tempting to try to check requirements in this (and presumably both
# above and below here), but many APIDs fail to properly follow specs. This
# object should allow issues, and then we can check what's missing that should
# be there and report on it, likely via a subclass.

test_that("info() requires URLs for TOS", {
  expect_snapshot(
    info(terms_of_service = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    info(terms_of_service = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    info(terms_of_service = "not a real url"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("info() returns an empty info", {
  expect_snapshot({
    test_result <- info()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::info", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c(
      "contact",
      "description",
      "license",
      "summary",
      "terms_of_service",
      "title",
      "version"
    )
  )
})

test_that("length() of an info reports the overall length", {
  expect_equal(length(info()), 0)
  expect_equal(
    length(
      info(
        title = "My Cool API",
        license = license(
          name = "Apache 2.0",
          url = "https://opensource.org/license/apache-2-0/"
        )
      )
    ),
    1
  )
})

test_that("Can construct a contact from an api spec", {
  # apid_list_guru <- yaml::read_yaml("https://api.apis.guru/v2/openapi.yaml")
  # saveRDS(apid_list_guru, test_path("fixtures", "apid_list_guru.rds"))
  apid_list_guru <- readRDS(test_path("fixtures", "apid_list_guru.rds"))
  expect_snapshot({
    test_result <- info(apid_list = apid_list_guru)
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::info", "S7_object"),
    exact = TRUE
  )

  # apid_list_awsmh <- yaml::read_yaml("https://api.apis.guru/v2/specs/amazonaws.com/AWSMigrationHub/2017-05-31/openapi.yaml")
  # saveRDS(apid_list_awsmh, test_path("fixtures", "apid_list_awsmh.rds"))
  apid_list_awsmh <- readRDS(test_path("fixtures", "apid_list_awsmh.rds"))
  expect_snapshot({
    test_result <- info(apid_list = apid_list_awsmh)
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::info", "S7_object"),
    exact = TRUE
  )
})
