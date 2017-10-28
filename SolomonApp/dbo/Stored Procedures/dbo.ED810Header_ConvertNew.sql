 CREATE Proc ED810Header_ConvertNew @CpnyId varchar(10) As
Select CpnyId, EDIInvId From ED810Header A Inner Join EDVInbound B On A.VendId = B.VendId
Where A.UpdateStatus = 'OK' And B.ConvMeth <> 'DNC' And CpnyId = @CpnyId Order By CuryId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED810Header_ConvertNew] TO [MSDSL]
    AS [dbo];

