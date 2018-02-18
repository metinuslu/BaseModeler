

# Clean the System Variable -----------------------------------------------

rm(list=ls())
cat("\014")


# Set the Path and others... ----------------------------------------------

path <- dirname(parent.frame(2)$ofile) # frame(3) also works.
setwd(path)

if (file.exists("output")==FALSE){
  dir.create("output")
}

# path <- setwd("../BaseModeler") # Please choose the BaseModeler Folder
# path <- setwd(choose.dir())

# if (require(here) == FALSE) {
#   install.packages("here")
#   library(here)
# }
# here()

cat(" One Sample Statistics & Detection Of Outlier Values", "\n",
    "Time of System","\t",":", format(Sys.time(), "%d %b %Y - %H:%M:%S"),"\n",
    "System Path","\t\t",":",Sys.getenv("R_USER"),"\n",
    "Directory Path","\t",":", paste0(getwd(),"/"),"\n",
    "Input Path","\t\t",":", paste0(getwd(),"/input/"),"\n",
    "Output Path","\t\t",":", paste0(getwd(),"/output/"),"\n\n"
)

source(paste0(path,"/DataLoad.R"))

ch1 <- "1- Basic Statistics"
ch2 <- "2- Normality Test"
ch3 <- "3- QQ Plot"
ch4 <- "4- Box - Whisker Plot"
ch5 <- "5- Outlier Detection Model: J. Tukey" 
ch6 <- "6- Modified Thompson Tau"
ch7 <- "7- Exit"

cat("",ch1,"\n",
    ch2,"\n",
    ch3,"\n",
    ch4,"\n",
    ch5,"\n",
    ch6,"\n",
    ch7,"\n\n"
)

ch <- readline(prompt = "Your Choose: 1/2/3/4/5/6/7: ") # ch2 <- as.integer(ch2)

ts <- as.integer(Sys.time())

# Measures of Skewness and Kurtosis
if (require(moments) == FALSE) {
  install.packages("moments")
  library(moments)
}

# summary(data)
MinD  <- summary(data)[[1]]
Q1    <- summary(data)[[2]]
Q2    <- summary(data)[[3]]
MeanD <- summary(data)[[4]]
TMeanD<- mean(sort(data), trim = 0.5)
Q3    <- summary(data)[[5]]
MaxD  <- summary(data)[[6]]
Skew  <- skewness(data)
Kurt  <- kurtosis(data)
SumD  <- sum(data)
StdD  <- sd(data)
StdE  <- sd(data)/sqrt(length(data))  #computation of the standard error of the mean
CountD   <- length(data)
ConfIntD <- c(mean(data) - 2*StdE, mean(data) + 2*StdE) #95% confidence intervals of the mean
ModeD <- names(table(data))[table(data)==max(table(data))]

FreqMax <- "soon"
FreqMin <- "soon"
# sort(data)
# order(data)
# order(-data)


# Basic Statistics ---------------------------------------------------------

