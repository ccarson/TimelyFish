 


Create View vr_40690_ARPaymentBatch As


	SELECT 	'BatNbr' = BatNbr, 'InvcNbr' = SiteID
	FROM 	ARTran
	WHERE	JrnlType = 'OM' and TranType = 'PA' and SiteID + '' <> ''

	UNION
	
	SELECT	'BatNbr' = AdjBatNbr, 'InvcNbr' = AdjdRefNbr
	FROM	ARAdjust JOIN ARDoc
	  On	ARAdjust.AdjBatnbr = ARDoc.Batnbr
	  and	ARADjust.AdjgRefNbr = ARDoc.RefNbr
	WHERE	ARDoc.DocType = 'PA' and ARDoc.Crtd_Prog = '40690'



 
