create proc compsec_dbname_pv @parm1 char(47), @parm2 char(47), @parm3 char(5), @parm4 char(1),@parm5 varchar(50),@parm6 varchar(10)
as
Select distinct cpnyid, CpnyName from vs_share_pvcpny where (@parm1 = 'SYSADMIN' or (userid = @parm2 and scrn = @parm3 and seclevel >= @parm4)) and databasename = @parm5 and cpnyid Like @parm6 order by cpnyid


GO
GRANT CONTROL
    ON OBJECT::[dbo].[compsec_dbname_pv] TO [MSDSL]
    AS [dbo];

