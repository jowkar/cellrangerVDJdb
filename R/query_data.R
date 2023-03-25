library(RODBC)
library(odbc)
library(RPostgres)

test_connection <- function(dbname, port, user, password){
  con <- dbCanConnect(RPostgres::Postgres(),
                      dbname = dbname,
                      port = port,
                      user = user, 
                      password = password)
  if (!con){
    stop("Cannot connect to database")
  }
}

connect <- function(dbname, port, user, password){
  con = dbConnect(RPostgres::Postgres(),
                  dbname = dbname,
                  port = port,
                  user = user, 
                  password = password)
  return(con)  
}

query <- function(con,sql){
  result <- dbSendQuery(con, sql)
  data <- dbFetch(result, n = -1)
  dbClearResult(result)
  return(data)  
}
