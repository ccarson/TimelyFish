 create procedure PJTIMWRK_dbatch @parm1 varchar (10) as
delete from PJTIMWRK
where Report_accessnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMWRK_dbatch] TO [MSDSL]
    AS [dbo];

