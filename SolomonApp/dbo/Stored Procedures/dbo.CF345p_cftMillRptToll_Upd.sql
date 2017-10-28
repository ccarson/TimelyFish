CREATE PROCEDURE CF345p_cftMillRptToll_Upd @parm1 varchar (10), @parm2 varchar(10) as 

UPDATE cftMillReports SET TollReportDate = GetDate(),
 TollReportTime = Right(convert(varchar(19), Getdate()),7), TollReportUserID = @parm2
WHERE millid = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF345p_cftMillRptToll_Upd] TO [MSDSL]
    AS [dbo];

