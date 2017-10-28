
CREATE PROCEDURE WSL_ProjectAttention
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Employee
 ,@parm2 varchar (10) -- CompanyID
AS
  SET NOCOUNT ON

  declare @tempScreen table
  (cpny varchar(10)
  ,[View] int
  ,[Update] int
  ,[Insert] int
  ,[Delete] int
  ,[Initialilzation] int
  )

  declare @tempWebService table
  ([AccessRights] int
  ,[MethodName] varchar(100)
  )

  declare @userId varchar(50)
  select @userId = user_id from PJEMPLOY where employee = @parm1

  Insert Into @tempScreen
  EXEC WSL_AccessScreenRights 0, 0, '', @parm2, @userId, 'MDCOCMD', ''
  Insert Into @tempWebService
  EXEC WSL_AccessWebSeviceRights 0, 0, '', @parm2, @userId, 'Microsoft.Dynamics.SL.CommunicatorService.ReadCommunicator', ''

select 

(select  count (*) from pjlabhdr where pjlabhdr.le_status = 'R' and pjlabhdr.employee = @parm1) [EntryRejects],
(select count (*) from PJEXPHDR where pjexphdr.status_1 = 'R' and pjexphdr.employee = @parm1) [ExpenseRejects],
(select count (*) from PJTIMHDR where pjtimhdr.th_status = 'R' and pjtimhdr.preparer_id = @parm1) [TimesheetRejects],
(
	(select count(*) from QQ_TEApproval where Approver = @parm1 and CompanyID = @parm2) +
	(select count(*) from PJREVHDR R inner join PJPROJ P on R.Project = P.project
		 where Approver = @parm1 and [status] = 'C' and P.CpnyId = @parm2) +
	(select count(*) from PJINVHDR where approver_id = @parm1 and CpnyId = @parm2 and [inv_status] = 'CO')
) [Approvals],
(select count(*) from QQ_LineApprovals where Approver = @parm1 and CompanyID = @parm2) [LineApprovals],
(select projExec from PJEMPLOY where employee = @parm1) [ExecApprovals],
(select count(*) from PJCOMMUN where (destination = @parm1 or destination = (select user_id from PJEMPLOY where employee = @parm1)) and msg_status = 'N') [NewMessages],
(select 
	case when exists (select * from @tempScreen) and exists (select * from @tempWebService) Then
		(select max(s.[View]) + max(w.[AccessRights]) from @tempScreen s, @tempWebService w)
	else 0
	end
) [ComViewRights]

