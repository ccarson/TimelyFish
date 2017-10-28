 /****** Object:  Stored Procedure dbo.Record_RecordName    Script Date: 4/17/98 12:50:25 PM ******/
/****** Object:  Stored Procedure dbo.Record_RecordName    Script Date: 4/7/98 12:51:20 PM ******/
Create Proc  Record_RecordName @parm1 varchar ( 20) as
       Select * from Record
           where RecordName  LIKE  @parm1
           order by RecordName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Record_RecordName] TO [MSDSL]
    AS [dbo];

