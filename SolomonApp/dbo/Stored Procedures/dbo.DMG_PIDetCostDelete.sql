 CREATE PROCEDURE DMG_PIDetCostDelete
	@PIID 	varchar(10),
	@Number int,
	@LineRef varchar(5)
AS
	DELETE FROM PIDetCost
	WHERE PIID LIKE @PIID AND
		Number LIKE @Number AND
		LineRef LIKE @LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


