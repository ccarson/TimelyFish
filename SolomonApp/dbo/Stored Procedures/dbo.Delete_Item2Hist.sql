 Create Proc Delete_Item2Hist
    @parm1 varchar ( 4),
    @Parm2 varchar (10)
as
Delete Item2Hist
  From Item2Hist Join Site
       on  Item2Hist.SiteID = Site.SiteID
  Where Item2Hist.FiscYr <= @parm1
    And Site.CpnyID = @Parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_Item2Hist] TO [MSDSL]
    AS [dbo];

