Create Procedure [dbo].[pUpdateMaxBarnCapacity]
 
as

UPDATE Barn
	SET MaxCap=(StdCap * 1.05)
	


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdateMaxBarnCapacity] TO [MSDSL]
    AS [dbo];

