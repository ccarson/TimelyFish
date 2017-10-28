CREATE VIEW cfv_ActiveBarn_Summary (SiteName, FacilityType, Ownership, County, State, SiteOwningCompany, Barn, CurrentInv, Capacity, MktMgr, SvcMgr)
AS
Select SiteName, FacilityType, Ownership, County, State, SiteOwningCompany, Barn, ISNULL(Sum(CurrentInv),0), ISNULL(Sum(Capacity),0), MktMgr, SvcMgr
From cfv_PigGroup_ActiveBarn
Group by SiteName, FacilityType, Ownership, County, State, SiteOwningCompany, Barn, Capacity, MktMgr, SvcMgr

