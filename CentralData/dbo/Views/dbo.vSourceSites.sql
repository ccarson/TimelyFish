Create view dbo.vSourceSites
As

Select ContactID,ContactName,FacilityTypeID 
From
dbo.vSitewithContactName
Union
Select '9999','',''
Union
Select * from dbo.vPigSupplier


