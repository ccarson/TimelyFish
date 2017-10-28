 /****** Object:  Stored Procedure dbo.ARDoc_Cnt_Apply    Script Date: 4/7/98 12:30:32 PM ******/
Create proc ARDoc_Cnt_Apply @parm1 varchar ( 15) As
 Select Count(RefNbr) from ARDoc WHERE ARDoc.CustId = @parm1
    and Rlsed = 1
    and doctype IN ('FI', 'IN', 'DM')
    and curydocbal > 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Cnt_Apply] TO [MSDSL]
    AS [dbo];

