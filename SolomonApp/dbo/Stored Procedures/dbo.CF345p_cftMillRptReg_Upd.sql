CREATE PROCEDURE CF345p_cftMillRptReg_Upd @parm1 varchar (10), @parm2 varchar(10) as 

UPDATE cftMillReports SET RegReportDate = GetDate(),
 RegReportTime = Right(convert(varchar(19), Getdate()),7), RegReportUserID = @parm2
WHERE millid = @parm1
