Create Procedure CF321p_cftTMPricing_MDI @parm1 varchar (6), @parm2 smalldatetime, @parm3 varchar (30) as 
    Select * from cftTMPricing Where MillId = @parm1 and DateEff = @parm2 and InvtId Like @parm3
	Order by MillId, DateEff, InvtId
