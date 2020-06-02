---
title: "Time Series Analysis"
author: "Jan Dudzik"
date: "6/2/2020"
output: 
  html_document: 
    keep_md: yes
---



# ARIMA model

### 1. Data description
Provided data shows Price Index of goods and services in Poland between years 2000 and 2020. The basic prices value reflects to December of 1999, and is set as a 100, so basically, every record is a mean value of selected month's prices in goods and services divided by mean value of this sector's prices in December 1999, and multiplied by 100.


```r
library(readxl)
prices_data <- read_excel("Szereg_niesezon.xls")

prices= ts(data=prices_data$TOWARYUSLUGI, frequency = 12,             
             start=c(2000,1), end=c(2020,2)) 
```

### 2. Initial plots
![](Report_files/figure-html/unnamed-chunk-2-1.png)<!-- -->![](Report_files/figure-html/unnamed-chunk-2-2.png)<!-- -->

According to initial plots, however this particular time series seems to be non-stationary, the first differences could be. Therefore I will examine that by appropriate test
