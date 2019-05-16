

config <- new.env(parent = emptyenv())

#' returns package configuration
#' @export
getConfig <- function(){
  config
}

#' set the Alpaca API token
#' @param token iex cloud token
#' @export
setKeyId <- function(token){
  config$KeyId <- token;
}

#' retrieve the Alpaca API token
#' @export
getKeyId <- function(){
  config$KeyId;
}

#' set the Alpaca API token
#' @param token iex cloud token
#' @export
setSecretKey <- function(token){
  config$SecretKey <- token;
}

#' retrieve the Alpaca API token
#' @export
getSecretKey <- function(){
  config$SecretKey;
}


.onLoad <- function(libname, pkgname) {
  if (file.exists(".env")){
    readRenviron(".env");
  }
  env<-Sys.getenv();
  apca<- as.list(env[grep("^APCA",names(env))]);
  config$apiVersion <- coalesce(apca$APCA_API_VERSION,"v1")
  config$baseURL <- coalesce(apca$APCA_API_BASE_URL, 'https://api.alpaca.markets')
  config$dataURL <-coalesce(apca$APCA_API_DATA_URL, 'https://data.alpaca.markets')
  key_id = apca$APCA_API_KEY_ID;
  if (is.null(key_id)) {
    warning('APCA_API_KEY_ID in environment file to access Alpaca API')
  }
  secret_key = apca$APCA_API_SECRET_KEY;
  if (is.null(secret_key)){
    warning('APCA_API_SECRET_KEY must be must be provided in environment file to access Apaca API')
  }
  config$KeyId <- key_id
  config$SecretKey <- secret_key
  invisible(config)
}

#' get alpaca base url
#' @export
get_base_url<-function(){
  config$baseURL;
}

#' retrieve the alpaca data url
#' @export
get_data_url<- function (){
  config$dataURL;
}

#' get Alpaca API tokens
#' @export
get_credentials <- function (){
  key_id = config$KeyId;
  if (is.null(key_id)) {
    stop('Key ID must be given to access Alpaca trade API')
  }
  secret_key = config$SecretKey
  if (is.null(secret_key)){
    stop('Secret Key ID must be given to access Alpaca trade API')
  }
  return (list(key_id = key_id, secret_key = secret_key))
}

#' get the Alpaca API version
#' @export
get_api_version<- function(){
  config$apiVersion;
}
