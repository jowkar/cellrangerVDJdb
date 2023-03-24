library(RODBC)
library(odbc)
library(RPostgres)

dbname="vdj_t"
port = 5432
user = "postgres"
password = psswd <- .rs.askForPassword("Database Password:")

test_connection <- function(dbnam, port, user, password){
  con <- dbCanConnect(RPostgres::Postgres(),
                      dbname = dbname,
                      port = port,
                      user = user, 
                      password = password)
  if (!con){
    stop("Cannot connect to database")
  }
}

test_connection(dbnam, port, user, password)

con = dbConnect(RPostgres::Postgres(),
                 dbname = dbname,
                 port = port,
                 user = user, 
                 password = password)
con
dbListTables(con)

result <- dbSendQuery(con, "SELECT * FROM airr_rearrangement LIMIT 10")
data <- dbFetch(result, n = -1)
dbClearResult(result)

result2 <- dbSendQuery(con, "SELECT clone_id,sequence FROM airr_rearrangement LIMIT 10")
data <- dbFetch(result2, n = -1)
dbClearResult(result2)

dbDisconnect(con)