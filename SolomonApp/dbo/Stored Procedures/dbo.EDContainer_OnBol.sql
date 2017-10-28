 Create Proc EDContainer_OnBol @BolNbr varchar(20) As
Select * From EDContainer Where BolNbr = @BolNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_OnBol] TO [MSDSL]
    AS [dbo];

