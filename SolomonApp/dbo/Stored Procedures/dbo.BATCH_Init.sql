 create procedure BATCH_Init
as
select * from BATCH
where module = 'Z'
and batnbr = 'Z'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BATCH_Init] TO [MSDSL]
    AS [dbo];

