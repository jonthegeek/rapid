#' rapid <- function(info = rapid_info()) {
#'   .new_rapid(info = info)
#' }
#'
#' .new_rapid <- function(info) {
#'   vctrs::new_vctr(
#'     list(
#'       info = info
#'     ),
#'     class = "rapid",
#'     inherit_base_type = TRUE
#'   )
#' }
#'
#'
#'
#' #' @export
#' vec_ptype_abbr.rapid <- function(x, ...) {
#'   "rapid"
#' }
#'
#' # for compatibility with the S4 system
#' methods::setOldClass("rapid", "vctrs_vctr")
