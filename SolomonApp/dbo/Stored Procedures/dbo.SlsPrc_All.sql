 /****** Object:  Stored Procedure dbo.SlsPrc_All    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.SlsPrc_All    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc SlsPrc_All @Parm1 VarChar(4), @Parm2 Varchar(15) as
   Select * from Slsprc where CuryID = @parm1
   and SlsPrcID like @parm2 order by SlsPrcID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrc_All] TO [MSDSL]
    AS [dbo];

