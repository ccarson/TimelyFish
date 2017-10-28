Create Procedure xAssyLink_AsyNbr_KFV @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (15) as 
    Select * from xAssyLink Where AsyNbr = @parm1 and KeyFld Like @parm2 and VendId Like @parm3
	Order by AsyNbr, KeyFld, VendId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xAssyLink_AsyNbr_KFV] TO [MSDSL]
    AS [dbo];

