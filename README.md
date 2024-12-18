
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rapid

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/rapid)](https://CRAN.R-project.org/package=rapid)
[![Codecov test
coverage](https://codecov.io/gh/jonthegeek/rapid/branch/main/graph/badge.svg)](https://app.codecov.io/gh/jonthegeek/rapid?branch=main)
[![R-CMD-check](https://github.com/jonthegeek/rapid/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jonthegeek/rapid/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Convert an API description (APID), such as one that follows the [OpenAPI
Specification](https://spec.openapis.org/oas/v3.1.0), to an R API
description object. The R object belongs to a new
[S7](https://rconsortium.github.io/S7) class, `rapid`, which enforces a
strict, opinionated schema.

## Installation

<div class="pkgdown-release">

Install the released version of rapid from
[CRAN](https://cran.r-project.org/):

``` r
install.packages("rapid")
```

</div>

<div class="pkgdown-devel">

Install the development version of rapid from
[GitHub](https://github.com/):

``` r
# install.packages("pak")
pak::pak("jonthegeek/rapid")
```

</div>

## Usage

This package will be used by [{beekeeper}](https://beekeeper.api2r.org/)
and [{mockplumber}](https://jonthegeek.github.io/mockplumber/).

## Code of Conduct

Please note that the rapid project is released with a [Contributor Code
of Conduct](https://jonthegeek.github.io/rapid/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
