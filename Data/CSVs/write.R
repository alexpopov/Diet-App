# script
# http://www.hc-sc.gc.ca/fn-an/nutrition/fiche-nutri-data/cnf_downloads-telechargement_fcen-eng.php

library("foreign", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")

miscellize <- function(some.factor, threshold = 6) {
  some.factor.table <- table(some.factor)
  for (f in some.factor.table) {
    if (some.factor.table[f] < threshold) {
      # print(c(levels(some.factor)[f], "renamed to miscellaneous"))
      levels(some.factor)[f] <- "Miscellaneous"
    } else {
      # print(c(levels(some.factor)[f], "kept the same"))
    }
  }
  return(some.factor)
}

# food table
food <- read.dbf("CNF_DBF/FOOD_NM.DBF" )
food$A_FD_NMF <- NULL
food$A_FD_NME <- NULL
food$L_FD_NMF <- NULL
food$FD_SRC_ID <- NULL
food$COUNTRY_C <- NULL
food$FD_DT_ENT  <- NULL
food$FD_DT_PUB	<- NULL 
food$SCI_NM <- NULL
# add section column from first part of L_FD_NME
str <- sapply(food$L_FD_NME, as.character)                  # isolate L_FD_NME as character string
split = colsplit(string=str, pattern=", ", names=c(1:9))     # split by comma
food.factors = as.factor(split$'1')                         # change into factor
food.factors.fixed <- miscellize(food.factors)              # change all 'unimportant' into "miscellaneous"
food["SUB_SEC"] <- food.factors.fixed                       # add columns back in

# food groups
food_groups <- read.dbf("CNF_DBF/FOOD_GRP.DBF")
food_groups$FD_GRP_NMF <- NULL
# nutrient amount
nutrient_amount <- read.dbf("CNF_DBF/NT_AMT.DBF")
nutrient_amount$STD_ERR <- NULL
nutrient_amount$NUM_OBS <- NULL
nutrient_amount$NT_SRC_ID <- NULL
nutrient_amount$NT_DT_ENT <- NULL
# nutrient name
nutrient_name <- read.dbf("CNF_DBF/NT_NM.DBF")
nutrient_name$TAGNAME <- NULL
nutrient_name$NT_NME <- NULL
nutrient_name$NT_DEC <- NULL
# conversion factor
conv_factor <- read.dbf("CNF_DBF/CONV_FAC.DBF")
conv_factor$CF_DT_ENT <- NULL
# measure 
measure <- read.dbf("CNF_DBF/MEASURE.DBF")
measure$MSR_NMF <- NULL


save(file="cnf_data.RData", list=c("food","food_groups","nutrient_amount","nutrient_name"))
# load("cnf_data.RData")

write.table(food, row.names = F, col.names=FALSE, sep="\t", file="food.csv", quote = FALSE)
write.table(food_groups, row.names = F, sep="|", file="food_groups.csv", col.names=FALSE, quote = FALSE)
write.table(nutrient_amount, row.names = F, sep="|", file="nutrient_amount.csv", col.names=FALSE, quote = FALSE)
write.table(nutrient_name, row.names = F, sep="|", file="nutrient_name.csv", col.names=FALSE, quote = FALSE)
write.table(conv_factor, row.names = F, sep="|", file="conv_factor.csv", col.names=FALSE, quote = FALSE)
write.table(measure, row.names = F, sep="|", file="measure.csv", col.names=FALSE, quote = FALSE)

paste0("create table food (", paste0(names(food), collapse=", "), ");")
paste0("create table food_groups (", paste0(names(food_groups), collapse=", "), ");")
paste0("create table nutrient_amount (", paste0(names(nutrient_amount), collapse=", "), ");")
paste0("create table nutrient_name (", paste0(names(nutrient_name), collapse=", "), ");")
paste0("create table conv_factor (", paste0(names(conv_factor), collapse=", "), ");")
paste0("create table measure (", paste0(names(measure), collapse=", "), ");")



### import in SQLite with 
# sqlite3 cnf_food.sqlite
# <<Copy and paste generated create table statements>>
# .separator ","
# .import food.csv food
# .import food_groups.csv food_groups
# .import nutrient_amount.csv nutrient_amount
# .import nutrient_name.csv nutrient_name
# << write code & prosper >>