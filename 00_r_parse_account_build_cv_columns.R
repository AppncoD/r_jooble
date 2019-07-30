setwd("C:/Users/dap/Desktop/R Git/r_jooble")
options(scipen = 999, digits = 22)
options(stringsAsFactors = FALSE)
library(mssqlR)
library(RMySQL)
library(plyr)
library(dplyr)
library(readr)
library(purrr)

credentials <- read.table("C:/Users/dap/Desktop/R Git/r-jobs/credentials.csv", header = TRUE, sep = ",", stringsAsFactors = !default.stringsAsFactors())
credentials_ms_sql <- credentials[credentials$server == "nl2.jooble.com",]
credentials_my_sql <- credentials[credentials$server == "185.233.117.208",]
con_ms_sql <- connect_db(credentials_ms_sql$server,credentials_ms_sql$db,credentials_ms_sql$uid,credentials_ms_sql$pwd)
con_my_sql <- dbConnect(RMySQL::MySQL(), host = credentials_my_sql$server, user = credentials_my_sql$uid, password = credentials_my_sql$pwd)

sql_read <- read_file("00 Read account_build_cv.sql")
#sql_data <- read.table("00 Read output.csv", header = TRUE, sep = ",", stringsAsFactors = !default.stringsAsFactors())

#sql_data <- paste("[",paste(exec(sql_read, con_ms_sql), collapse = ", "),"]")
#write(sql_data,file = "00 Read output.txt")

#tx  <- readLines("C:/Users/dap/Desktop/json cvs.txt", encoding = "UTF-8")
#tx2  <- gsub(pattern = "\n", replace = ", ", x = tx)
#tx3 <- paste(tx,collapse = ', ')
#writeLines(tx2, con="C:/Users/dap/Desktop/json cvs1.txt")
#writeLines(tx3, con="C:/Users/dap/Desktop/json cvs3.txt")

#document <- fromJSON("C:/Users/dap/Desktop/json cvs3.txt", flatten = TRUE)
tx <- paste("[",paste(readLines("C:/Users/dap/Desktop/json cv from account_cv.txt"), collapse=","),"]")
writeLines(tx, con="C:/Users/dap/Desktop/tx.txt")
con <- file("C:/Users/dap/Desktop/tx.txt",blocking = FALSE)
json_data <- fromJSON(con, simplifyDataFrame = TRUE, flatten = TRUE)

#json_data <- fromJSON("C:/Users/dap/Desktop/json cvs1.txt", simplifyDataFrame = TRUE, )


df <- data.frame(matrix(unlist(json_data), nrow=length(json_data), bycolumn = T))
tall <- reshape2::melt(json_data)[, c("name", "location", "contacts.phone", "contacts.email", "expirience.id", "expirience.idEditing","expirience.term", "expirience.termMonth", "expirience.caption", "")]

#install.packages('jsonlite')
library(jsonlite)
json_1 <- paste("[",toString(sql_data$json[1]),", ", toString(sql_data$json[2]),"]"  )
document <- fromJSON(json_1, flatten = TRUE)
typeof(json_data)
