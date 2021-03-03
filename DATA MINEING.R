library(rvest)
library(stringr)
library(tidyr)


# # WEB SCRAPPING TABLES # # 

## VIX ##########################################################################


VIXurl = 'https://in.investing.com/indices/india-vix-historical-data?end_date=1611468763&st_date=1169663400'
webpageVIX =read_html(VIXurl)

sb_tableVIX = html_nodes(webpageVIX, 'table')
VIX = html_table(sb_tableVIX)[[2]] ##acces the  table on the page
head(VIX)

# View(VIX)


write.csv(VIX, 'VIX.csv')


## NIFTY50 #####################################################################


Niftyurl = 'https://in.investing.com/indices/s-p-cnx-nifty-historical-data?end_date=1611426600&interval_sec=weekly&st_date=1167589800&interval_sec=daily'
webpageNifty =read_html(Niftyurl)

sb_tableNifty = html_nodes(webpageNifty, 'table')
Nifty = html_table(sb_tableNifty)[[2]] ##acces the  table on the page
head(Nifty)

# View(VIX)


write.csv(Nifty, 'Nifty.csv')



## USD INR #######################################################################


FXurl = 'https://in.investing.com/currencies/usd-inr-historical-data?end_date=1611426600&st_date=1167589800'
webpageFX =read_html(FXurl)

sb_tableFX = html_nodes(webpageFX, 'table')
FX = html_table(sb_tableFX)[[2]] ##acces the  table on the page
head(FX)

# View(FX)


write.csv(FX, 'FOREX.csv')


## GSEC BOND Yield ##################################################################

Gurl = 'https://in.investing.com/rates-bonds/india-10-year-bond-yield-historical-data'

webpageG =read_html(Gurl)

sb_tableG = html_nodes(webpageG, 'table')
G = html_table(sb_tableG)[[1]] ##acces the  table on the page
head(G)

View(G)


write.csv(G, 'GSECYIELD10.csv')


## Crude OIL - WTI ##################################################################

Oilurl = 'https://in.investing.com/commodities/crude-oil-historical-data?end_date=1611426600&st_date=1167589800'

webpageOil =read_html(Oilurl)

sb_tableOil = html_nodes(webpageOil, 'table')
Oil = html_table(sb_tableOil)[[2]] ##acces the  table on the page
head(Oil)

View(Oil)


write.csv(Oil, 'CrudeOil.csv')


###########################################


###########################################

###########################################


