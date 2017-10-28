
CREATE PROCEDURE [dbo].[cfp_INVENTORY_ROLLUP2]
AS
truncate table cft_INVENTORY_ROLLUP2

insert into cft_INVENTORY_ROLLUP2


select
  it.SiteID
, it.InvtID
, it.TranType
, wd.FiscalYear
, wd.FiscalPeriod
, SUM(CASE 
	WHEN it.TranType IN ('II','IN')	THEN it.Qty * -1
	WHEN it.TranType IN ('TR') AND LEN(RTRIM(it.ToSiteID)) > 0 THEN it.Qty * -1
	ELSE it.Qty 
  END) QtyIssued
, SUM(it.TranAmt)
, MAX(it.TranDate)
from [$(SolomonApp)].dbo.intran it (nolock)
join [$(SolomonApp)].dbo.cftweekdefinition wd (nolock)
	on it.trandate between wd.weekofdate and wd.weekenddate
--where it.trantype not in ('ct', 'rc', 'pi')
where trantype <> 'ct'
group by it.SiteID, it.InvtID, it.TranType, wd.FiscalPeriod, wd.FiscalYear
