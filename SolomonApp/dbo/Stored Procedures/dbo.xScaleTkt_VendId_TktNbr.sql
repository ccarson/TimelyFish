Create Procedure xScaleTkt_VendId_TktNbr @parm1 varchar (15), @parm2 varchar (10) as 
    Select * from xScaleTkt Where VendId = @parm1 and Status = 'O' and TktNbr Like @parm2 
	Order by TktNbr
