 create procedure PJALLAUD_INIT as
select * from PJALLAUD
where  FISCALNO         = 'Z' and
SYSTEM_CD        = 'Z' and
BATCH_ID         = 'Z' and
DETAIL_NUM       =  9 and
AUDIT_DETAIL_NUM =  9



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLAUD_INIT] TO [MSDSL]
    AS [dbo];

