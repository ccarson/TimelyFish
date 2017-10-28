 /****** Object:  Stored Procedure dbo.Field_RecordName_FieldName    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.Field_RecordName_FieldName    Script Date: 4/7/98 12:51:20 PM ******/
Create Proc Field_RecordName_FieldName @parm1 varchar ( 20), @parm2 varchar ( 20) as
       Select * from Field
           where RecordName  LIKE  @parm1
             and FieldName   LIKE  @parm2
           order by RecordName,
                    FieldName


