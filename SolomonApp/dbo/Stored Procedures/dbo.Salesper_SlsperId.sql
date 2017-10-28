 /****** Object:  Stored Procedure dbo.Salesper_SlsperId    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc Salesper_SlsperId @parm1 varchar ( 10) as
    Select * from Salesperson where SlsperId like @parm1 order by SlsperId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Salesper_SlsperId] TO [MSDSL]
    AS [dbo];

