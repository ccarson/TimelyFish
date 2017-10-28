create procedure PJPROJMX_SameRevOverMax 
		@Project varchar (16) as

--check for pjprojmx records that contain same acct or additional acct that = overmax acct
select count(*)
from PJPROJMX p
inner join PJPROJMX s 
on p.acct = s.acct
where p.project = @Project and (s.acct = s.acct_overmax or (s.mx_id03 = s.acct_overmax and s.mx_id03 <> ''))
group by s.acct, s.mx_id03, s.acct_overmax


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJMX_SameRevOverMax] TO [MSDSL]
    AS [dbo];

