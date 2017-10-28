--*************************************************************
--	Purpose:PV for Pig Purchase
--	Author: Charity Anderson
--	Date: 2/18/2005
--	Usage: Pig Purchase Agreement
--	Parms: @parm1 (PPID)
--	      
--*************************************************************

CREATE PROC dbo.pCF102PigPurchase
	@parm1 as varchar(10)
	
AS
Select * from cftPigPurchase 
JOIN cftContact WITH (NOLOCK)  on cftPigPurchase.ContactID=cftContact.ContactID 
where PPID like @parm1 order by PPID
