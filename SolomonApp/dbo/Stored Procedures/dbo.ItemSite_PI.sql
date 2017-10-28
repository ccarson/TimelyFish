 /****** Object:  Stored Procedure dbo.ItemSite_PI    Script Date: 4/17/98 10:58:18 AM ******/
Create Proc ItemSite_PI @Parm1 VarChar(10) as
   Update ItemSite set selected = 1, CountStatus = 'P'
   Where SiteID = @Parm1
   and CountStatus = 'A'


