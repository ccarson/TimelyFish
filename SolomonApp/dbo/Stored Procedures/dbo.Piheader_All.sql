 /****** Object:  Stored Procedure dbo.Piheader_All    Script Date: 4/17/98 10:58:19 AM ******/
/****** Object:  Stored Procedure dbo.Piheader_All    Script Date: 4/16/98 7:41:53 PM ******/
Create Proc Piheader_All @parm1 varchar ( 10) as
            Select * from piheader where PIID like @parm1
                order by PIID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Piheader_All] TO [MSDSL]
    AS [dbo];

