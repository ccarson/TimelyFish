﻿ Create Proc Comp_Kit_Site_KStatus_Seq @parm1 varchar ( 30), @parm2 varchar ( 10), @parm3 varchar ( 1), @parm4beg varchar (5), @parm4end varchar (5) as
            Select * from Component where Kitid = @parm1 and KitSiteId = @parm2
                   and KitStatus = @parm3
                   and Sequence between @parm4beg and @parm4end
                   Order by Kitid, SiteId, KitStatus, Sequence



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Comp_Kit_Site_KStatus_Seq] TO [MSDSL]
    AS [dbo];

