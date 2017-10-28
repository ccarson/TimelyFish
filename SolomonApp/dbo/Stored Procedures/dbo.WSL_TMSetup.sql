
CREATE PROCEDURE WSL_TMSetup
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@UserID varchar(47)
 ,@WinUser varchar(85)
AS
  SET NOCOUNT ON

 	if (@UserID = '') Begin  set @UserID = (SELECT userID FROM vs_USERREC WHERE RecType = 'U' AND [WindowsUserAcct] = @WinUser AND defaultuser = 1) end

	IF EXISTS  (select * from PJCONTRL where PJCONTRL.control_code = 'PFT' and PJCONTRL.control_type = 'TM')
		Begin

			SELECT	ISNULL([MCActivated], 0) as [MCActivated],
					SUBSTRING(PJCONTRL.control_data,226,1) as [AuditOn],
					SUBSTRING(PJCONTRL1.control_data,1,1) as [ManagerReview],
					SUBSTRING(PJCONTRL2.control_data,1,1) as [PFTActive],
					SUBSTRING(PJCONTRL2.control_data,2,1) as [PFTOneDay],
					SUBSTRING(PJCONTRL2.control_data,3,1) as [PFTFutureNotAllowed],
					SUBSTRING(PJCONTRL2.control_data,4,1) as [PFTSource],
					SUBSTRING(PJCONTRL2.control_data,5,1) as [PFTHideTaskTotal],
					SUBSTRING(PJCONTRL2.control_data,6,1) as [PFTCorrecting],
					SUBSTRING(PJCONTRL2.control_data,228,1) as [WebEnabled],
					SUBSTRING(PJCONTRL.control_data,221, 3) AS [FirstDayOfWeek],
					SUBSTRING(PJCONTRL4.control_data, 3, 1) AS [LaborTransactions],
 	 	 	 	 	SUBSTRING(PJCONTRL.control_data,220, 1) AS [PostTimesheetsDirectly],
 	 	 	 	 	SUBSTRING(PJCONTRL3.control_data,1, 16) AS [ManagerCaption],
					PJEMPLOY.employee as [EmployeeID]
	 	 	 	FROM PJEMPLOY left join vs_mcsetup on 1=1, PJCONTRL,PJCONTRL as PJCONTRL1,PJCONTRL as PJCONTRL2,PJCONTRL as PJCONTRL3,PJCONTRL as PJCONTRL4 where 
				PJCONTRL.control_code = 'SETUP' and PJCONTRL.control_type = 'TM' and PJCONTRL1.control_code = 'MANAGER-REVIEW' and PJCONTRL1.control_type = 'PA' and PJCONTRL2.control_code = 'PFT' and PJCONTRL2.control_type = 'TM' and PJCONTRL3.control_code = 'FLEX-CAPTIONS' and PJCONTRL3.control_type = 'PA' and PJCONTRL4.control_code = 'SETUP1' and PJCONTRL4.control_type = 'TM'
				and PJEMPLOY.user_id = @UserID
		End
	Else
		Begin
			SELECT	ISNULL([MCActivated], 0) as [MCActivated],
					SUBSTRING(PJCONTRL.control_data,226,1) as [AuditOn],
					SUBSTRING(PJCONTRL1.control_data,1,1) as [ManagerReview],
					'N' as [PFTActive],
					'N' as [PFTOneDay],
					'N' as [PFTFutureNotAllowed],
					'S' as [PFTSource],
					'N' as [PFTHideTaskTotal],
					'' as [PFTCorrecting],
					'N' as [WebEnabled],
					SUBSTRING(PJCONTRL.control_data,221, 3) AS [FirstDayOfWeek],
		 	 	 	SUBSTRING(PJCONTRL.control_data,220, 3) AS [PostTimesheetsDirectly],
 	 	 	 	 	SUBSTRING(PJCONTRL3.control_data,1, 16) AS [ManagerCaption],
					SUBSTRING(PJCONTRL4.control_data, 3, 1) AS [LaborTransactions],
					PJEMPLOY.employee as [EmployeeID]
				FROM PJEMPLOY left join vs_mcsetup on 1=1, PJCONTRL,PJCONTRL as PJCONTRL1,PJCONTRL as PJCONTRL3, PJCONTRL as PJCONTRL4 where 
				PJCONTRL.control_code = 'SETUP' and PJCONTRL.control_type = 'TM' and PJCONTRL1.control_code = 'MANAGER-REVIEW' and PJCONTRL1.control_type = 'PA' and PJCONTRL3.control_code = 'FLEX-CAPTIONS' and PJCONTRL3.control_type = 'PA'
				and PJCONTRL4.control_code = 'SETUP1' and PJCONTRL4.control_type = 'TM'
				and PJEMPLOY.user_id = @UserID
		End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TMSetup] TO [MSDSL]
    AS [dbo];

