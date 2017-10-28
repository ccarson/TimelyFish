 create proc company_sec @parm1 char(47), @parm2 char(7), @parm3 char(1),@parm4 varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
if @parm1 = 'SYSADMIN'
select cpnyid
       from vs_company
else
 select cpnyid from vs_share_secCpny where userid = @parm1 and scrn = @parm2 and seclevel >= @parm3 and cpnyid like @parm4 order by cpnyid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[company_sec] TO [MSDSL]
    AS [dbo];

