
CREATE PROCEDURE XDDMCB_APDoc_Vendor
	@BatNbr		    varchar( 10 ),
	@RefNbr			varchar( 10 )

AS
    Select 		* 
    FROM APDoc D (nolock) LEFT OUTER JOIN Vendor V (nolock)
    			ON D.VendID = V.VendID
    WHERE  		BatNbr = @BatNbr
    			and RefNbr LIKE @RefNbr
    ORDER BY  	RefNbr
