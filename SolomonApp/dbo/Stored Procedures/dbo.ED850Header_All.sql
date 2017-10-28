 CREATE Proc ED850Header_All @Parm1 varchar(10),@parm2 varchar(10)  As select * from Ed850Header  where cpnyid = @parm1 and EDIPoId like @parm2 order by EDIPOID


