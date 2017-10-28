 create procedure PJTRAN_sProj @parm1 varchar (16)  as
select * from PJTRAN
where
project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_sProj] TO [MSDSL]
    AS [dbo];

