CREATE procedure WSL_TMEmployeeInfo
 @page  int  -- ignored
 ,@size  int  -- ignored
 ,@sort   nvarchar(200) -- ignored
 ,@parm1 varchar (10) -- employee
 ,@parm2 smalldatetime -- date to check
 AS
  SET NOCOUNT ON
  SELECT top 1 ep_id05 as [PayType] FROM PJEMPPJT where employee = @parm1 and project = 'na' and effect_date <= @parm2 order by employee, project, effect_date desc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TMEmployeeInfo] TO [MSDSL]
    AS [dbo];

