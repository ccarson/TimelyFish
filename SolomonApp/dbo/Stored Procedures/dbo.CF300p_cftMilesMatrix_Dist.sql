Create Procedure CF300p_cftMilesMatrix_Dist @parm1 varchar (6), @parm2 varchar (6) as 
    Select Max(Case When c.RoadRestr = 0 Then m.OneWayMiles Else m.RestrictOneWayMiles End) 
	from cftMilesMatrix m Join cftFOSetUp c on 1 = 1 Where m.AddressIDFrom = @parm1 and m.AddressIDTo = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftMilesMatrix_Dist] TO [MSDSL]
    AS [dbo];

