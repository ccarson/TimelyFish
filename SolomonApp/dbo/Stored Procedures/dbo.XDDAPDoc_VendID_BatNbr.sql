CREATE PROCEDURE XDDAPDoc_VendID_BatNbr 
	@parm1 	varchar( 15 ), 
	@parm2 	varchar( 10 ) 
AS
  Select 	* 
  FROM		APDoc 
  WHERE		VendID LIKE @parm1 
  		and DocClass = 'C' 
  		and ((Rlsed = 1 and DocType = 'CK')
  			or
  		     (DocType IN ('HC','EP'))			-- Allow Releaed batches to process... should give warning...
  		    )	
  		and BatNbr = @parm2 
  		and Status <> 'V'
  ORDER BY	VendID, DocClass, Rlsed, BatNbr
