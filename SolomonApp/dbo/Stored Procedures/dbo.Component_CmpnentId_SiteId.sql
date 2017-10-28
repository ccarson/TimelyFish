 Create Proc  Component_CmpnentId_SiteId  @parm1 varchar(30),  @parm2 varchar(30), @parm3 varchar(30)  as
            Select * from Component where Cmpnentid = @parm1 and SiteId = @parm2 and kitid >= @parm3
             Order by CmpnentId, SiteId, Kitid, sequence



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_CmpnentId_SiteId] TO [MSDSL]
    AS [dbo];

