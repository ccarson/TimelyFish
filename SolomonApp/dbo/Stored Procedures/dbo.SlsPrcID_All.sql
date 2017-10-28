 /****** Object:  Stored Procedure dbo.SlsPrcID_All    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.SlsPrcID_All    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc SlsPrcID_All @Parm1 VarChar(15) as
   Select * from Slsprc where SlsPrcID like @parm1 order by SlsPrcID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrcID_All] TO [MSDSL]
    AS [dbo];

