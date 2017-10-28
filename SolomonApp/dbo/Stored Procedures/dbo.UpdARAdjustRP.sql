 Create Proc UpdARAdjustRP @parm1 varchar ( 15), @parm2 varchar ( 2), @parm3 varchar ( 10),
@parm4 varchar (10) as

    Update ARAdjust set S4Future11 = @parm4
	   where CustId = @parm1
           and AdjgDocType = @parm2
           and AdjgRefNbr = @parm3
	   and AdjAmt < 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UpdARAdjustRP] TO [MSDSL]
    AS [dbo];

