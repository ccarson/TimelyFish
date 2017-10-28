 create procedure PJEXPDET_init
as
select * from PJEXPDET
where    docnbr     =  'Z' and
linenbr    = 9



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPDET_init] TO [MSDSL]
    AS [dbo];

