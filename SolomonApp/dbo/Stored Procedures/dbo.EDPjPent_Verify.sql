 Create Proc EDPjPent_Verify @ProjectId varchar(16), @TaskId varchar(32) As
Select Count(*) From PjPent Where Project = @ProjectId And pjt_entity = @TaskId


