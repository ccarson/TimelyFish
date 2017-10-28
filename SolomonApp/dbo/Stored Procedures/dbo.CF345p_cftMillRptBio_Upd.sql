CREATE PROCEDURE CF345p_cftMillRptBio_Upd @parm1 varchar (10), @parm2 varchar(10) as 

UPDATE cftMillReports SET BioReportDate = GetDate(),
 BioReportTime = Right(convert(varchar(19), Getdate()),7), BioReportUserID = @parm2
WHERE millid = @parm1
