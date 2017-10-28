 create procedure PJSUBVEN_sall @parm1 varchar (15)  as
select * from PJSUBVEN
where vendid like @parm1
order by vendid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBVEN_sall] TO [MSDSL]
    AS [dbo];

