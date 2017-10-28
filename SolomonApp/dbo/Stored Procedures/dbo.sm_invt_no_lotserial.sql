 CREATE PROCEDURE sm_invt_no_lotserial
	@parm1	varchar(30)
AS
	SELECT
		*
	FROM
		inventory
	WHERE
		invtid LIKE @parm1
		AND
		(StkItem = 0 OR LotSerTrack = 'NN')
	ORDER BY
		invtid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.


