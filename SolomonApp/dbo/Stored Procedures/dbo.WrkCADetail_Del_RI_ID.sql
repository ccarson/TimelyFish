﻿ /****** Object:  Stored Procedure dbo.WrkCADetail_Del_RI_ID    Script Date: 4/7/98 12:49:20 PM ******/
create Proc WrkCADetail_Del_RI_ID @parm1 smallint as
Delete wrkcadetail from WrkCADetail where RI_ID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkCADetail_Del_RI_ID] TO [MSDSL]
    AS [dbo];

