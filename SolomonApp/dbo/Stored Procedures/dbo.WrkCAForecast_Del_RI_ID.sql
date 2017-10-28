 /****** Object:  Stored Procedure dbo.WrkCAForecast_Del_RI_ID    Script Date: 4/7/98 12:49:20 PM ******/
create Proc WrkCAForecast_Del_RI_ID @parm1 smallint as
Delete wrkcaforecast from WrkCAForeCast where RI_ID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkCAForecast_Del_RI_ID] TO [MSDSL]
    AS [dbo];

