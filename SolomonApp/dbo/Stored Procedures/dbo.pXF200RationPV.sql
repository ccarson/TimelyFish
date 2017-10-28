

--*************************************************************
--	Purpose:PV Feed Rations
--	Author: Sue Matter
--	Date: 10/27/2005
--	Usage: Feed Ration Exceptions
--	Parms: @RationProdClass (from cftFOSetup.ClassRation), 
--	       @BagProdClass (from cftFOSetup.ClassBag), @InvtID 
--*************************************************************

CREATE  PROC pXF200RationPV
	@RationProdClass varchar (6), 
	@BagProdClass varchar (6), 
	@InvtID varchar (30) 
	AS 
    	SELECT * 
	FROM Inventory 
	WHERE (ClassId = @RationProdClass OR ClassId = @BagProdClass) 
	AND InvtId LIKE @InvtID
	ORDER BY InvtId


