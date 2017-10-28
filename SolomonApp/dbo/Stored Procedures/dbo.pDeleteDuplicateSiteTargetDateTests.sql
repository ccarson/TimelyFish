--used in Health Assurance Test app to delete duplicate tests
--for the same site on the same date
CREATE PROC [dbo].[pDeleteDuplicateSiteTargetDateTests]
AS
-- ID the records to delete and get one primary key value also
-- We'll delete all but this primary key
begin transaction
	select TargetTestDate, SiteContactID, RecCount=count(*), max(SiteHealthAssuranceTestID) as PKtoKeep
	into #dupes
	from SiteHealthAssuranceTest
	group by TargetTestDate, SiteContactID
	having count(*) > 1 
	order by count(*) desc, TargetTestDate, SiteContactID

Select * from #dupes
commit transaction

-- delete dupes except one Primary key for each dup record
begin transaction
	delete	SiteHealthAssuranceTest
	from	SiteHealthAssuranceTest a join #dupes d
	on	d.TargetTestDate = a.TargetTestDate
	and	d.SiteContactID = a.SiteContactID
	where	a.SiteHealthAssuranceTestID not in (select PKtoKeep from #dupes)
commit transaction

begin transaction
	drop table #dupes
commit transaction

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pDeleteDuplicateSiteTargetDateTests] TO [MSDSL]
    AS [dbo];

