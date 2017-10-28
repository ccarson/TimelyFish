 CREATE Proc Ed850_Header_All_CEP @Parm1 varchar(10),@parm2 varchar(10)  As select * from Ed850Header  where cpnyid = @parm1 and EDIPoId like @parm2 order by EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ed850_Header_All_CEP] TO [MSDSL]
    AS [dbo];

