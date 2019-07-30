setwd("C:/Users/dap/Desktop/R Git/r_jooble")
options(scipen = 999, digits = 22)
options(stringsAsFactors = FALSE)
library(mssqlR)
library(RMySQL)
library(plyr)
library(dplyr)
library(readr)
library(purrr)
library(jsonlite)
#library(reshape2)

credentials <- read.table("C:/Users/dap/Desktop/R Git/r-jobs/credentials.csv", header = TRUE, sep = ",", stringsAsFactors = !default.stringsAsFactors())
credentials_ms_sql <- credentials[credentials$server == "nl2.jooble.com",]
credentials_my_sql <- credentials[credentials$server == "185.233.117.208",]
con_ms_sql <- connect_db(credentials_ms_sql$server,credentials_ms_sql$db,credentials_ms_sql$uid,credentials_ms_sql$pwd)
con_my_sql <- dbConnect(RMySQL::MySQL(), host = credentials_my_sql$server, user = credentials_my_sql$uid, password = credentials_my_sql$pwd)

#sql_read <- read_file("00 Read account_build_cv.sql")
# Загружаю в файл поле json cv
tx <- paste("[",paste(readLines("C:/Users/dap/Desktop/json cv from account_cv.txt"), collapse=","),"]")
writeLines(tx, con="C:/Users/dap/Desktop/tx.txt")
# Удаляю название поля json и странный символ между скобками и текстом
con <- file("C:/Users/dap/Desktop/tx.txt",blocking = FALSE)
json_data <- fromJSON(con, simplifyDataFrame = TRUE, flatten = TRUE)

summary(json_data)
