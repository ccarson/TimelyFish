 Create	Procedure SCM_10990_Archive_Job
		@Table		VarChar(60),
		@ArchTable	VarChar(60),
		@SchedJobID	UniqueIdentifier,
		@JobID		UniqueIdentifier Output
As
	Set	NoCount On
	Declare	@DBName		VarChar(256),
		@JobName	VarChar(256),
		@ClustInd	VarChar(256),
		@IndName	VarChar(256),
		@Clustered	Bit,
		@Unique		Bit,
		@IndID		SmallInt,
		@ColName	VarChar(256),
		@KeyNo		SmallInt,
		@StepName	VarChar(256),
		@Indexes	VarChar(2560)

	Declare	@SqlCmd		nvarchar(3200),
		@RowCnt		Integer

	Select	@DBName = DB_Name(), @JobName = 'Archive ' + @Table

	Select	@IndName = '', @Clustered = 0, @Unique = 0, @IndID = 0, @ColName = '', @KeyNo = 0, @Indexes = ''

	If	Exists(Select Name From msdb..sysJobs_View (NoLock) Where Name = @JobName)
	Begin
		Exec	msdb..sp_delete_job @Job_Name = @JobName
	End

	Exec	msdb..sp_add_job @Job_Name = @JobName, @Notify_Level_EventLog = 3,
		@Job_ID = @JobID OutPut

	Select	@StepName = 'Drop ' + @Table + ' Indexes'

	Exec	msdb..sp_add_jobstep @Job_ID = @JobID, @Step_ID = 1,
		@Step_Name = @StepName, @Command = '', @On_Fail_Action = 4, @On_Fail_Step_Id = 7,
		@Database_Name = @DBName

	Select	@StepName = 'Drop ' + @ArchTable + ' Indexes'

	Exec	msdb..sp_add_jobstep @Job_ID = @JobID, @Step_ID = 2,
		@Step_Name = @StepName, @Command = '', @On_Fail_Action = 4, @On_Fail_Step_Id = 7,
		@Database_Name = @DBName

	Exec	msdb..sp_add_jobstep @Job_ID = @JobID, @Step_ID = 3,
		@Step_Name = 'Truncate Log 1', @Command = 'SCM_Truncate_Log',
		@Database_Name = @DBName

	Select	@StepName = 'Move ' + @Table + ' Records To ' + @ArchTable,
		@SqlCmd = 'SCM_10990_Archive_' + @Table

	Exec	msdb..sp_add_jobstep @Job_ID = @JobID, @Step_ID = 4,
		@Step_Name = @StepName, @Command = @SqlCmd,
		@Database_Name = @DBName

	Exec	msdb..sp_add_jobstep @Job_ID = @JobID, @Step_ID = 5,
		@Step_Name = 'Truncate Log 2', @Command = 'SCM_Truncate_Log',
		@Database_Name = @DBName

	Select	@StepName = 'Delete Retired ' + @Table + ' Records',
		@SqlCmd = 'SCM_10990_Delete_Retired_' + @Table

	Exec	msdb..sp_add_jobstep @Job_ID = @JobID, @Step_ID = 6,
		@Step_Name = @StepName, @Command = @SqlCmd,
		@Database_Name = @DBName

