##############################################################################
import_data <- function(dataset){
	 data_ <- read.csv(paste("data/", dataset, ".txt", sep = ""),
	                   sep = ",", dec = ".", header = TRUE)
	 data_$Date <- as.Date(as.character(data_$Date), "%Y%m%d")
	 data_<-data_[, c(2, 6)]
	 names(data_)[2] <- dataset
	 return(data_)
	 }

###############################################################################
testdf <- function(variable, adf_order){
    library(urca)
    library(lmtest)
    results_adf <- data.frame(order = -1, adf = 0,
                              p_adf = "", bgodfrey = 0, p_bg = 0)
	variable <- variable[!is.na(variable)]

	for(order in 0:adf_order){
	    df.test_ <- ur.df(variable, type = c("drift"), lags = order)
		df_ <- df.test_@teststat[1]
		df_crit <- df.test_@cval[1, ]
		df_crit <- (df_ < df_crit) * 1
		p_adf <- ifelse (sum(df_crit) == 0,
		                 ">10pct",
		                 paste("<", names(df_crit)[min(which(df_crit == 1))],
		                       sep = ""))
		resids_ <- df.test_@testreg$residuals
		bgtest_ <- bgtest(resids_ ~ 1, order = 1)
		bgodfrey <- bgtest_$statistic
		names(bgodfrey)<-NULL
		p_bg <- bgtest_$p.value

		results_adf <- rbind(results_adf,
		                     data.frame(order = order,
		                                adf = df_,
		                                p_adf = p_adf,
		                                bgodfrey = bgodfrey,
		                                p_bg = p_bg)
		                     )
		}

	results_adf<-results_adf[results_adf$order>=0,]


	return(results_adf)
}
