
library(pdftools)
library(tidyverse)



get_data_from_hplc<-function(filename=NULL){
  
  myfilenames<-paste(filename,list.files(path=filename, pattern='pdf$'),sep="")
  
  
  mydata<-lapply(1:length(myfilenames), function(x){
    file.name<-myfilenames[x]

  mydata<-readr::read_lines(pdf_text(file.name))
  mydata<-str_trim(mydata)
  mydata<-hplc<-str_squish(mydata)
  #mydata<-read.table(file.name,sep = "\t",fileEncoding = "UTF-8")
  #mydata<-as.vector(as.matrix(mydata))
  mydata<-mydata[nchar(mydata)>20]


  location<-mydata[3]
  location<-unlist(strsplit(location,""))
  location<-paste(location[-grep(" ",location)],collapse="")

  myse<-NULL
  for(i in 1:length(mydata)){

    myline<-mydata[i]
    element_of_myline<-unlist(strsplit(myline," "))

    myjudge<-any(element_of_myline%in%c("BB","VV","BV","VB"))

    if(myjudge) myse<-rbind(myse,myline)
  }

  ####
  myse2<-NULL
  for(i in 1:nrow(myse)){
    unit<-unlist(strsplit(myse[i]," "))
    unit<-unit[nchar(unit)>0]
    unit<-unit[-grep("[A-Z]",unit)]
    myse2<-rbind(myse2,unit)
  }

  myse3<-as.data.frame(myse2)




  colnames(myse3)<-c("peak#","retention time(min)","peak width(min)","peak area(mAUs)","peak height(mAU)","peak area(%)")
  rownames(myse3)<-1:nrow(myse3)
  myse3$location<-location
  return(myse3)
  })
  mydata1<-do.call(rbind,mydata)

  return(mydata1)
}














