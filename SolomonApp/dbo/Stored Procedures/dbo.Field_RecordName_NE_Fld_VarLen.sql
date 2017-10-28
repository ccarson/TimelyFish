 /****** Object:  Stored Procedure dbo.Field_RecordName_NE_Fld_VarLen    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.Field_RecordName_NE_Fld_VarLen    Script Date: 4/7/98 12:51:20 PM ******/
Create Proc Field_RecordName_NE_Fld_VarLen @parm1 varchar ( 20), @parm2 varchar ( 20) as
       Select * from Field
           where RecordName    LIKE  @parm1
             and FieldName     <>    @parm2
             and pFieldDclType IN    (12, 13)
           order by RecordName,
                    FieldName


