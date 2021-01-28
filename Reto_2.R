install.packages("rvest")
library(rvest)
htmlfile <- read_html("https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm")

tablas <- html_nodes(htmlfile, "table")  
head(tablas)
tabla.aux <- html_table(tablas[1], fill = TRUE)
tabla <- na.omit(as.data.frame(tabla.aux))

str(tabla)

sueldos <- gsub("[^0-9]", "", tabla$Sueldo) 
sueldos <- as.numeric(sueldos)
tabla$Sueldo <- sueldos

cargo <- gsub("Sueldos para Data Scientist en ", "", tabla$Cargo)
cargo <- gsub(" - [0-9] sueldos informados", "", cargo)
tabla$Cargo <-cargo

maximo <- which.max(tabla$Sueldo)
tabla[maximo,]

minimo <- which.min(tabla$Sueldo)
tabla[minimo,]
