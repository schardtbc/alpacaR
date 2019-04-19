alpacaR a package for trading with real-time market data for free
-----------------------------------------------------------------

Who Is Alpaca For?

Alpaca Securities provides brokerage services to technology-minded users
with a variety of experiences including general usage of APIs or
automation of investing and trading. We have users come from two of the
largest quantitative research platforms, Quantopian and QuantConnect.
Others are experienced automated or manual traders coming from
Interactive Brokers, TD Ameritrade, or Robinhood. Some are crypto
traders expanding into equities. Some have no background in trading at
all and are just learning to code. We even receive inquiries from
boutique quant funds (corporate accounts are on our roadmap!). We
welcome them all and seek to provide a platform for anyone, novice or
experienced, to automate their investing and trading.

Alpaca users trade a variety of strategies ranging from passive to
active, long-term to short-term intraday. As a point of reference, we
have some users who execute hundreds of trades worth millions of dollars
a day.

With an Alpaca brokerage account, users have access to:

-   Commission-free trading
-   An official API that is constantly being improved and updated
-   Easy to understand API documentation
-   Free, real-time Consolidated Market Data
-   Paper trading for testing your strategies
-   Fully working, example algorithms that can be deployed immediately
-   Multiple support channels

<!-- -->

    # create a trade object
    aapl <- newTrade("AAPL","buy",50,time_in_force = "day")
    # submit the  trade
    aaplOrder <- submitTrade(aapl)

    ## [1] "https://paper-api.alpaca.markets/v1/orders"

    aaplOrder

    ## $id
    ## [1] "59a4a434-7c93-4cfb-9ee3-8750abdda35e"
    ## 
    ## $client_order_id
    ## [1] "ATO_1555658511.95943_AAPL"
    ## 
    ## $created_at
    ## [1] "2019-04-19T07:21:52.341220513Z"
    ## 
    ## $updated_at
    ## [1] "2019-04-19T07:21:52.347033565Z"
    ## 
    ## $submitted_at
    ## [1] "2019-04-19T07:21:52.33785717Z"
    ## 
    ## $filled_at
    ## NULL
    ## 
    ## $expired_at
    ## NULL
    ## 
    ## $canceled_at
    ## NULL
    ## 
    ## $failed_at
    ## NULL
    ## 
    ## $asset_id
    ## [1] "b0b6dd9d-8b9b-48a9-ba46-b9d54906e415"
    ## 
    ## $symbol
    ## [1] "AAPL"
    ## 
    ## $asset_class
    ## [1] "us_equity"
    ## 
    ## $qty
    ## [1] "50"
    ## 
    ## $filled_qty
    ## [1] "0"
    ## 
    ## $filled_avg_price
    ## NULL
    ## 
    ## $order_type
    ## [1] "market"
    ## 
    ## $type
    ## [1] "market"
    ## 
    ## $side
    ## [1] "buy"
    ## 
    ## $time_in_force
    ## [1] "day"
    ## 
    ## $limit_price
    ## NULL
    ## 
    ## $stop_price
    ## NULL
    ## 
    ## $status
    ## [1] "new"
    ## 
    ## attr(,"class")
    ## [1] "order"

    # cancel the order
    cancelOrder(aaplOrder)

    ## [1] "https://paper-api.alpaca.markets/v1/orders/59a4a434-7c93-4cfb-9ee3-8750abdda35e"
