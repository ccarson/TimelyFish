 create procedure PJTRAN_spk1
as
select * from PJTRAN
where FISCALNO        = 'Z' and
SYSTEM_CD       = 'Z' and
BATCH_ID        = 'Z' and
DETAIL_NUM      = 9



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_spk1] TO [MSDSL]
    AS [dbo];

