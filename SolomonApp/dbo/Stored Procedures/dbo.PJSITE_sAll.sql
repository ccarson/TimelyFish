 Create Procedure PJSITE_sAll @parm1 varchar (4)  as
select * from PJSITE
where TerminalCode like @parm1
order by TerminalCode



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSITE_sAll] TO [MSDSL]
    AS [dbo];

