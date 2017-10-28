 Create Procedure IRItem2HistNormal_ISP
	@InvtID VarChar(30),
	@SiteID VarChar(10),
	@Period VarChar(6)
As
Select
	*
From
	IRItem2HistNormal
Where
	InvtID = @InvtID
	And SiteID = @SiteID
	And Period = @Period


