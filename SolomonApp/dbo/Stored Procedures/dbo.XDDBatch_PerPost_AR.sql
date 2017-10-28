
CREATE PROCEDURE XDDBatch_PerPost_AR
  	@PerPost	varchar(6)
AS
  	Select 		*
  	from 		Batch B LEFT OUTER JOIN XDDBatch X
  			ON 'AR' = X.Module and ('R' = X.FileType or 'X' = X.FileType) and B.BatNbr = X.BatNbr
  	where 		B.Module = 'AR'
  			and B.Status = 'U'
  			and B.EditScrnNbr IN ('08010', '08520', 'BIREG')	-- Include Finance Charges
  			and B.PerPost >= @PerPost
  	order by 	B.Module, B.BatNbr DESC, X.BatSeq

