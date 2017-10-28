
CREATE PROCEDURE XDDBatch_PerPost_AR_PV
  	@PerPost	varchar( 6 ),
  	@CustID		varchar( 15 ),
  	@BatNbr		varchar( 10 )
AS
  	Select 		B.*, X.*
  	from 		Batch B LEFT OUTER JOIN XDDBatch X
  			ON  X.Module = 'AR' and X.FileType = 'R' and B.BatNbr = X.BatNbr RIGHT OUTER JOIN ARDoc D
			ON B.BatNbr = D.BatNbr
  	where 		B.Module = 'AR'
  			and B.Status IN ('U', 'P')
  			and B.EditScrnNbr = '08010'
  			and B.PerPost >= @PerPost
			and D.CustID = @CustID
	     		and B.BatNbr LIKE @BatNbr
  	order by 	B.BatNbr DESC, X.BatSeq
