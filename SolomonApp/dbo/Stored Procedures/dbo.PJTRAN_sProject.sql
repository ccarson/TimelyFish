 create procedure PJTRAN_sProject @parm1 varchar (16)  as
select * from PJTRAN
where
project like  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_sProject] TO [MSDSL]
    AS [dbo];

