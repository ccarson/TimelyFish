
--*************************************************************
--	Purpose:PigSales Batch PV
--	Author: Charity Anderson
--	Date: 12/3/2004
--	Usage: Pig Sales Entry		 
--	Parms: 
--*************************************************************

CREATE View dbo.vCF518BasePrice

AS
Select ps.*,oh.PSOrdType,
BP=Case when oh.PSOrdType='O' then
oh.BasePrice else dbo.fxnCF518GetBasePrice(oh.ContrNbr,ps.SaleDate) end,
PSCpnyID=Case when ps.CpnyID='CFM' then 'CFM' else 'CFF' end,
BPDiffLimit=(Select BPDiffLimit from cftPSSetup)
from cftPigSale ps 
left JOIN cftPSOrdHdr oh on ps.OrdNbr=oh.OrdNbr
LEFT JOIN cftPigSale re on ps.RefNbr=re.OrigRefNbr
where re.OrigRefNbr is null
and ps.SaleTypeID<>'RS' and ps.DocType<>'RE'

