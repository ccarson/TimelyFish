 create procedure PJSUBMIT_SPK0  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (10)   as
select * from PJSUBMIT
where    project = @parm1 and
subcontract = @parm2 and
	     submitnbr = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBMIT_SPK0] TO [MSDSL]
    AS [dbo];

