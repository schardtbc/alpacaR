
#' constructor for condition object
#'
#' @export
condition <- function(subclass, message, call = sys.call(-1), ...) {
  structure(
    class = c(subclass,"condition"),
    list(message = message, call = call, ...)
  )
}

#' error condition for a missing envronment key
#'
#' @export
missing_env_key <- function(text){
  msg <- paste0("Missing required key in .env ; ", text)
  condition(c("missing_env_key_error","error"), message, text=text)
}


#' return first argument that is not null
#'
#' @export
coalesce <- function(a,b,...) {
if (!is.null(a)){
  return(a)
}
if (missing(b)){
  return (NULL)
}
coalesce(b,...)
}

readRenviron(".env")
environ<-Sys.getenv();

#' @export
get_base_url<-function(){
  coalesce(environ[['APCA_API_BASE_URL']], 'https://api.alpaca.markets')
}

#' @export
get_data_url<- function (){
  coalesce(environ[['APCA_API_DATA_URL']], 'https://data.alpaca.markets')
}


#' @export
get_credentials <- function (key_id=NULL, secret_key=NULL){
  key_id = coalesce(key_id, environ[['APCA_API_KEY_ID']])
if (is.null(key_id)) {
  stop(missing_env_key('Key ID must be given to access Alpaca trade API'))
}
secret_key = coalesce(secret_key,environ[['APCA_API_SECRET_KEY']])
if (is.null(secret_key)){
  stop(missing_env_key('Secret Key ID must be given to access Alpaca trade API'))
}
return (list(key_id = key_id, secret_key = secret_key))
}

#' @export
get_api_version<- function(api_version=NULL){
  coalesce(api_version,environ[['APCA_API_VERSION']],"v1")
}

#' get request to alpaca trading api (base url)
#'
#' @export
alpacaGet <- function(endpoint) {
  url <- paste0(get_base_url(),"/",get_api_version(),"/",endpoint)
  credentials <- get_credentials();
  res <- httr::GET(url,httr::add_headers(`APCA-API-KEY-ID` = credentials$key_id,`APCA-API-SECRET-KEY` = credentials$secret_key))
}

#' post request to alpaca trading api (base url) used to submit orders
#' @export
alpacaPost <- function(endpoint, body) {
  url <- paste0(get_base_url(),"/",get_api_version(),"/",endpoint)
  show(url)
  credentials <- get_credentials();
  res <- httr::POST(url,httr::add_headers(`APCA-API-KEY-ID` = credentials$key_id,
                                          `APCA-API-SECRET-KEY` = credentials$secret_key,
                                          `content-type` = 'application/json'),
                                          body = body, encode = "json")
}

#' delete request to alpaca trading api (base url) used to cancel orders
#' @export
alpacaDelete <- function(endpoint) {
  url <- paste0(get_base_url(),"/",get_api_version(),"/",endpoint)
  show(url)
  credentials <- get_credentials();
  res <- httr::DELETE(url,httr::add_headers(`APCA-API-KEY-ID` = credentials$key_id,`APCA-API-SECRET-KEY` = credentials$secret_key))
}
