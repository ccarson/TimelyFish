
create procedure PJPROJMX_DupOverMax 
		@Project varchar (16) as

--create common table expression as all overmax accts for project
with wrk_PJPROJMX (acct) as (
select s.acct_overmax 
from PJPROJMX p
inner join PJPROJMX s 
on p.acct = s.acct
where p.project = @Project and p.pjt_entity  = 'na' and s.acct_overmax <> '' 
)
--check to see if same overmax acct used more than 1X for project 
select COUNT(acct) from wrk_PJPROJMX
group by acct
having COUNT(acct)>1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJMX_DupOverMax] TO [MSDSL]
    AS [dbo];

