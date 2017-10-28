 CREATE Procedure EDContainer_BOL_CLASSData @parm1 varchar(20) As
Select a.Containerid, a.Weight, d.BOLClass, d.BOLDesc, d.HazMat
from EDContainer A Left Outer Join EDContainerDet B On A.ContainerId = B.ContainerId
Left Outer Join inventoryadg C On B.InvtId = C.InvtId Left Outer Join EDBOLCLASS D
On C.BOLClass = D.BOLClass where A.BOLNbr = @parm1 order by A.ContainerId, D.BOLClass



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_BOL_CLASSData] TO [MSDSL]
    AS [dbo];

