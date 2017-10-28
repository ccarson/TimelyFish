 CREATE PROCEDURE ADG_Terms_Applyto
	@parmApplyto 	 varchar(1),
	@parmSOBehavior  varchar(4),
	@parmSOBehavior2 varchar(4),
	@parmTermsID 	 varchar(2)
	AS

	SELECT 	*
	FROM 	Terms
	WHERE 	Applyto IN (@parmApplyto,'B')
	  AND 	((TermsType = 'S' and @parmSOBehavior in ('CM', 'DM', 'RMA'))
	  or 	(TermsType = TermsType and @parmSOBehavior2 NOT in ('CM', 'DM', 'RMA')))
	  AND 	TermsID LIKE @parmTermsID
	ORDER BY TermsID

-- Copyright 2001 by Microsoft Great Plains Solmon All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Terms_Applyto] TO [MSDSL]
    AS [dbo];

