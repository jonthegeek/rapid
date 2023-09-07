# I'm building this as I have pieces ready, so the tests will change as I add
# more sub-objects.

test_that("rapid() requires info objects for info", {
  expect_snapshot(
    rapid(info = mean),
    error = TRUE,
    cnd_class = TRUE
  )
})

test_that("rapid() requires info when anything is defined", {
  expect_snapshot(
    rapid(
      servers = servers(
        url = c(
          "https://development.gigantic-server.com/v1",
          "https://staging.gigantic-server.com/v1",
          "https://api.gigantic-server.com/v1"
        ),
        description = c(
          "Development server",
          "Staging server",
          "Production server"
        )
      )
    ),
    error = TRUE
  )
})

test_that("rapid() returns an empty rapid", {
  expect_snapshot({
    test_result <- rapid()
    test_result
  })
  expect_s3_class(
    test_result,
    class = c("rapid::rapid", "S7_object"),
    exact = TRUE
  )
  expect_identical(
    S7::prop_names(test_result),
    c(
      "info",
      "servers"
    )
  )
})

test_that("length() of a rapid reports the overall length", {
  expect_equal(length(rapid()), 0)
  expect_equal(
    length(
      rapid(
        info = info(title = "A", version = "1"),
        servers(
          url = "https://development.gigantic-server.com/v1"
        )
      )
    ),
    1
  )
  expect_equal(
    length(
      rapid(
        info = info(title = "A", version = "1"),
        servers(
          url = c(
            "https://development.gigantic-server.com/v1",
            "https://staging.gigantic-server.com/v1",
            "https://api.gigantic-server.com/v1"
          ),
          description = c(
            "Development server",
            "Staging server",
            "Production server"
          )
        )
      )
    ),
    1
  )
})

# test_that("Can construct a rapid from an apid list", {
#   # apid_list_guru <- yaml::read_yaml("https://api.apis.guru/v2/openapi.yaml")
#   # saveRDS(apid_list_guru, test_path("fixtures", "apid_list_guru.rds"))
#   apid_list_guru <- readRDS(test_path("fixtures", "apid_list_guru.rds"))
#   expect_snapshot({
#     test_result <- as_rapid(apid_list_guru)
#     test_result
#   })
#   expect_s3_class(
#     test_result,
#     class = c("rapid::rapid", "S7_object"),
#     exact = TRUE
#   )
#
#   # apid_list_awsmh <- yaml::read_yaml("https://api.apis.guru/v2/specs/amazonaws.com/AWSMigrationHub/2017-05-31/openapi.yaml")
#   # saveRDS(apid_list_awsmh, test_path("fixtures", "apid_list_awsmh.rds"))
#   apid_list_awsmh <- readRDS(test_path("fixtures", "apid_list_awsmh.rds"))
#   expect_snapshot({
#     test_result <- as_rapid(apid_list_awsmh)
#     test_result
#   })
#   expect_s3_class(
#     test_result,
#     class = c("rapid::rapid", "S7_object"),
#     exact = TRUE
#   )
# })
#
# test_that("Can construct a rapid from an apid url", {
#   skip_if_not(Sys.getenv("RAPID_TEST_DL") == "true")
#   expect_snapshot({
#     test_result <- as_rapid("https://api.apis.guru/v2/openapi.yaml")
#     test_result
#   })
#   expect_s3_class(
#     test_result,
#     class = c("rapid::rapid", "S7_object"),
#     exact = TRUE
#   )
#   expect_snapshot({
#     test_result <- as_rapid("https://api.apis.guru/v2/specs/amazonaws.com/AWSMigrationHub/2017-05-31/openapi.yaml")
#     test_result
#   })
#   expect_s3_class(
#     test_result,
#     class = c("rapid::rapid", "S7_object"),
#     exact = TRUE
#   )
# })
