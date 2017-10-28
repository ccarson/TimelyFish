
/****** Object:  Stored Procedure dbo.pXF170cftPfosBinTrack    Script Date: 9/20/2005 12:04:44 PM ******/
create Procedure [dbo].[pXF170cftPfosBinTrack] @BinNbr varchar (6), @PigGroupID varchar (10) as

Select bt.*, pe.* 
from cftPfosBinTrack as bt 
join cftPfosEvent pe on pe.IDPfosEvent = bt.PfosEventID
Where bt.BinNbr like Case When @BinNbr = '' Then '%' Else @BinNbr End and
bt.PigGroupID like Case When @PigGroupId = '' Then '%' Else @PigGroupID End
Order by bt.Event_DT DESC, bt.PigGroupId, bt.BinNbr
	