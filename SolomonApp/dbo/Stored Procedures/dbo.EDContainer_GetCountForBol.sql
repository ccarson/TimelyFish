 CREATE Proc EDContainer_GetCountForBol @BolNbr varchar(20) As
Select count(*) From EDContainer Where BolNbr = @BolNbr And TareFlag = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_GetCountForBol] TO [MSDSL]
    AS [dbo];

