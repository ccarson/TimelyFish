create procedure PJEMPLOYXREFMSP_spk0 @parm1 varchar (10)  as
select * from PJEMPLOYXREFMSP
where Employee    like @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEMPLOYXREFMSP_spk0] TO [MSDSL]
    AS [dbo];

