CREATE PROCEDURE CF345p_cftMillRptHold_Upd @parm1 varchar (10), @parm2 varchar(10) as 

UPDATE cftMillReports SET HoldReportDate = GetDate(),
 HoldReportTime = Right(convert(varchar(19), Getdate()),7), HoldReportUserID = @parm2
WHERE millid = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF345p_cftMillRptHold_Upd] TO [MSDSL]
    AS [dbo];

