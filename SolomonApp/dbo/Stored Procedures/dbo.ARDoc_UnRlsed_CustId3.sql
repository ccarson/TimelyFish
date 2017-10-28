 /****** Object:  Stored Procedure dbo.ARDoc_UnRlsed_CustId3    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_UnRlsed_CustId3 @parm1 varchar ( 15) as
Select * from Salesord where
	CustId = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_UnRlsed_CustId3] TO [MSDSL]
    AS [dbo];

