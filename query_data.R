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

# Load data
fnames <- Sys.glob("/Users/00105606/proj/cellranger_vdj_db/loading_commands/*.sql")
#loading_command_file <- "/Users/00105606/proj/cellranger_vdj_db/loading_commands/SampleID_9_11june18_load_data.sql"
for (loading_command_file in fnames){
  command <- paste0("PGPASSWORD=",password," /Library/PostgreSQL/15/bin/psql -U ",user," -d ",dbname," < ",loading_command_file)
  print(command)
  system(command)
}

# Query data
query <- function(con,sql){
  result <- dbSendQuery(con, sql)
  data <- dbFetch(result, n = -1)
  dbClearResult(result)
  return(data)  
}

query(con, "SELECT DISTINCT sample_id FROM airr_rearrangement")



dbDisconnect(con)