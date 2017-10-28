Create Procedure CF518p_cftPigSale_BR @parm1 varchar (10), @parm2 varchar (10) as 
    Select * from cftPigSale Where BatNbr = @parm1 and RefNbr Like @parm2
	Order by BatNbr, RefNbr
