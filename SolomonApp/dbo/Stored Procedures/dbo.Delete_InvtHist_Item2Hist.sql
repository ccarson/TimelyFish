 Create Proc Delete_InvtHist_Item2Hist
    @parm1 varchar ( 30),
    @parm2 varchar ( 10),
    @parm3 varchar ( 4)
as
Delete from Item2Hist
    where InvtId = @parm1
      and SiteId = @parm2
      and FiscYr = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_InvtHist_Item2Hist] TO [MSDSL]
    AS [dbo];

