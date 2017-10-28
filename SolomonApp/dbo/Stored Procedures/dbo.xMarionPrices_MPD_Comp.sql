Create Procedure xMarionPrices_MPD_Comp @parm1 smalldatetime, @parm2 varchar (10) as 
    Select * from xMarionPrices Where MPDate = @parm1 and Comptr Like @parm2
	Order by MPDate DESC, Comptr
