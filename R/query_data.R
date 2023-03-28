#' @import RODBC
#' @import odbc

#' @export
test_connection <- function(dbname, port, user, password){
  con <- DBI::dbCanConnect(RPostgres::Postgres(),
                      dbname = dbname,
                      port = port,
                      user = user, 
                      password = password)
  if (!con){
    stop("Cannot connect to database")
  }
}

#' @export
connect <- function(dbname, port, user, password){
  con = DBI::dbConnect(RPostgres::Postgres(),
                  dbname = dbname,
                  port = port,
                  user = user, 
                  password = password)
  return(con)  
}

#' @export
query <- function(con,sql){
  result <- DBI::dbSendQuery(con, sql)
  data <- DBI::dbFetch(result, n = -1)
  DBI::dbClearResult(result)
  return(data)  
}
