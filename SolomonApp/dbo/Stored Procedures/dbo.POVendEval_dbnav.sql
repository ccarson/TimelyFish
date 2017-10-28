 /****** Object:  Stored Procedure dbo.POVendEval_dbnav    Script Date: 12/17/97 10:48:56 AM ******/
Create Procedure POVendEval_dbnav @parm1 Varchar(10), @Parm2 Varchar(30) as
Select * from POVendReqSum where ReqNbr = @parm1
and Name Like @parm2
Order by ReqNbr, Name



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POVendEval_dbnav] TO [MSDSL]
    AS [dbo];

