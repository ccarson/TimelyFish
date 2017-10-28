 create procedure ARTRAN_Init
as
select * from ARTRAN
where custid = 'Z'
and trantype = 'Z'
and refnbr = 'Z'
and linenbr = 9



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARTRAN_Init] TO [MSDSL]
    AS [dbo];

