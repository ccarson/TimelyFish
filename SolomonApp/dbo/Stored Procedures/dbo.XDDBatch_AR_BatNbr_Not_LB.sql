CREATE PROCEDURE XDDBatch_AR_BatNbr_Not_LB
	@BatNbr		varchar(10)
AS
  	Select 		*
  	FROM 		XDDBatch
  	WHERE 		Module = 'AR'
  			and FileType <> 'L'
  			and BatNbr = @BatNbr
