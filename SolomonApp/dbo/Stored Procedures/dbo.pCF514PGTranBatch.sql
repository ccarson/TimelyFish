
/****** Object:  Stored Procedure dbo.pCF514PGTranBatch    Script Date: 2/16/2005 9:18:34 AM ******/
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-05-02  Doran Dahle Changed screen filter to XP From CF. and added XP Module
						

===============================================================================
*/
CREATE     Proc [dbo].[pCF514PGTranBatch]
	@parm1 varchar (10)
as
	Select bt.*
	From Batch as bt
	WHERE bt.Rlsed = 0 AND bt.EditScrnNbr LIKE 'XP%'
	AND (bt.Module='CF' OR bt.Module='X%')
	AND bt.Status <> 'C'
	AND bt.BatNbr Like @parm1
	Order by bt.BatNbr





