
create proc compsec_pv @parm1 char(47), @parm2 char(47), @parm3 char(5), @parm4 char(1),@parm5 varchar(10)
as
select distinct cpnyname,databasename,active,cpnyid from vs_share_pvcpny where (@parm1 = 'SYSADMIN' or (userid = @parm2 and scrn = @parm3 and seclevel >= @parm4)) and cpnyid like @parm5 order by cpnyid


GO
GRANT CONTROL
    ON OBJECT::[dbo].[compsec_pv] TO [MSDSL]
    AS [dbo];

