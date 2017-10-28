 create procedure PJBILL_sCury @parm1 varchar (4), @parm2 varchar (16)  as
select * from PJBILL
where
billcuryid = @parm1 and
project like @parm2
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_sCury] TO [MSDSL]
    AS [dbo];

