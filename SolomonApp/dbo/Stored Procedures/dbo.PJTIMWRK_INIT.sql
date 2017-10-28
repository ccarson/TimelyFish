 create procedure PJTIMWRK_INIT as
select * from PJTIMWRK
where
Report_accessnbr = ' ' and
Linenbr = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMWRK_INIT] TO [MSDSL]
    AS [dbo];

