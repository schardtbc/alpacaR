#' get account status
#'
#' @export
account <- function(){
  res <- alpacaGet("account");
  res$content
}

#' get list of orders
#'
#' @param order_id defaults to NULL which returns a list of all orders
#' @export
orders <- function(order_id = NULL){
  if (is.null(order_id)){
    res <-alpacaGet("orders")
  } else {
    res<-alpacaGet(glue::glue("orders/{order_id}"))
  }
  res$content
}

#' create a new Trade object
#'
#' @param symbol a market symbol
#' @param side "buy" | "sell"
#' @param qty  number of shares
#' @param time_in_force "day" | "gtc" | "opg"
#' @param limit_price NULL | limit price for limt and sotp limit type orders
#' @param stop_price NULL | stop price for stop and stop_limit type orders
#' @export
newTrade <- function(symbol,side,qty,time_in_force="day",limit_price=NULL,stop_price=NULL,id=NULL){
  if (is.null(limit_price) && is.null(stop_price)) {
    type <- "market"
  }
  else if (is.null(stop_price)) {
    type <- "limit"
  }
  else if (is.null(limit_price)) {
    type <- "stop"
  }
  else {
    type <- "stop_limit"
  }

  structure(
    class = c("trade"),
    switch(type,
           market = list(symbol = symbol,qty=qty,side=side,type=type,time_in_force=time_in_force,
                         client_order_id=id),
           limit = list(symbol = symbol,qty=qty,side=side,type=type,time_in_force=time_in_force,
                        limit_price = limit_price,
                        client_order_id=id),
           stop = list(symbol = symbol,qty=qty,side=side,type=type,time_in_force=time_in_force,
                       stop_price = stop_price,
                       client_order_id=id),
           stop_limit = list(symbol = symbol,qty=qty,side=side,type=type,time_in_force=time_in_force,
                             limit_price = limit_price,
                             stop_price = stop_price,
                             client_order_id=id)
    )
  )
}

#' submit trade
#' @param trade a trade object
#' @return order object
#' @export
submitTrade <- function(trade){
  if (is.null(trade$client_order_id)){
    id = paste0("ATO_",as.numeric(lubridate::now()),"_",trade$symbol)
    trade$client_order_id <- id;
  }
  res <- alpacaPost("orders",trade)
  structure(
    class = c("order"),
    res$content
  )
}

#' cancel an order
#' @param order an order object
#' @export
cancelOrder <- function(order) {
  id <- order$id
  res <- alpacaDelete(glue::glue("orders/{id}"))
  res$content
}

#' return list of postions
#' @param symbol | NULL
#' @export
positions <- function(symbol = NULL){
  if (is.null(symbol)){
    res<-alpacaGet("positions")
  } else {
    res<-alpacaGet(glue::glue("positions/{symbol}"))
  }
  res$content
}

#' a sorted list of tradable stocks
#'
#' @param symbol | NULL a market symbol
#' @export
assets <- function(symbol = NULL){
  if (is.null(symbol)){
    res<-alpacaGet("assets")
  } else {
    res<-alpacaGet(glue::glue("assets/{symbol}"))
  }
  d0 <- res$content;
  d1 <- lapply(d0,function(x) {lapply(x,function(y) {ifelse(is.null(y),NA,y)})})
  tibble::as_tibble(do.call(rbind,d1)) %>% tidyr::unnest()  %>%
    dplyr::filter(tradable) %>%
    dplyr::arrange(symbol) %>%
    dplyr::select(-Archives)
}

#' market calendar as dataframe
#'
#' @param start date | NULL
#' @param end date | NULL
#' @export
calendar <- function(start = NULL, end=NULL){
  if (is.null(start)){
    res <- alpacaGet("calendar")
  } else {
    res <- alpacaGet(glue::glue("calendar&start={start}&end={end}"))

  }
  data <- res$content;
  tibble::as_tibble(do.call(rbind,data)) %>% tidyr::unnest() %>% dplyr::mutate(ID = row_number())
}

#' market clock
#'
#' @export
clock <- function(){
    res <- alpacaGet("clock")
    res$content;
}

