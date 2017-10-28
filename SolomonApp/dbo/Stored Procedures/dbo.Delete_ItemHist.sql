 Create Proc Delete_ItemHist
    @parm1 varchar ( 4),
    @Parm2 varchar (10)
as
Delete ItemHist
  From ItemHist Join Site
       on  ItemHist.SiteID = Site.SiteID
  Where ItemHist.FiscYr <= @parm1
    And Site.CpnyID = @Parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_ItemHist] TO [MSDSL]
    AS [dbo];

