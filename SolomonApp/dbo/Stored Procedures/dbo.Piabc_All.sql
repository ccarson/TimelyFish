 /****** Object:  Stored Procedure dbo.Piabc_All    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Piabc_All    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc Piabc_All @parm1 varchar ( 02) as
            Select * from piabc where abccode like @parm1
                order by abccode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Piabc_All] TO [MSDSL]
    AS [dbo];