/*	INTran */
	Select	@IndName = Ind.Name,
		@IndID = Ind.IndID,
		@Clustered = Case When (Ind.Status & 16) <> 0 Then 1 Else 0 End,
		@Unique = Case When (Ind.Status & 2) <> 0 Then 1 Else 0 End
		From	SysObjects Obj (NoLock) Inner Join SysIndexes Ind (NoLock)
			On Obj.ID = Ind.ID
		Where	Obj.Name = @Table
			And (Ind.Status & 16) <> 0
			And (Ind.Status & 8388608) = 0
		Order	By Ind.Name

	Set	@RowCnt = @@RowCount

	If	(@RowCnt > 0)
	Begin
		Set	@ClustInd = @IndName

		Select	@SqlCmd = 'Create ' + Case When @Unique = 1 Then 'Unique' Else '' End + ' Clustered Index '
			+ @IndName + ' On ' + @Table + ' ('

		Select	@ColName = '', @KeyNo = 0, @RowCnt = 1

		While	(@RowCnt > 0)
		Begin

			Select	Top 1
				@ColName = Col.Name,
				@KeyNo = Keys.KeyNo
				From	SysObjects Obj (NoLock) Inner Join SysIndexKeys Keys (NoLock)
					On Obj.ID = Keys.ID
					Inner Join SysColumns Col (NoLock)
					On Obj.ID = Col.ID
					And Keys.ColID = Col.ColID
				Where	Obj.Name = @Table
					And Keys.IndID = @IndID
					And Keys.KeyNo > @KeyNo
				Order By Keys.KeyNo
			Set	@RowCnt = @@RowCount
			If	(@RowCnt > 0)
			Begin
				Select	@SqlCmd = @SqlCmd + Case When @KeyNo > 1 Then ', ' Else '' End + @ColName
			End
		End
		Select	@SqlCmd = @SqlCmd + ')' + Char(13) + 'Go' + Char(13)
	End

	Select	@IndName = '', @Unique = 0, @IndID = 0, @ColName = '', @KeyNo = 0, @RowCnt = 1

	While (@RowCnt > 0)
	Begin
		Select	Top 1
			@IndName = Ind.Name,
			@IndID = Ind.IndID,
			@Unique = Case When (Ind.Status & 2) <> 0 Then 1 Else 0 End
			From	SysObjects Obj (NoLock) Inner Join SysIndexes Ind (NoLock)
				On Obj.ID = Ind.ID
			Where	Obj.Name = @Table
				And Ind.Name > @IndName
				And (Ind.Status & 16) = 0
				And (Ind.Status & 8388608) = 0
			Order	By Ind.Name

		Set	@RowCnt = @@RowCount

		If	(@RowCnt > 0)
		Begin
			Set	@Indexes = @Indexes + Case When Len(@Indexes) = 0 Then '' Else ', ' End
				+ @Table + '.' + @IndName

			Select	@SqlCmd = @SqlCmd + 'Create ' + Case When @Unique = 1 Then 'Unique' Else '' End + ' Index '
				+ @IndName + ' On ' + @Table + ' ('

			Select	@ColName = '', @KeyNo = 0, @RowCnt = 1

			While	(@RowCnt > 0)
			Begin
				Select	Top 1
					@ColName = Col.Name,
					@KeyNo = Keys.KeyNo
					From	SysObjects Obj (NoLock) Inner Join SysIndexKeys Keys (NoLock)
						On Obj.ID = Keys.ID
						Inner Join SysColumns Col (NoLock)
						On Obj.ID = Col.ID
						And Keys.ColID = Col.ColID
					Where	Obj.Name = @Table
						And Keys.IndID = @IndID
						And Keys.KeyNo > @KeyNo
					Order By Keys.KeyNo

				Set	@RowCnt = @@RowCount

				If	(@RowCnt > 0)
				Begin
					Select	@SqlCmd = @SqlCmd + Case When @KeyNo > 1 Then ', ' Else '' End + @ColName
				End
			End

			Select	@SqlCmd = @SqlCmd + ')' + Char(13) + 'Go' + Char(13)
			Set	@RowCnt = 1
		End

	End

	Select	@StepName = 'Rebuild ' + @Table + ' Indexes',
		@SqlCmd = @SqlCmd + 'Update Statistics ' + @Table + Char(13) + 'Go' + Char(13)

	Exec	msdb..sp_add_jobstep @Job_ID = @JobID, @Step_ID = 7,
		@Step_Name = @StepName, @Command = @SqlCmd, @On_Fail_Action = 4, @On_Fail_Step_Id = 8,
		@Database_Name = @DBName

	Set	@Indexes = @Indexes + Case When Len(@Indexes) = 0 Then '' Else ', ' End
			+ @Table + '.' + @ClustInd

	Set 	@SqlCmd = 'Drop Index ' + @Indexes

	Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 1, @Command = @SqlCmd

	Select	@IndName = '', @Clustered = 0, @Unique = 0, @IndID = 0, @ColName = '',
		@KeyNo = 0, @Indexes = '', @SqlCmd = '', @ClustInd = ''

