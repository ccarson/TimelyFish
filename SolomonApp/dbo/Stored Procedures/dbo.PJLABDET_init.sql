 create procedure PJLABDET_init
as
select * from PJLABDET
where    docnbr     =  'Z' and
linenbr    = 9



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDET_init] TO [MSDSL]
    AS [dbo];

