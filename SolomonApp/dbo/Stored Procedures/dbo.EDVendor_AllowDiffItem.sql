 Create Proc EDVendor_AllowDiffItem @VendId varchar(15) As
Select AllowDiffItem From EDVendor Where VendId = @VendId


