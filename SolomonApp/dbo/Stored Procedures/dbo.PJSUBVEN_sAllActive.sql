 create procedure PJSUBVEN_sAllActive @parm1 varchar (15)  as
select * from PJSUBVEN
where vendid like @parm1
and status =    'A'
order by vendid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBVEN_sAllActive] TO [MSDSL]
    AS [dbo];

