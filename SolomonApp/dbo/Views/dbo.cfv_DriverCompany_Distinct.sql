



CREATE VIEW [dbo].[cfv_DriverCompany_Distinct]
AS

select distinct TruckingCompanyContactID, TruckingCompanyName
from cfv_DriverCompany
where TruckingCompanyName <> ''




