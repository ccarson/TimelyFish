 /****** Object:  Stored Procedure dbo.Salesper_Territory    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc Salesper_Territory @parm1 varchar ( 10) as
    Select * from Salesperson where Territory = @parm1 order by SlsperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Salesper_Territory] TO [MSDSL]
    AS [dbo];

