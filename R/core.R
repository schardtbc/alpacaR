

#' get request to alpaca trading api (base url)
#' @param endpoint the api endpoint
#' @export
alpacaGet <- function(endpoint) {
  url <- paste0(get_base_url(),"/",get_api_version(),"/",endpoint)
  credentials <- get_credentials();
  resp <- httr::GET(url,httr::add_headers(`APCA-API-KEY-ID` = credentials$key_id,`APCA-API-SECRET-KEY` = credentials$secret_key))
  parsed <- list()

  if (httr::http_error(resp)) {
    warning(
      sprintf(
        "ALPACA API request failed [%s]\n%s\n%s\n%s",
        httr::status_code(resp),
        httr::content(resp, "text"),
        "endpoint requested:",
        endpoint
      ),
      call. = FALSE
    )
  } else {

    if (httr::http_type(resp) != "application/json") {
      warning(
        sprintf(
          "ALPACA API did not return json\n%s",
          httr::content(resp, "text")
        ),
        call. = FALSE
      );
      parsed <- list();
    } else {
      parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)
    }
  }

  structure(
    list(
      status = httr::http_error(resp),
      content = parsed,
      endpoint = endpoint,
      response = resp
    ),
    class = "alpaca_api_result"
  )

  }

#' post request to alpaca trading api (base url) used to submit orders
#' @param endpoint the api endpoint
#' @param body order information
#' @export
alpacaPost <- function(endpoint, body) {
  url <- paste0(get_base_url(),"/",get_api_version(),"/",endpoint)

  credentials <- get_credentials();
  resp <- httr::POST(url,httr::add_headers(`APCA-API-KEY-ID` = credentials$key_id,
                                          `APCA-API-SECRET-KEY` = credentials$secret_key,
                                          `content-type` = 'application/json'),
                                          body = body, encode = "json")

  parsed <- list()
  if (httr::http_error(resp)) {
    warning(
      sprintf(
        "ALPACA API request failed [%s]\n%s\n%s\n%s",
        httr::status_code(resp),
        httr::content(resp, "text"),
        "endpoint requested:",
        endpoint
      ),
      call. = FALSE
    )
  } else {

    if (httr::http_type(resp) != "application/json") {
      warning(
        sprintf(
          "ALPACA API did not return json\n%s",
          httr::content(resp, "text")
        ),
        call. = FALSE
      );
      parsed <- list();
    } else {
      parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)
    }
  }

  structure(
    list(
      status = httr::http_error(resp),
      content = parsed,
      endpoint = endpoint,
      response = resp
    ),
    class = "alpaca_api_result"
  )

}

#' delete request to alpaca trading api (base url) used to cancel orders
#' @param endpoint api endpoint
#' @export
#'
alpacaDelete <- function(endpoint) {
  url <- paste0(get_base_url(),"/",get_api_version(),"/",endpoint)

  credentials <- get_credentials();
  res <- httr::DELETE(url,httr::add_headers(`APCA-API-KEY-ID` = credentials$key_id,`APCA-API-SECRET-KEY` = credentials$secret_key))

  parsed <- list()
  if (httr::http_error(resp)) {
    warning(
      sprintf(
        "ALPACA API request failed [%s]\n%s\n%s\n%s",
        httr::status_code(resp),
        httr::content(resp, "text"),
        "endpoint requested:",
        endpoint
      ),
      call. = FALSE
    )
  } else {

    if (httr::http_type(resp) != "application/json") {
      warning(
        sprintf(
          "ALPACA API did not return json\n%s",
          httr::content(resp, "text")
        ),
        call. = FALSE
      );
      parsed <- list();
    } else {
      parsed <- jsonlite::fromJSON(httr::content(resp, "text"), simplifyVector = FALSE)
    }
  }

  structure(
    list(
      status = httr::http_error(resp),
      content = parsed,
      endpoint = endpoint,
      response = resp
    ),
    class = "alpaca_api_result"
  )
}
