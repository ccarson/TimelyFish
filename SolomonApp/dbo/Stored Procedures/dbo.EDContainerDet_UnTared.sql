 Create Proc EDContainerDet_UnTared @CpnyId varchar(10), @ShipperId varchar(15) As
Select A.*,B.LineRef From EDContainer A Inner Join EDContainerDet B On A.ContainerId = B.ContainerId
 Where A.CpnyId = @CpnyId And A.ShipperId = @ShipperId And A.TareFlag = 0 And LTrim(A.TareId) = ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_UnTared] TO [MSDSL]
    AS [dbo];

