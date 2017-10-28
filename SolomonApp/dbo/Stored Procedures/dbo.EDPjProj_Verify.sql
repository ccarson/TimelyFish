 Create Proc EDPjProj_Verify @ProjectId varchar(16) As
Select Count(*) From PjProj Where Project = @ProjectId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDPjProj_Verify] TO [MSDSL]
    AS [dbo];

