
CREATE proc WS_FindTimecardHdr 
@parm1 varchar (10)	--Employee
,@parm2 smalldatetime --Post Date
as  
Begin

			SELECT docnbr [Document] FROM PJLABHDR(nolock)
			 where employee = @parm1
			  and  pe_date >= @parm2
			  and le_status = 'I' 
			  and le_id01 = 'Y'
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_FindTimecardHdr] TO [MSDSL]
    AS [dbo];