if (trimws(ch) =="1") {
  cat("Choose", "\t\t\t",":",ch1,"\n",
      "= = = = = = = = = = = = = = = = = = = = = = =","\n")
  cat(" Mean", "\t\t\t",":",MeanD, "\n",
      "%5 of Trimmed Mean","\t",":",TMeanD, "\n",
      "%95 Confidence Interval of Mean", "\n",
      "Lower Bound", "\t\t",":",ConfIntD[1], "\n",
      "Upper Bound", "\t\t",":",ConfIntD[2], "\n",
      "Median", "\t\t",":",Q2, "\n",
      "Mode", "\t\t\t",":",ModeD, "\n",
      "Minimum", "\t\t",":",MinD, "\n",
      "Maximum", "\t\t",":",MaxD, "\n",
      "Quartile 1", "\t\t",":",Q1, "\n",
      "Quartile 3", "\t\t",":",Q3, "\n",
      "Interquar. Range(IQR)", "\t",":",Q3-Q1, "\n",
      "Skewness", "\t\t",":",Skew, "\n",
      "Kurtosis", "\t\t",":",Kurt, "\n",
      "Sum", "\t\t\t",":",SumD, "\n",
      "Variance", "\t\t",":",StdD*StdD, "\n",
      "Std. Deviation", "\t",":",StdD, "\n",
      "Std. Error", "\t\t",":",StdE, "\n",
      "Count", "\t\t\t",":",CountD, "\n",
      "Range", "\t\t\t",":",MaxD - MinD, "\n",
      "Max. Freq.", "\t\t",":",FreqMax, "\n",
      "Min. Freq.", "\t\t",":",FreqMin, "\n"
  )

  
# Normality Test ---------------------------------------------------------
  
  } else if(trimws(ch)==2) {
  cat("Choose:",ch2,"\n",
      "= = = = = = = = = = = = = =","\n")
  if(CountD>=5000){
    if (require(nortest) == FALSE) {
      install.packages("nortest")
      library(nortest)
    }
    ad.test(data)
    
    cat(" Use the Test Name","\t\t",":",      ad.test(data)$method,"\n",
    "Use the Test Stat. Values","\t",":",  ad.test(data)$statistic[[1]],"\n",
    "Use the Test Stat. P-Value","\t",":", ad.test(data)$p.value[[1]],"\n")
    
    if (ad.test(data)$p.value[[1]]<0.05) {
      cat(" Result:", ad.test(data)$p.value[[1]],"<","0.05","olduğundan Normal Dağılım göstermiyor","\n")
    } else{
      cat(" Result:", ad.test(data)$p.value[[1]],">=","0.05","olduğundan Normal Dağılım gösteriyor","\n")
    }  
      jpeg(filename=paste0(getwd(),"/output/", "Normality_68-95-99_Rules.jpg"))
      plot(seq(-3.2,3.2,length=50),dnorm(seq(-3,3,length=50),0,1),type="l",xlab="",ylab="",ylim=c(0,0.5))
      
      segments(x0 = c(-3,3),y0 = c(-1,-1),x1 = c(-3,3),y1=c(1,1))
      text(x=0,y=0.45,labels = expression("99.7% of the data within 3" ~ sigma))
      arrows(x0=c(-2,2),y0=c(0.45,0.45),x1=c(-3,3),y1=c(0.45,0.45))
      
      segments(x0 = c(-2,2),y0 = c(-1,-1),x1 = c(-2,2),y1=c(0.4,0.4))
      text(x=0,y=0.3,labels = expression("95% of the data within 2" ~ sigma))
      arrows(x0=c(-1.5,1.5),y0=c(0.3,0.3),x1=c(-2,2),y1=c(0.3,0.3))
      
      segments(x0 = c(-1,1),y0 = c(-1,-1),x1 = c(-1,1),y1=c(0.25,0.25))
      text(x=0,y=0.15,labels = expression("68% of the data within 1" * sigma),cex=0.9)
      
      dev.off()# make plot
      
      cat("\n","Normal Distribution","68 - 95 - 99.7 Rules","\n",
          "Mean ± StdDeviation",   "  %68","\t",":",MeanD-StdD,  "between", MeanD+StdD,"\n",
          "Mean ± 2*StdDeviation", "%95","\t",":", MeanD-2*StdD, "between", MeanD+2*StdD,"\n",
          "Mean ± 3*StdDeviation", "%99.7","\t",":",    MeanD-3*StdD,    "between", MeanD+3*StdD,"\n\n"
      )
      fpath <- paste0(getwd(),"/output/", "Normality_68-95-99_Rules.jpg")
      cat("Output File",":",fpath)
      
  } else {
    shapiro.test(data)
    
    cat(" Use the Test Name","\t\t",":",      shapiro.test(data)$method,"\n",
        "Use the Test Stat. Values","\t",":",  shapiro.test(data)$statistic[[1]],"\n",
        "Use the Test Stat. P-Value","\t",":", shapiro.test(data)$p.value[[1]],"\n")
    
    
    if (shapiro.test(data)$p.value[[1]]<0.05) {
      cat(" Result:", shapiro.test(data)$p.value[[1]],"<","0.05","olduğundan Normal Dağılım göstermiyor\n")
    } else{
      cat(" Result:", shapiro.test(data)$p.value[[1]],">=","0.05","olduğundan Normal Dağılım gösteriyor","\n")
    }  
      
      jpeg(filename=paste0(getwd(),"/output/", "Normality_68-95-99_Rules.png"))
      plot(seq(-3.2,3.2,length=50),dnorm(seq(-3,3,length=50),0,1),type="l",xlab="",ylab="",ylim=c(0,0.5))
      
      segments(x0 = c(-3,3),y0 = c(-1,-1),x1 = c(-3,3),y1=c(1,1))
      text(x=0,y=0.45,labels = expression("99.7% of the data within 3" ~ sigma))
      arrows(x0=c(-2,2),y0=c(0.45,0.45),x1=c(-3,3),y1=c(0.45,0.45))
      
      segments(x0 = c(-2,2),y0 = c(-1,-1),x1 = c(-2,2),y1=c(0.4,0.4))
      text(x=0,y=0.3,labels = expression("95% of the data within 2" ~ sigma))
      arrows(x0=c(-1.5,1.5),y0=c(0.3,0.3),x1=c(-2,2),y1=c(0.3,0.3))
      
      segments(x0 = c(-1,1),y0 = c(-1,-1),x1 = c(-1,1),y1=c(0.25,0.25))
      text(x=0,y=0.15,labels = expression("68% of the data within 1" * sigma),cex=0.9)
      
      dev.off()# make plot
      
      cat("\n","Normal Distribution","68 - 95 - 99.7 Rules","\n",
          "Mean ± StdDeviation",   "  %68","\t",":",MeanD-StdD,  "between", MeanD+StdD,"\n",
          "Mean ± 2*StdDeviation", "%95","\t",":", MeanD-2*StdD, "between", MeanD+2*StdD,"\n",
          "Mean ± 3*StdDeviation", "%99.7","\t",":",    MeanD-3*StdD,    "between", MeanD+3*StdD,"\n\n"
          )
      fpath <- paste0(getwd(),"/output/", "Normality_68-95-99_Rules.jpg")
      cat("Output File",":",fpath)

  }

    
# QQ Plot -----------------------------------------------------------------

} else if(trimws(ch)=="3") {
  cat("Choose:",ch3,"\n",
      "= = = = = = = = = =","\n")
  
  fname <- paste0(getwd(),"/output/", "QQPlot_",ts,".jpg")
  jpeg(filename=fname)
  qqnorm(data)
  qqline(data, col="green")
  dev.off()# make plot
  
  cat("Output File",":", fname)
  
# Box - Whisker Plot ------------------------------------------------------

} else if(trimws(ch)=="4") {
  cat("Choose:",ch4,"\n",
      "= = = = = = = = = = = = = = = =","\n")
  
  fname1 <- paste0(getwd(),"/output/", "BoxWhiskerPlot_",ts,".jpg")
  jpeg(filename=fname1)
  
  boxplot(data,
          main = "Counts of 2016-2017",
          xlab = "",
          ylab = "",
          col = "red",
          border = "blue",
          horizontal = TRUE)
  outlier_values <- boxplot.stats(data)$out
  dev.off()# make plot
  cat("Output File",":", fname1,"\n")
  fname2 <- paste0(path,"/output/","BoxWhiskerPlot_OutlierValues_",ts,".csv")
  write.csv(outlier_values ,
            file = fname2,
            row.names=FALSE)
  cat("Output File",":", fname2)

# Outlier Detection Model: J. Tukey ---------------------------------------

  
} else if(trimws(ch)=="5") {
  cat("Choose:",ch5,"\n",
      "= = = = = = = = = = = = = = = =","\n")
  
  # Setting the Outlier and Extreme Values
  # k: 1,5 # Outlier Values
  # k: 3   # Extreme Values
  # Q1 - k*IQR(data) OR Q1 - k*(Q3-Q1)
  # Q3 + k*IQR(data) OR Q3 + k*(Q3-Q1)
  
  # Outlier Values
  # Q1 - 1.5*IQR(data) OR Q1 - 1.5*(Q3-Q1)
  # Q3 + 1.5*IQR(data) OR Q3 + 1.5*(Q3-Q1)
  
  # Extreme Values
  # Q1 - 3*IQR(data) OR Q1 - 3*(Q3-Q1)
  # Q3 + 3*IQR(data) OR Q3 + 3*(Q3-Q1)
  
  Down <- Q1 - 1.5*IQR(data)
  Up   <- Q3 + 1.5*IQR(data)
  
  ExValue_Down <- Q1 - 3*IQR(data)
  ExValue_Up   <- Q3 + 3*IQR(data)
  
  data1 <- data[data<=Up & data>=Down]
  data1_outlier1 <- data[data>Up | data<Down]
  data1_outlier2 <- data[data>ExValue_Up | data<ExValue_Down]
  cat("Down Value Compute Formula", "\t",":","Q1 - 1.5*IQR(data) OR Q1 - 1.5*(Q3-Q1)","\n")
  cat("Up Value Compute Formula","\t",":","Q3 + 1.5*IQR(data) OR Q3 + 1.5*(Q3-Q1)","\n")
  cat("Outlier Down Value & Up Value","\t",":",Down,"&",Up,"\n","\n")

  cat("Extreme Down Value Compute Formula", "\t",":","Q1 - 3*IQR(data) OR Q1 - 3*(Q3-Q1)","\n")
  cat("Extreme Up Value Compute Formula","\t",":","Q3 + 3*IQR(data) OR Q3 + 3*(Q3-Q1)","\n")
  cat("Extreme Down & Up Value","\t\t",":",ExValue_Down,"&",ExValue_Up,"\n\n")
  
  
  fname1 <- paste0(path,"/output/","/Data1_OutlierValues1_",ts,".csv")
  fname2 <- paste0(path,"/output/","/Data1_ExtOutlierValues2_",ts,".csv")
  write.csv(data1_outlier1, file = fname1, row.names=FALSE)
  write.csv(data1_outlier2, file = fname2, row.names=FALSE)
  cat("Output File",":", fname1,"\n")
  cat("Output File",":", fname2)
  
} else if(trimws(ch)=="6") {
  cat("Choose:",ch6,"\n",
      "= = = = = = = = = = = = = = = = = =","\n")
  n <- CountD
  alpha <- 0.05
  t <- qt(1-alpha/2, df=n-2)
  tau <- (t*(n-1))/((sqrt(n)*sqrt(n-2+t*t)))
  # a <- t.test(data)
  k <- tau * StdD
  cat("Modified Thompson Tau Eşik Değeri: ",k,"\n\n")
  data[data>k]
  data2_outlier1 <- data[data>k]
  
  fname <- paste0(path,"/output/","Data2_ModifiedThompsonTauTest_OutlierValues1_",ts,".csv")
  write.csv(data2_outlier1, file = fname, row.names=FALSE)
  cat("Output File",":", fname)
} else{
  print("Sistemden 3 sn. sonra çıkılıyor", Sys.sleep(3),q())
}


# if ( test_expression1) {
#   statement1
# } else if ( test_expression2) {
#   statement2
# } else if ( test_expression3) {
#   statement3
# } else
#   statement4

# chdir
# echo %cd%
# shell.exec("cmd")

# qt(1-alpha/2, df=n-1)

# Sys.getenv()
# Sys.getenv("COMPUTERNAME")
# Sys.setenv(COMPUTERNAME="QWERTY-12345")
# Sys.getpid()
#If you call Sys.setlocale with "LC_CTYPE" or "LC_ALL" to change the system locale 


# install.packages("psych") describe(data)
# library(psych)
# describe(data)[6]
# encoding = "utf-8"
# Sys.setlocale("LC_CTYPE", "russian")
# %a Per?embe
# path <- setwd(choose.dir())

# logging https://cran.r-project.org/web/packages/logging/logging.pdf

# https://www.r-bloggers.com/standard-deviation-vs-standard-error/