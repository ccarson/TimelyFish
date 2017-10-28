 /****** Object:  Stored Procedure dbo.WrkCABal_Del_RI_ID    Script Date: 4/7/98 12:49:20 PM ******/
create Proc WrkCABal_Del_RI_ID @parm1 smallint as
Delete wrkcabalances from WrkCABalances where RI_ID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkCABal_Del_RI_ID] TO [MSDSL]
    AS [dbo];

