## NIFTY-Volatility-Prediction
NIFTY Movement Prediction (NOT TIME SERIES FORCATIONG), based on Volumes, Forex movement, GSec movement, Oil change movement, FII and DII movement. 

<p align="center"><img width=100% src=https://user-images.githubusercontent.com/44467789/106869528-0cf06080-66f6-11eb-8c30-0afc08cc8d8a.png> 
                                                              Source: www.umpindex.com


### Objective

To predict the NIFTY change for the day based on the chnage in variables like, NIFTY Volumes, FII & DII flows, crude oil, FX volatility etc. 

<br>

### Approach

- Collect unstructured data
- Web Scraping – Code: https://github.com/RutvijBhutaiya/NIFTY-Movement-Prediction/blob/main/DATA%20MINEING.R
- Data Cleaning and preparation – MS Excel workbook
- Exploratory Data analysis and Feature Selection
- Hypothesis Statement
- Diffrent Studies and explanation
- Result Analysis
- Conclusion

<br>

### Data Mining


### Exploratory Data analysis

In the following study, following are the main features,
- Oil Price movement
- GSEC (Indian Government Bond price movement)
- VIX (Volatility INDEX)
- FII (Foreign Institutional Investors) and DII (DomesticInstitutional Investors) 
- FX (USD INR currency pair movement)
- Nifty Volumes (Buy and Sell of Shares of top 50 companieson NSE) 

For the Nifty daily change, we had belief that there issignificant involvement of Volumes on daily bases. Either direction of Nifty (significantUp or Down) needs to be supported by the high volumes and vise- versa. 

We decided to create two new features based on the volume. 

- Avg2day = Volumes moving average of previous two days,with condition to the lead day. If 2 day Avg is less than lead day 'High' else'Low'
- VolumeTrend = Trend to check BULL, WEAKBULL, BEAR or WEAKBEARmarket condition based on NiftyCHG and Avg2day. VolumeTrend to check howVolumes have an influence on Nifty! 

