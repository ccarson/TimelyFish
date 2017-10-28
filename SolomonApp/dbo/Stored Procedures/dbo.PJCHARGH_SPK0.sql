 create procedure PJCHARGH_SPK0 @parm1 varchar (10)   as
select * from PJCHARGH
where    batch_id = @parm1
order by batch_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCHARGH_SPK0] TO [MSDSL]
    AS [dbo];

