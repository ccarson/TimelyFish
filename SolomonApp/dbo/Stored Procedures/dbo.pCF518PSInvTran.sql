--*************************************************************
--	Purpose:Inventory Transaction from Pig Sale
--	Author: Charity Anderson
--	Date: 10/20/2004
--	Usage: Pig Sales Entry		 
--	Parms: BatNbr
--*************************************************************

CREATE PROC dbo.pCF518PSInvTran
	(@parm1 as varchar(10))
AS
Select InvEffect=-1,TotPigCnt as Qty,-1 as ca_id10,
	BatNbr as BatchNbr,RefNbr, ps.project,ps.TaskID,
	ps.PigGroupID,ps.SaleDate as MovementDate,
	'PS' as TranTypeID,pt.SubTypeID,AvgWgt=(Select (Sum(WgtLive)) from cftPSDetail 
		where RefNbr=ps.RefNbr)
	
	from cftPigSale ps 

	LEFT JOIN cftPSType pt on ps.SaleTypeID=pt.SalesTypeID

	 where BatNbr like @parm1 and ps.PigGroupID is not null
	 and DocType='SR'
