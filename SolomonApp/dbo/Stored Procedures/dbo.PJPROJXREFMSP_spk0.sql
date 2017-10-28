create procedure PJPROJXREFMSP_spk0 @parm1 varchar (16)  as
select Project_MSPID from PJPROJXREFMSP
where project    like @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJXREFMSP_spk0] TO [MSDSL]
    AS [dbo];

