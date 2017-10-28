 Create Procedure APDoc_LandedCost
	@parmCpnyID varchar (10),
	@parmBatNBr varchar ( 10)
	as
Select * from APDoc Where
	APDoc.BatNbr = @parmBatNbr and
	APDoc.CpnyID = @parmCpnyID and
	APDoc.Rlsed = 1 and
	apdoc.doctype = 'VO'
Order by
	APDoc.BatNbr,
	APDoc.RefNbr


