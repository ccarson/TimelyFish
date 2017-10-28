
CREATE proc ws_MyDelegationsApprover @DeletegateToID varchar(50), @Employee varchar(10), @DocType varchar(4) as
      
        declare     @TodaysDate       smalldatetime
        select      @TodaysDate = cast(floor(cast(getdate() as float)) as smalldatetime)

        SELECT Employee, delegate_to_ID, Doc_type, date_start, date_end, BP_user_id
         FROM PJDELEG 
         WHERE PJDELEG.delegate_flag = 'Y' And
               PJDeleg.delegate_to_ID = @DeletegateToID And
               PJDeleg.Employee = @Employee And
               PJDeleg.Doc_type = @DocType And
               PJDeleg.date_start <= @TodaysDate And
               PJDeleg.date_end >= @TodaysDate


