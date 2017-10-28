create procedure WS_ShipperTermsExists @parm1 varchar (15), @parm2 varchar(2)   as  
	SELECT Count(*) DifferentShipperTerms
	  FROM SOShipHeader
	 WHERE OrdNbr = @parm1 
	   AND TermsID <> @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_ShipperTermsExists] TO [MSDSL]
    AS [dbo];

