 create proc compsec_access @parm1 char(47), @parm2 char(47), @parm3 char(5), @parm4 char(1), @parm5 varchar (30)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
select distinct cpnyid from vw_cpny_access 
where ('SYSADMIN' = @parm1 or (userid = @parm2 and scrn = @parm3 and seclevel >= @parm4)) and databasename = @parm5 order by cpnyid

