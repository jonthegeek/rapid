# It was tempting to try to check requirements in this (and presumably both
# above and below here), but many APIDs fail to properly follow specs. This
# object should allow issues, and then we can check what's missing that should
# be there and report on it, likely via a subclass.

test_that("api_info() requires URLs for TOS", {
  expect_snapshot(
    api_info(terms_of_service = mean),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_info(terms_of_service = c("A", "B")),
    error = TRUE,
    cnd_class = TRUE
  )
  expect_snapshot(
    api_info(terms_of_service = "not a real url"),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("api_info() returns an empty api_info", {
  expect_snapshot({
    test_result <- api_info()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::api_info", "S7_object"),
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

test_that("length() of an api_info reports the overall length", {
  expect_equal(length(api_info()), 0)
  expect_equal(
    length(
      api_info(
        title = "My Cool API",
        license = api_license(
          name = "Apache 2.0",
          url = "https://opensource.org/license/apache-2-0/"
        )
      )
    ),
    1
  )
})

test_that("Can construct an api_contact from an api spec", {
  # apid_list_guru <- yaml::read_yaml("https://api.apis.guru/v2/openapi.yaml")
  # saveRDS(apid_list_guru, test_path("fixtures", "apid_list_guru.rds"))
  apid_list_guru <- readRDS(test_path("fixtures", "apid_list_guru.rds"))
  expect_snapshot({
    test_result <- api_info(apid_list = apid_list_guru)
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::api_info", "S7_object"),
    exact = TRUE
  )

  # apid_list_awsmh <- yaml::read_yaml("https://api.apis.guru/v2/specs/amazonaws.com/AWSMigrationHub/2017-05-31/openapi.yaml")
  # saveRDS(apid_list_awsmh, test_path("fixtures", "apid_list_awsmh.rds"))
  apid_list_awsmh <- readRDS(test_path("fixtures", "apid_list_awsmh.rds"))
  expect_snapshot({
    test_result <- api_info(apid_list = apid_list_awsmh)
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::api_info", "S7_object"),
    exact = TRUE
  )
})
