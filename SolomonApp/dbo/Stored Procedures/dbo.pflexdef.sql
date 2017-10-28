 /****** Object:  Stored Procedure dbo.pflexdef    Script Date: 4/17/98 12:50:25 PM ******/
Create Proc pflexdef @CLASSID varchar ( 3)              as
select * from flexdef where fieldclass like @CLASSID order by FieldClass



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pflexdef] TO [MSDSL]
    AS [dbo];

