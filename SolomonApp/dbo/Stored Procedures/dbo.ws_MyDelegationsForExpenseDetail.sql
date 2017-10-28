CREATE proc ws_MyDelegationsForExpenseDetail @DelegateToID varchar(50), @DocNbr varchar(10) as    

        declare     @TodaysDate       smalldatetime
        select      @TodaysDate = cast(floor(cast(getdate() as float)) as smalldatetime)
                  
       SELECT TOP 1 p.Employee, p.delegate_to_ID, p.Doc_type, p.date_start, p.date_end, p.BP_user_id
         FROM PJDELEG p JOIN PJPROJ j
                          ON p.Employee = j.manager1
                        JOIN PJEXPDET d
                          ON j.project = d.project
      
         WHERE d.docnbr = @DocNbr And
               p.delegate_flag = 'Y' And
               p.delegate_to_ID = @DelegateToID And
               p.Doc_type IN ('PEXP','PITM') And
               p.date_start <= @TodaysDate And
               p.date_end >= @TodaysDate
               
