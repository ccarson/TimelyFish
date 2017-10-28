CREATE PROCEDURE CF345p_AddMill @parm1 varchar (10) as 

	insert into cftMillReports (BioReportDate,BioReportTime,BioReportUserid,HoldReportDate,HoldReportTime,HoldReportUserID,
	 MillID, MillName, RegReportDate, RegReportTime, RegReportUserId, TollReportDate, TollReportTIme, TollReportUserId) 
	
	Select '01/01/1900','','','01/01/1900','','',@parm1,contactname,'01/01/1900','','','01/01/1900','',''
	
	FROM cfvMills WHERE
	@parm1 = millid
