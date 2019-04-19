#' alpacaR a wrapper for the alpaca trading api
#'
#' ##What is Alpaca?
#'
#' Alpaca is an online brokerage with a published, official REST API which is targeting the
#' algorithmic trader. Alpaca API lets you build and trade with real-time market data for free.
#' In their words they provide a portal for you to Hack Financial Systems.
#'
#' - [Introduction](https://alpaca.markets/)
#' - [Signup](https://app.alpaca.markets/signup)
#' - [Api Documentation](https://docs.alpaca.markets/api-documentation/web-api/)
#'
#' This is functional wrapper which returns data as tibbles, with a few exceptions.
#' See the package documentation for call signitures, parameter descriptions.
#'
#' ## Security Tokens
#'
#' During registration at alpaca.markets you were given security tokens required to access this API.
#' This wrapper will read those tokens from the .env file. The .env file must include the
#' following three key pairs: note(put .env in your .gitignore file)
#'
#' ```
#' APCA-API-KEY-ID = "..."
#' APCA-API-SECRET-KEY = "..."
#' ```
#'
#' @docType package
#' @name alpacaR
#' @author Bruce C. Schardt, \email{schardt.bruce.curtis@@gmail.com}
NULL
