 create procedure PJSUBDET_sProj  @parm1 varchar (16)   as
select * from PJSUBDET
where
PJSUBDET.project       =    @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBDET_sProj] TO [MSDSL]
    AS [dbo];

