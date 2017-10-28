 create procedure PJTRANWK_init
as
select * from PJTRANWK
where
ALLOC_BATCH     = 'Z' and
FISCALNO        = 'Z' and
SYSTEM_CD       = 'Z' and
BATCH_ID        = 'Z' and
PROJECT         = 'Z' and
DETAIL_NUM      = 9


