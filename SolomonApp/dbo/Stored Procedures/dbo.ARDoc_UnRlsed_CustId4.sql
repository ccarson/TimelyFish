 Create Procedure ARDoc_UnRlsed_CustId4 @parm1 varchar ( 15) as
Select * from SOHeader where
	CustId = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_UnRlsed_CustId4] TO [MSDSL]
    AS [dbo];

