 /****** Object:  Stored Procedure dbo.SegDefHeader_All    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc SegDefHeader_All @parm1 varchar ( 15), @parm2 varchar ( 2) as
       Select * from SegDefHeader
           where FieldClassName like @parm1
             and SegNumber      like @parm2
           order by FieldClassName,
                    SegNumber



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SegDefHeader_All] TO [MSDSL]
    AS [dbo];

