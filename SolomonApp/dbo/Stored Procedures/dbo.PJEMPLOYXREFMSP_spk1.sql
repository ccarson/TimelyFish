create procedure PJEMPLOYXREFMSP_spk1 @parm1 varchar (60)  as
select * from PJEMPLOYXREFMSP
where Employee_MSPName    like @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEMPLOYXREFMSP_spk1] TO [MSDSL]
    AS [dbo];

