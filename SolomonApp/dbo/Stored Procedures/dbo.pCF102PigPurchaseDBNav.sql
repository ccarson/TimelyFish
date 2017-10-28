--*************************************************************
--	Purpose:DBNav for Pig Purchase
--	Author: Charity Anderson
--	Date: 2/25/2005
--	Usage: Pig Purchase Agreement
--	Parms: @parm1 (PPID)
--	      
--*************************************************************

CREATE PROC dbo.pCF102PigPurchaseDBNav
	@parm1 as varchar(10)
	
AS
Select * from cftPigPurchase where PPID like @parm1 order by PPID
