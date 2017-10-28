--*************************************************************
--	Purpose:DBNav for Pig Suppliers
--		
--	Author: Charity Anderson
--	Date: 2/22/2005
--	Usage: Pig Suppliers Maintenance 
--	Parms: ContactID 
--*************************************************************

CREATE PROC dbo.pCF102PigSuppliers
	(@parm1 as varchar(6))
AS
Select * from cftPigSupplier p 
JOIN cftContact c WITH (NOLOCK) 
on p.ContactID=c.ContactID
where p.ContactID like @parm1
