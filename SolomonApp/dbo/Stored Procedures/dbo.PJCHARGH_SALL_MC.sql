 create procedure PJCHARGH_SALL_MC @parm1 varchar(100), @parm2 varchar (10)  
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
select * from PJCHARGH
where   PJCHARGH.CpnyId in

(select cpnyid from dbo.UserAccessCpny(@parm1))  
and  batch_id LIKE @parm2
order by batch_id



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCHARGH_SALL_MC] TO [MSDSL]
    AS [dbo];

