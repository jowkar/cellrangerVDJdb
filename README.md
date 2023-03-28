# cellrangerVDJdb
Database and R interface to load and query assembled VDJ sequences from CellRanger. Currently supports loading data from CellRanger multi output for T cell receptors, expecting the output to be in a directory named as "multi/\_\_s\_\_/outs/per_sample_outs/\_\_s\_\_/vdj_t/", where \_\_s\_\_ represents a sample name. Other directory structures may be specified, and would work as long as the correct files are to be found there. The expected CellRanger output files are:

- airr_rearrangement.tsv
- cell_barcodes.json
- clonotypes.csv
- consensus_annotations.csv
- filtered_contig_annotations.csv

An ER diagram describing the created database structure can be found here: [ER diagram](images/ERD.pdf)

# Usage

It is a requirement that PostgreSQL is already setup and running and that an empty database has been setup. 

First, run the vdj_t.sql script to setup all tables (in bash terminal; modify according to user settings. "vdj_t" is the name of the empty database expected to be created in PostgreSQL beforehand. The name is up to the user):
```sh
psql -U postgres -d vdj_t < /path/to/vdj_t.sql
```

Then, in R, specify database connection information (example settings; modify accordingly):
```r
dbname = "vdj_t"
port = 5432
user = "postgres"
password <- .rs.askForPassword("Database Password:")
```

Load data into the database (sname represent a sample name):
```r
library(cellrangerVDJdb)

load_from_cellranger_vdj_t(
    sname = sname, 
    resultsdir = "/path/to/10x/results/",
    cellranger_dir_structure = paste0("multi/", "__s__", 
                                      "/outs/per_sample_outs/", "__s__", 
                                      "/vdj_t/"), 
    outdir = "loading_commands",
    dbname = dbname, 
    user = user, 
    password = password, 
    psql_path = "/Library/PostgreSQL/15/bin/psql")
```

Test connecting to the database from R:
```r
test_connection(dbname, port, user, password)
```

Connect and run a query:
```r
con <- connect(dbname, port, user, password)

res <- query(con, "SELECT DISTINCT clone_id, sample_id FROM airr_rearrangement")

dbDisconnect(con)
```

```
> head(res)
       clone_id sample_id
1 clonotype1957        A2
2  clonotype960        7A
3  clonotype815        A2
4  clonotype368        E5
5 clonotype2586        A2
6  clonotype742        6B
```
