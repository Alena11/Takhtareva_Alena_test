library(readxl)
library(dplyr)

setwd("C:/Users/Pupir/Desktop/R") 

Candidates <- read_excel("C:/Users/Pupir/Desktop/R/Список кандидатов по всем округам.xls", 
                         range = "A13:H356")

Candidates <- Candidates[-1,-1]

colnames(Candidates)[colnames(Candidates) == '...7'] <- 'Регистрация' 
colnames(Candidates)[colnames(Candidates) == '...8'] <- 'Избрание'

fraction <- Candidates$`Субъект выдвижения`[1]

Candidates <- subset(Candidates, Candidates$`Субъект выдвижения`==fraction)

for(i in 1:nrow(Candidates)){
  q <- paste0("C:/Users/Pupir/Desktop/R/Данные по всем УИК/report (",i-1,").xls")
  d <- read_excel(q, .name_repair = "minimal")
  d.col <- ncol(d)
  result <- c() 
  
  for(j in 4:d.col){

    if(d[29,j]=='0'){
      uik<- d[7,j]
      result <- append(result,uik)
    }
  }
  
  if(is.null(result)==FALSE){
    print(paste0("Округ №",i,":"))
    print(paste(result))
  }

}
