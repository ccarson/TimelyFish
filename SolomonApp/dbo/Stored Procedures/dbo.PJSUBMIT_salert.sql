 create procedure PJSUBMIT_salert
as
select * from PJSUBMIT
where    status1 = 'O' and
alert_type <> 'N'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBMIT_salert] TO [MSDSL]
    AS [dbo];

