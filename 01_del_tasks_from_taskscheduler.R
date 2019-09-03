library(taskscheduleR)
tasks <- taskscheduler_ls()
str(tasks)
tasks$`Next Run Time`

tasks[tasks$Author=="DAP\\dap",]$TaskName
taskscheduler_delete(taskname = "1.R")
