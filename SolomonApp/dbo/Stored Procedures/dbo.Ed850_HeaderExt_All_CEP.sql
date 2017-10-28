 CREATE Proc Ed850_HeaderExt_All_CEP @Parm1 varchar(10)  As select * from Ed850HeaderExt  where EDIPoId like @parm1 order by EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ed850_HeaderExt_All_CEP] TO [MSDSL]
    AS [dbo];

