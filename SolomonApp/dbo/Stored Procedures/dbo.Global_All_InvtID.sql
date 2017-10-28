 /****** Object:  Stored Procedure dbo.Global_All_InvtID    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Global_All_InvtID    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc Global_All_InvtID @parm1 varchar ( 2), @parm2 varchar ( 6), @parm3 varchar ( 6) as
select fromunit from inunit
  where tounit like case when @parm1 IN ('IT', 'IL','IC')
                      then @parm2
                      else '%'
                      end
        and (fromunit = @Parm3 or fromunit like '%')

  order by FromUnit



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Global_All_InvtID] TO [MSDSL]
    AS [dbo];

