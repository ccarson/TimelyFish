 Create Proc EDSOSched_GetSDQShipTo @CpnyId varchar(10), @OrdNbr varchar(15), @LineRef varchar(5) As
Select Case A.MarkFor When 0 Then A.ShipToId Else B.MarkForId End From SOSched A Left Outer Join
SOSchedMark B On A.CpnyId = B.CpnyId And A.OrdNbr = B.OrdNbr And A.LineRef = B.LineRef And
A.SchedRef = B.SchedRef Where A.CpnyId = @CpnyId And A.OrdNbr = @OrdNbr And A.LineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOSched_GetSDQShipTo] TO [MSDSL]
    AS [dbo];