/*	INArchTran */
	Select	@IndName = Ind.Name,
		@IndID = Ind.IndID,
		@Clustered = Case When (Ind.Status & 16) <> 0 Then 1 Else 0 End,
		@Unique = Case When (Ind.Status & 2) <> 0 Then 1 Else 0 End
		From	SysObjects Obj (NoLock) Inner Join SysIndexes Ind (NoLock)
			On Obj.ID = Ind.ID
		Where	Obj.Name = @ArchTable
			And (Ind.Status & 16) <> 0
			And (Ind.Status & 8388608) = 0
		Order	By Ind.Name

	Set	@RowCnt = @@RowCount

	If	(@RowCnt > 0)
	Begin
		Set	@ClustInd = @IndName

		Select	@SqlCmd = 'Create ' + Case When @Unique = 1 Then 'Unique' Else '' End + ' Clustered Index '
			+ @IndName + ' On ' + @ArchTable + ' ('

		Select	@ColName = '', @KeyNo = 0, @RowCnt = 1

		While	(@RowCnt > 0)
		Begin

			Select	Top 1
				@ColName = Col.Name,
				@KeyNo = Keys.KeyNo
				From	SysObjects Obj (NoLock) Inner Join SysIndexKeys Keys (NoLock)
					On Obj.ID = Keys.ID
					Inner Join SysColumns Col (NoLock)
					On Obj.ID = Col.ID
					And Keys.ColID = Col.ColID
				Where	Obj.Name = @ArchTable
					And Keys.IndID = @IndID
					And Keys.KeyNo > @KeyNo
				Order By Keys.KeyNo
			Set	@RowCnt = @@RowCount
			If	(@RowCnt > 0)
			Begin
				Select	@SqlCmd = @SqlCmd + Case When @KeyNo > 1 Then ', ' Else '' End + @ColName
			End
		End
		Select	@SqlCmd = @SqlCmd + ')' + Char(13) + 'Go' + Char(13)
	End

	Select	@IndName = '', @Unique = 0, @IndID = 0, @ColName = '', @KeyNo = 0, @RowCnt = 1

	While (@RowCnt > 0)
	Begin
		Select	Top 1
			@IndName = Ind.Name,
			@IndID = Ind.IndID,
			@Unique = Case When (Ind.Status & 2) <> 0 Then 1 Else 0 End
			From	SysObjects Obj (NoLock) Inner Join SysIndexes Ind (NoLock)
				On Obj.ID = Ind.ID
			Where	Obj.Name = @ArchTable
				And Ind.Name > @IndName
				And (Ind.Status & 16) = 0
				And (Ind.Status & 8388608) = 0
			Order	By Ind.Name

		Set	@RowCnt = @@RowCount

		If	(@RowCnt > 0)
		Begin
			Set	@Indexes = @Indexes + Case When Len(@Indexes) = 0 Then '' Else ', ' End
				+ @ArchTable + '.' + @IndName

			Select	@SqlCmd = @SqlCmd + 'Create ' + Case When @Unique = 1 Then 'Unique' Else '' End + ' Index '
				+ @IndName + ' On ' + @ArchTable + ' ('

			Select	@ColName = '', @KeyNo = 0, @RowCnt = 1

			While	(@RowCnt > 0)
			Begin
				Select	Top 1
					@ColName = Col.Name,
					@KeyNo = Keys.KeyNo
					From	SysObjects Obj (NoLock) Inner Join SysIndexKeys Keys (NoLock)
						On Obj.ID = Keys.ID
						Inner Join SysColumns Col (NoLock)
						On Obj.ID = Col.ID
						And Keys.ColID = Col.ColID
					Where	Obj.Name = @ArchTable
						And Keys.IndID = @IndID
						And Keys.KeyNo > @KeyNo
					Order By Keys.KeyNo

				Set	@RowCnt = @@RowCount

				If	(@RowCnt > 0)
				Begin
					Select	@SqlCmd = @SqlCmd + Case When @KeyNo > 1 Then ', ' Else '' End + @ColName
				End
			End

			Select	@SqlCmd = @SqlCmd + ')' + Char(13) + 'Go' + Char(13)
			Set	@RowCnt = 1
		End

	End

	Select	@StepName = 'Rebuild ' + @ArchTable + ' Indexes',
		@SqlCmd = @SqlCmd + 'Update Statistics ' + @ArchTable + Char(13) + 'Go' + Char(13)

	Exec	msdb..sp_add_jobstep @Job_ID = @JobID, @Step_ID = 8,
		@Step_Name = @StepName, @Command = @SqlCmd,
		@Database_Name = @DBName

	Set	@Indexes = @Indexes + Case When Len(@Indexes) = 0 Then '' Else ', ' End
			+ @ArchTable + '.' + @ClustInd

	Set 	@SqlCmd = 'Drop Index ' + @Indexes

	Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 2, @Command = @SqlCmd

	Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 1, @On_Success_Step_ID = 2,
		@On_Success_Action = 3

	Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 2, @On_Success_Step_ID = 3,
		@On_Success_Action = 3

	Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 3,
		@On_Fail_Step_ID = 7, @On_Fail_Action = 4,
		@On_Success_Step_ID = 4, @On_Success_Action = 3

	Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 4,
		@On_Fail_Step_ID = 7, @On_Fail_Action = 4,
		@On_Success_Step_ID = 5, @On_Success_Action = 3
		Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 5,
		@On_Fail_Step_ID = 7, @On_Fail_Action = 4,
		@On_Success_Step_ID = 6, @On_Success_Action = 3

	Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 6,
		@On_Fail_Step_ID = 7, @On_Fail_Action = 4,
		@On_Success_Step_ID = 7, @On_Success_Action = 3

	Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 7, @On_Success_Step_ID = 8,
		@On_Success_Action = 3

	If	@SchedJobID Is Not Null
	Begin
		Set	@SqlCmd = 'Declare	@JobID	UniqueIdentifier' + Char(13)
		Set	@SqlCmd = @SqlCmd
			+ 'Set	@JobID = Convert(UniqueIdentifier, ''' + CONVERT(VarChar(255), @SchedJobID) + ''')' + Char(13)
		Set	@SqlCmd = @SqlCmd
			+ 'Exec msdb..sp_Start_Job @Job_ID = @JobID' + Char(13)

		Exec	msdb..sp_add_jobstep @Job_ID = @JobID, @Step_ID = 9,
			@Step_Name = 'Call Next Job', @Command = @SqlCmd,
			@Database_Name = @DBName

		Exec	msdb..sp_update_jobstep @Job_ID = @JobID, @Step_ID = 8,
			@On_Success_Step_ID = 9, @On_Success_Action = 3
	End

	Exec	msdb..sp_Add_JobServer @Job_ID = @JobID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10990_Archive_Job] TO [MSDSL]
    AS [dbo];

