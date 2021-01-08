
source("getDataFromHPLC.R")
shinyServer(function(input, output, session) {
  observe({
    if (input$submit1>0) {
      isolate({
     
    file.name<-input$file
  

    standard_curve<-read.csv(input$standardUpload$datapath)
  

    data<-get_data_from_hplc(filename =  file.name)


    data$peak_name<-NA
    data$peak_time<-NA
    data$peak_concentration<-0




    ts<-standard_curve$time_avg-input$standDown
    te<-standard_curve$time_avg+input$standUp
    for(i in 1: nrow(data)){
      t1<-as.numeric(data$'retention time(min)'[i])
      if(any(t1>ts&t1<te)){
        selected_curve<-standard_curve[t1>ts&t1<te,]
        data$peak_name[i]<-selected_curve[1,1]
        data$peak_time[i]<-selected_curve[1,5]
        data$peak_concentration[i]<-as.numeric(data$'peak area(mAUs)'[i])*selected_curve$x+selected_curve$b

      }

    }


    rownames(data)<-NULL
    

    
    output$a<-renderDataTable({
      data
    })
    

    # output$b<-renderText({
    #   length(file.name)
    # })


    output$b<- downloadHandler(
      filename = function() { "data.txt" },
      content = function(file) {

        write.table(data,file, sep = "\t", quote=FALSE, row.names = FALSE,col.names = TRUE)
      }, contentType = 'text/plain')
    

    
    
  
      })
    }
  })
  
  
  
  })  

