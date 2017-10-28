 /****** Object:  Stored Procedure dbo.SegDef_FieldClassName_SegNumb_    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc SegDef_FieldClassName_SegNumb_ @parm1 varchar ( 15), @parm2 varchar ( 2), @parm3 varchar ( 24) as
       Select * from SegDef
           where FieldClassName =    @parm1
             and SegNumber      =    @parm2
             and ID             like @parm3
           order by FieldClassName, SegNumber, ID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SegDef_FieldClassName_SegNumb_] TO [MSDSL]
    AS [dbo];

