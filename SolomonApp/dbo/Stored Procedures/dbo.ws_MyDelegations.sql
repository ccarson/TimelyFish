
CREATE proc ws_MyDelegations @DeletegateToID varchar(50), @DocType varchar(4) as
      
        declare     @TodaysDate       smalldatetime
        select      @TodaysDate = cast(floor(cast(getdate() as float)) as smalldatetime)

        select Employee, (select pj.emp_name from PJEMPLOY pj where pj.employee = PJDELEG.Employee)Name from PJDELEG where
        PJDELEG.delegate_flag = 'Y' And
        PJDeleg.delegate_to_ID = @DeletegateToID And
        PJDeleg.Doc_type = @DocType And
        PJDeleg.date_start <= @TodaysDate And
        PJDeleg.date_end >= @TodaysDate


