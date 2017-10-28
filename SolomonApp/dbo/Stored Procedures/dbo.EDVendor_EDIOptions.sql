 Create Proc EDVendor_EDIOptions @VendId varchar(15) As
Select InEDICost, VouchRecpt, VouchFreight, VendId From EDVendor Where VendId = @VendId


