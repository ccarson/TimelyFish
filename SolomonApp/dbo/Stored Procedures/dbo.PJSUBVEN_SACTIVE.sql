 create procedure PJSUBVEN_SACTIVE @parm1 varchar (15)  as
select * from PJSUBVEN
where vendid =    @parm1
and status =    'A'
order by vendid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBVEN_SACTIVE] TO [MSDSL]
    AS [dbo];

