 Create	Procedure SCM_10800_ItemCost_LIFO
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@LayerType	VarChar(2)
As
	Set	NoCount On

    Select *
      From ItemCost (NoLock)
     Where InvtID = @InvtID
       And SiteID = @SiteID
       And LayerType = @LayerType
       And RcptNbr <> 'OVRSLD'
     Order By RcptDate Desc, RcptNbr Desc


