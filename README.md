# BaseModeler
BaseModeler is Basic Statistics, Normality Test, QQ Plot & Box-Whisker Plot, Outlier Methods (Outlier Detection Model: "J. Tukey, Modified Thompson Tau)

- One Sample Statistics & Detection Of Outlier Values
- Time of System	: 06 Şub 2018 - 11:29:49
- System Path		: C:/Users/Test/Documents
- Directory Path	: H:/Google Drive/Books/Analysis/BaseModeler/
- Input Path		: H:/Google Drive/Books/Analysis/BaseModeler/input/
- Output Path		: H:/Google Drive/Books/Analysis/BaseModeler/output/

## 1- Basic Statistics
- Mean 			 	: 2.914866 
- %5 of Trimmed Mean 		 : 1 
- %95 Confidence Interval of Mean 
	- Lower Bound 		 : 2.798814 
	- Upper Bound 		 : 3.030917 
- Median 			 : 1 
- Mode  			 : 1 
- Minimum	 		 : 1 
- Maximum 			 : 490 
- Quartile 1 		 	: 1 
- Quartile 3 		 	: 3 
- Interquar. Range(IQR)  	: 2 
- Skewness	 		: 38.25902 
- Kurtosis 			: 2069.259 
- Sum 			 	: 50981 
- Variance 		 	: 58.8888 
- Std. Deviation 	 	: 7.673904 
- Std. Error 		 	: 0.05802584 
- Count 			: 17490 
- Range				: 489 

			
## 2- Normality Test
### Anderson-Darling test for normality
**Notes:** Data size > 5000 
- Use the Test Name		: Anderson-Darling normality test
- Use the Test Stat. values	: 3733.203
- Use the Test Stat. P-Value	: 3.7e-24
- Result			: 3.7e-24 < 0.05 olduğundan Normal Dağılım göstermiyor
- Output File			: H:/Google Drive/Books/Analysis/BaseModeler/output/Normality_68-95-99_Rules.jpg

### Shapiro-Wilk Normality Test
**Notes:** a numeric vector of data values. Missing values are allowed, but the number of non-missing values must be between 3 and 5000.

- Use the Test Name		: Shapiro-Wilk normality test
- Use the Test Stat. values	: value
- Use the Test Stat. P-Value	: value
- Result			: value
- Output File			: H:/Google Drive/Books/Analysis/BaseModeler/output/Normality_68-95-99_Rules.jpg

#### Normality 68-95-99.7 Rules

![alt text](https://upload.wikimedia.org/wikipedia/commons/8/8c/Standard_deviation_diagram.svg "68-95-99.7 Rules")

 *Normal Distribution 68 - 95 - 99.7 Rules*<br>
 Mean ± 1xStdDeviation %68		: -4.759038 between 10.58877 <br>
 Mean ± 2xStdDeviation %95		: -12.43294 between 18.26267 <br>
 Mean ± 3xStdDeviation %99.7		: -20.10685 between 25.93658 <br>

## 3- QQ Plot
Add to QQ-Plot Graf
- Output File 	: H:/Google Drive/Books/Analysis/BaseModeler/output/QQPlot_1517917312.jpg

## 4- Box - Whisker Plot
Add to Box-Whisker Plot Graf
- Output File : H:/Google Drive/Books/Analysis/BaseModeler/output/BoxWhiskerPlot_1517917333.jpg 
- Output File : H:/Google Drive/Books/Analysis/BaseModeler/output/BoxWhiskerPlot_OutlierValues_1517917333.csv

## 5- Outlier Detection Model: "J. Tukey"

**Outlier and Extreme Values**

k: 1.5 # Outlier Values  
k: 3   # Extreme Values

**Formula**

Q1 - k x IQR(data) OR Q1 - k x (Q3-Q1)<br>
Q3 + k x IQR(data) OR Q3 + k x (Q3-Q1)<br>

**Outlier Values**  

Q1 - 1.5 x IQR(data) OR Q1 - 1.5 x (Q3-Q1)<br>
Q3 + 1.5 x IQR(data) OR Q3 + 1.5 x (Q3-Q1)<br>

**Extreme Values**  

Q1 - 3 x IQR(data) OR Q1 - 3 x (Q3-Q1)<br>
Q3 + 3 x IQR(data) OR Q3 + 3 x (Q3-Q1)<br>


Down Value Compute Formula 	 		: Q1 - 1.5xIQR(data) OR Q1 - 1.5x(Q3-Q1)<br>
Up Value Compute Formula 	 		: Q3 + 1.5xIQR(data) OR Q3 + 1.5x(Q3-Q1)<br>
Outlier Down Value & Up Value 	 	 	: -2 & 6
 
Extreme Down Value Compute Formula		: Q1 - 3xIQR(data) OR Q1 - 3x(Q3-Q1)<br>
Extreme Up Value Compute Formula		: Q3 + 3xIQR(data) OR Q3 + 3x(Q3-Q1)<br> 
Extreme Down & Up Value				: -5 & 9

Down Value Compute Formula			: Q1 - 1.5xIQR(data) OR Q1 - 1.5x(Q3-Q1)<br>
Up Value Compute Formula			: Q3 + 1.5xIQR(data) OR Q3 + 1.5x(Q3-Q1)<br> 
Outlier Down Value & Up Value			: -2 & 6 
 
Extreme Down Value Compute Formula		: Q1 - 3xIQR(data) OR Q1 - 3x(Q3-Q1)<br>
Extreme Up Value Compute Formula		: Q3 + 3xIQR(data) OR Q3 + 3x(Q3-Q1)<br>
Extreme Down & Up Value				: -5 & 9 

Output File : H:/Google Drive/Books/Analysis/BaseModeler/output//Data1_OutlierValues1_1517917363.csv   
Output File : H:/Google Drive/Books/Analysis/BaseModeler/output//Data1_ExtOutlierValues2_1517917363.csv

## 6- Modified Thompson Tau
**Source:** [StatisticsHowTo](http://www.statisticshowto.com/modified-thompson-tau-test/)  
Output File : H:/Google Drive/Books/Analysis/BaseModeler/output/Data2_ModifiedThompsonTauTest_OutlierValues1_1517917447.csv
