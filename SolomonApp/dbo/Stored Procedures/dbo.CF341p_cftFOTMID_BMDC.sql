Create Procedure CF341p_cftFOTMID_BMDC @parm1 varchar (10), @parm2 varchar (6), @parm3 smalldatetime,
	@parm4 varchar (6) as
    Select f.*, i.* From cftFeedOrder f Left Join cftTMInvcDet i on f.OrdNbr = i.OrdNbr
	Where i.BatNbr = @parm1 and f.MillId = @parm2 and f.ContactId = @parm4 and f.DateSched <= @parm3
	and f.BatNbrAP = ''
	Order by f.OrdNbr
