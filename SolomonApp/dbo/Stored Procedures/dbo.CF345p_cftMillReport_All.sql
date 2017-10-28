CREATE PROCEDURE CF345p_cftMillReport_All  @parm1 varchar (10) as

select * FROM cftMillReports
WHERE millid like @parm1
order by millid

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF345p_cftMillReport_All] TO [MSDSL]
    AS [dbo];

