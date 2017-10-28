 CREATE PROCEDURE ItemSite_Invtid_SiteID2
	@Parm1 varchar (10),
	@parm2 varchar (30),
	@parm3 varchar (10)
AS
	SELECT *
	FROM ItemSite
        WHERE cpnyid = @Parm1
	  And InvtId like @parm2 AND
		SiteId like @parm3
        ORDER BY  InvtID, SiteId

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemSite_Invtid_SiteID2] TO [MSDSL]
    AS [dbo];

