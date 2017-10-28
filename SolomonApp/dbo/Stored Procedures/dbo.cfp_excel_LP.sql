




-- =============================================
-- Author:		SRipley, dbo.cfp_excel_LP
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the LP spreadsheet
-- The user needs to provide the sitename and a start and end date for a transdate search.
-- =============================================
CREATE PROCEDURE [dbo].[cfp_excel_LP] 
     @sDate Datetime = Null, @edate datetime=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

select distinct Site.contactname [Site Name]
, BatNbr, trantype, RefNbr, Acct, TranDate
, VendId, TranDesc, UnitDesc, ProjectID, TaskID, PC_Status, Qty, UnitPrice
, cap.capacity, cap.sum_maxcap, cap.sum_stdcap, cap.barncnt
, barninfo.PaymentSpaces
from solomonapp.dbo.aptran apt (nolock)
left join 
	(select ContactName, S.* 
	 from CentralData.dbo.Site S (nolock)
	 inner join CentralData.dbo.Contact C (nolock) 
		on C.ContactID = S.ContactID) site
	on site.siteid = substring(apt.projectid,3,6)
left join 
	(select ContactName, S1.SiteID
	, SUM(bn.stdcap) sum_stdcap
	, SUM(Bn.MaxCap) sum_maxcap
	, COUNT(1) as barncnt
	, case  when ISNULL(rcap.roomamt,0) = 0 
        then cast(rcap.Totalamt AS integer)
            else cast(rcap.Roomamt as integer)
	end as capacity
	from CentralData.dbo.Site S1 (nolock)
	inner join CentralData.dbo.Contact C1 (nolock) 
		on C1.ContactID = S1.ContactID
	inner join CentralData.dbo.Barn bn (nolock)
		on Bn.ContactID = S1.ContactID
	left outer join
	(select st.contactid, sum(b.MaxCap) as Totalamt, Sum(b.StdCap * m.BrnCapPrct) Roomamt
      from solomonapp.dbo.cftSite st (nolock)
      left JOIN solomonapp.dbo.cftBarn b 
            ON b.ContactID=st.ContactID
      left Join solomonapp.dbo.cftRoom m 
            on b.ContactId = m.ContactId and b.BarnNbr = m.BarnNbr
      group by st.contactid) rcap
		on rcap.ContactID = S1.ContactID
group by ContactName,S1.SiteID, case  when ISNULL(rcap.roomamt,0) = 0 
        then cast(rcap.Totalamt AS integer)
            else cast(rcap.Roomamt as integer)
  end
) cap
	on cap.siteid = substring(apt.projectid,3,6)
left join 
	(  select bc.BarnID, bc.PaymentSpaces, bn.ContactID, bn.SiteID, bn.FacilityTypeID, bn.StatusTypeID, bn.StdCap, bn.MaxCap
		from centraldata.dbo.BarnChar bc (nolock)
		inner join CentralData.dbo.Barn bn (nolock)
			on bn.BarnID = bc.BarnID  ) barninfo
	on barninfo.ContactID = site.ContactID 
where Acct = '62100'
--and Site.contactname = @sitename -- used only by the report version
and TranDate between @sdate and @edate 




END






GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_excel_LP] TO [MSDSL]
    AS [dbo];

