
getData <- function(table_name, labsampnum) {
  q <- sprintf("SELECT * from %s where labsampnum = '%s';", table_name, labsampnum)
  
  res <- try(dbGetQuery(db, q), silent = TRUE)
  
  if(class(res) == 'try-error')
    res <- NULL
  
  return(res)
}


getPedonLabSampNum <- function(labsampnum) {
  
  q <- sprintf("SELECT pedlabsampnum FROM NCSS_Pedon_Taxonomy WHERE pedon_key IN (SELECT pedon_key from NCSS_Layer where labsampnum = '%s');", labsampnum)
  res <- dbGetQuery(db, q)
  
  return(res$pedlabsampnum)
}

