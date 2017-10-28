
Create Procedure Vendor_DBNav @parm1 varchar ( 15) as
Select * from Vendor where VendId = @parm1 order by VendId

