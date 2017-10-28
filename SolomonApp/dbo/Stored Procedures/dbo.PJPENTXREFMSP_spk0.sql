
create procedure PJPENTXREFMSP_spk0 @parm1 varchar (16) , @parm2 varchar (32)   as
select PJPENTXREFMSP.Pjt_Entity_MSPID
From	PJPENTXREFMSP
where  PJPENTXREFMSP.project         =     @parm1
and    PJPENTXREFMSP.pjt_entity      =	   @parm2
order by
PJPENTXREFMSP.project,
PJPENTXREFMSP.pjt_entity


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTXREFMSP_spk0] TO [MSDSL]
    AS [dbo];

