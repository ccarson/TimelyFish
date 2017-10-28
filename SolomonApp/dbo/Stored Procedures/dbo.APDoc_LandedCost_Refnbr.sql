 Create Procedure APDoc_LandedCost_Refnbr
	@parmRefNbr varchar ( 10)
As
Select * from APDoc Where
	APDoc.RefNbr = @parmRefNbr and
	APDOC.DocType = 'VO'
Order by
	APDoc.RefNbr