We also extract data for Nifty PE and create feature namesNifty_Yld. [# Generally, NIFTY Yield is Lower than Gsec bond Yield, StockMarket is overvalued.]



<br>


### Feature Analysis

We did some intresting feature analysis with the help of Tableau. 

#### FII & DII flows and Nifty Change

In the following chart, we have shown theFII (Foreign Institutional Investments) and DII (Domestic InstitutionalInvestments) net flows in quarterly bases since Q1 2008. Green line mentioned in a chart indicatedthe change in Nifty. 

Generally, when FII buys, DII sells and vice versa.  Plus, we can also notice thatwhen FII sells, NIFTY returns are negative and vice versa. Also, we can saythat FIIs have more influence on NIFTY than DIIs. 

However, Q2 2009 there is sharp hick inNIFTY returns because index gave -23.6% in Q1 2009. Also, this time isconsidered as the Global Financial Crisis (GFC) started with real estate crash inthe US. 

Another contradiction noted in Q1 2020,and this event is lockdown lead by COVID19. In next quarter DIIs net purchasewas more than Rs. 72,000 cr, which pulled NIFTY up. And in the following quartersFIIs were back with net positive purchase which let the NIFTY to reach an all timehigh mark.

<br>

<p align="center"><img width=100% src=https://user-images.githubusercontent.com/44467789/107351798-0fd1c380-6af1-11eb-971e-4ab0cfdb4300.png> 

<br>

#### Tree Chart, Day wise change in NIFTY

This is an interesting chart of NIFTY returnsbased on day for selected period. We have noticed that Date 29th ofevery month is registered as the highest return earner of the day, which is alsoone of the highest counts in the selected period. 

Similarly, 24th is the leaseprofit making day if any did intraday trading for the day for long positions. 
<br>

<p align="center"><img width=83% src=https://user-images.githubusercontent.com/44467789/107352465-e1a0b380-6af1-11eb-9aa9-dcbafe4c2132.png> 

<br>

#### Forex (USD:INR) Change with FII and NIFTY

In the following chart we tried to presentthe relationship between Forex change and FII flows. Because, when INRappreciates, means risk-free returns for the FIIs and vice versa. For e.g.here, INR appreciates mean INR 70 -> INR 65 with respect to USD. 

Now, as we see Year 2011, INR depreciatedby 22.62% and FII flows were also net negative following with negative returnson NIFTY. 

In macroeconomics, Investors arecomfortable with INR depreciation as we can notice 2012, 2014, 2019, 2020.These years also had low volatility in FX change compared to 2013, 2015 and2017. Hence, high change in FX rate either way is not a concern for foreigninvestors, on the other hand, steady change / small directional change can bemore comfortable for foreign investors to take strategic positions.

<br>
<p align="center"><img width=100% src=https://user-images.githubusercontent.com/44467789/107352533-f67d4700-6af1-11eb-8d04-831b86a0408a.png> 
<br>

#### Rank Chart

Following rank chart indicatesrank (% wise returns ) on NIFTY, Oil, Gsec bond and Currency. 

Here, NIFTY (Green Line) and GsecBond (Light Green Line) higher rank means positive portfolio returns. Gsec Bondgenerally considered as Risk free rate of return and Banks Fixed Deposit ratesoften correlated to it. 

For FX (Yellow Line) and Oil (RedLine) - except Year 2017 – has seen negative correlation. This is considered normal, because as Oil prices increase (India’s major Import item) FX comesunder stress, and this leads to outflow of high USD. And outflow of USD makes the INR weak. 

<br>
<p align="center"><img width=100% src=https://user-images.githubusercontent.com/44467789/107352578-05fc9000-6af2-11eb-99f4-becdbf7a0d1d.png> 

<br>


### Hypothesis Statement

Null Hypothesis: Nifty Movement is based on Macro economic factors like, Oil, FX, FII etc.

Alternate Hypothesis: Nifty Movement is based on technical factors, like news, trading pattern etc. 

<br>


### Model Building

#### Data for daily observation is from 4 March 2008 to 22 Jan 2021. 

As we mentioned earlier, this study is not based on Time Series prediction.And hence, we randomly create two data sets 1. Train and 2. Validation
  
In this study we performed Five different studies, All the studies wereon same dataset, However, following are the performances on the different studies,
  
Study 1 to 4 is on the same dataset and frequency is daily, and for Study 5data frequency is monthly. 
  
 - Study 1: We did this study with REMOVE Multicollinearity variables only and no change in outliers ornormalization.
 - Study 2: Same dataset from Study 1, However, we did Next Day Impact onNifty Chg : As many events get impacted on Next day Chg
 - Study 3: In this Study we didn’t remove any multicollinearity or normalizingor outliers etc. Basically, this study was based on raw data. 
 - Study 4: In this study, we Removed Multicollinearity, we did normalizationof features, and also removed Outliers from the data
 - Study 5: This study is on a separate dataset, the data is based on monthlyfrequency. 
  
For model building we use Linear Regression, as our dependent variableis continuous numeric value. And for performance measurement we used RMSE,RSquared and MAE matrices.
  
Purpose to conducting these different studies was to see the difference inresults. Theories say, we should always remove the outliers, there should beno multicollinearity etc. But, in these separate studies, we’ll get to knowwhich method is good for better results. 
  
#### Data for monthlyobservation is from April 2008 to Jan 2021.
  
In macroeconomic context, change in the macro environment would not impactwithin days, and hence, to check that we also did study based on nifty andother independent variables on monthly patterns.
  
Time frame for the Data: daily and monthly observations are similar. Of Courseobservation for daily is around 30 times more than monthly datasetobservations.
On the Monthly dataset we use Linear Regression. In this study we add onemore feature, Gold! 

<br>
  
## Results Analysis

<br>
  
<p align="center"><img width=80% src=https://user-images.githubusercontent.com/44467789/120278093-7a8e5100-c2d2-11eb-9514-01551c50b486.png>
  
<br>
  
As we can see in the results table,
  
Best performing model is from Study 3, However, we consider Study 2model is the least accurate predictor model for the Nifty [This is surprising!]
  
  - Study 1, where we removed multicollinearity from the data has givendecent performance. Where, RSquared is 56% and RMSE is 0.8% 
  
  - Study 2, surprisingly, this model is not working, where we modified theNifty Change with respect to next day change. That means, change (volatility)in other features such as, FX, Oil etc, should impact on Nifty volatility onnext day. But this is not correct and models failed to perform. 
  
  - Study 3, is the best performing model out of all studies we performed. Modesare built on raw data. However, RMSE is 0.73%, and we are still not convinced withthis performance. Generally, in a day nifty moves in the range bond fashion 0.1- 0.5 % up or down. And that is where our model fails with RMSE of 0.73%.  To implement this model in the live market weneed at max 0.2-0.3% of RMSE and not more than that. 
  
 However, we did study this model based on a new dataset from 1stFeb, 2021 to 21st May 2021. 
  - RMSE: 0.012515
  - RSquared: 0.7626
  - MAE: 0.008855
  
  <p align="center"><img width=70% src=https://user-images.githubusercontent.com/44467789/120278386-d6f17080-c2d2-11eb-9490-d061172d08c8.png>
  
 
  - Study 4, is okay, based on normalization and data also do not includeextreme outliers.  
    
  - Study 5, is based on monthly frequency. Many times macro information couldnot reflect on daily bases, but can be seen on monthly basis. Interesting thing about Study 5 compared to all studies is thatRMSE of 5.5% is normal, as nifty volatility on monthly frequency is normal inthis range.   

<br>


  

