 create procedure PJCHARGH_SALL @parm1 varchar (10)   as
select * from PJCHARGH
where    batch_id LIKE @parm1
order by batch_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCHARGH_SALL] TO [MSDSL]
    AS [dbo];

