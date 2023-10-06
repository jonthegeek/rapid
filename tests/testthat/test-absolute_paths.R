test_that("expand_servers can expand servers", {
  # test_url <- "https://api.apis.guru/v2/specs/fec.gov/1.0/openapi.yaml"
  # input_rapid <- suppressWarnings(as_rapid(url(test_url)))
  # input_rapid@servers <- servers(
  #   url = c(input_rapid@servers@url, "https://example.com")
  # )
  # saveRDS(input_rapid, test_path("fixtures", "fec_guru_rapid.rds"))
  input_rapid <- readRDS(test_path("fixtures", "fec_guru_rapid.rds"))
  output_rapid <- expand_servers(input_rapid)
  expect_identical(
    output_rapid@servers@url,
    c("https://api.open.fec.gov/v1", "https://example.com")
  )
})
