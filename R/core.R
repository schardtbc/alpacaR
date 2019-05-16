

#' get request to alpaca trading api (base url)
#' @param endpoint the api endpoint
#' @export
alpacaGet <- function(endpoint) {
  url <- paste0(get_base_url(),"/",get_api_version(),"/",endpoint)
  credentials <- get_credentials();
  res <- httr::GET(url,httr::add_headers(`APCA-API-KEY-ID` = credentials$key_id,`APCA-API-SECRET-KEY` = credentials$secret_key))
}

#' post request to alpaca trading api (base url) used to submit orders
#' @param endpoint the api endpoint
#' @param body order information
#' @export
alpacaPost <- function(endpoint, body) {
  url <- paste0(get_base_url(),"/",get_api_version(),"/",endpoint)

  credentials <- get_credentials();
  res <- httr::POST(url,httr::add_headers(`APCA-API-KEY-ID` = credentials$key_id,
                                          `APCA-API-SECRET-KEY` = credentials$secret_key,
                                          `content-type` = 'application/json'),
                                          body = body, encode = "json")
}

#' delete request to alpaca trading api (base url) used to cancel orders
#' @param endpoint api endpoint
#' @export
alpacaDelete <- function(endpoint) {
  url <- paste0(get_base_url(),"/",get_api_version(),"/",endpoint)

  credentials <- get_credentials();
  res <- httr::DELETE(url,httr::add_headers(`APCA-API-KEY-ID` = credentials$key_id,`APCA-API-SECRET-KEY` = credentials$secret_key))
}
