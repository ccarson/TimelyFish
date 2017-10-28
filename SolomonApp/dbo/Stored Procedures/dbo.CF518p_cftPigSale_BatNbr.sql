Create Procedure CF518p_cftPigSale_BatNbr @parm1 varchar (10) as 
    Select * from cftPigSale Where BatNbr = @parm1
	Order by BatNbr, PkrContactId, KillDate, TattooNbr
