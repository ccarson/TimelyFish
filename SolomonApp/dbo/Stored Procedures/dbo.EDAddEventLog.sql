 CREATE Proc EDAddEventLog @InternetAddress varchar(21), @PID varchar(10), @SessionCntr smallint, @UserId varchar(47), @FileName varchar(254) As
Declare @ExecDate smalldatetime
Declare @ExecTime smalldatetime
Declare @wrkStr varchar(10)
Set @ExecDate = GetDate()
Set @wrkstr = Convert(varchar,@ExecDate,108)
Set @ExecTime = Convert(smalldatetime,@wrkstr)
Set @wrkstr = Convert(varchar,@ExecDate,101)
Set @ExecDate = Convert(smalldatetime,@wrkstr)
Insert Into PStatus (ExecDate, ExecTime, InternetAddress, PID, ProcTime, SessionCntr, Status,
  UserId, ViewDate, zFileName, tstamp) Values (@ExecDate, @ExecTime, @InternetAddress, @PID,
  1, @SessionCntr, 'E', @UserId, '01/01/1900', @FileName, NULL)


