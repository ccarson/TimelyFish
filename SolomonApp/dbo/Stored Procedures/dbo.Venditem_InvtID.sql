 /****** Object:  Stored Procedure dbo.Venditem_InvtID                                          ******/
Create proc Venditem_InvtID @parm1 varchar(30) as
	select * from VendItem where InvtID like @parm1
	order by InvtID, SiteID, VendID, FiscYr


