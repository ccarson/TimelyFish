 create procedure PJLABDIS_sIK0 as
select * from PJLABDIS
where docnbr = 'Z'
and hrs_type = 'Z'
and linenbr = 9
and status_2 = 'Z'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDIS_sIK0] TO [MSDSL]
    AS [dbo];

