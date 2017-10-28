
CREATE proc ws_CheckNestedDelegationsB @EmpID varchar(50), @DeletegateToID varchar(50), @DocType varchar(4), @StartDate date, @EndDate date as
Begin

         -->  //Two checks here for nested delegations:
         -->   //1. Emp A ----> B exists and trying to delegate B---> C
         -->   //2. Emp B ----> C DOES exists and trying to delegate A ---> B

		select * from PJDELEG where
		PJDELEG.delegate_flag = 'Y' And
		PJDeleg.Employee = @DeletegateToID And
		PJDeleg.Doc_type = @DocType And
		PJDeleg.date_start >= @StartDate And
		PJDeleg.date_end <= @EndDate
	
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ws_CheckNestedDelegationsB] TO [MSDSL]
    AS [dbo];

