
if (require(readxl) == FALSE) {
  install.packages("readxl")
  library(readxl)
}

DataSource <- read_excel(paste0(path,"/input/DataSource.xlsx"), 
                     sheet = "Sheet1", 
                     col_types = c("numeric"))
data <- DataSource$Count

# Add to other Format (csv, txt, json)
