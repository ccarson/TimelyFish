 create procedure SLSTAXHIST_sPK0 @parm1 varchar (10) , @PARM2 varchar (6) , @PARM3 varchar (10)  as
select * from SLSTAXHIST
where taxid  =  @parm1 and
YrMon  =  @parm2 and
CpnyID = @parm3
order by taxid, YrMon



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SLSTAXHIST_sPK0] TO [MSDSL]
    AS [dbo];

