 /****** Object:  Stored Procedure dbo.FlexDef_All    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc FlexDef_All @parm1 varchar ( 15) as
       Select * from FlexDef where FieldClassName like @parm1
                              order by FieldClassName


