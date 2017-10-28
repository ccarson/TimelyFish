 Create Proc EDContainer_AllOnTare @TareId varchar(10) As
Select * From EDContainer Where TareId = @TareId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_AllOnTare] TO [MSDSL]
    AS [dbo];

