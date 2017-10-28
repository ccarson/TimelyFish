
CREATE PROCEDURE XDDBatch_PerPost_PP_UnDeposited
  	@PerPost	varchar( 6 ),
  	@APVoid		smallint		-- right now only checknig on AP batches, need to add PR
AS
  	Select TOP 1	B.*, X.*
  	FROM 		Batch B (nolock) LEFT OUTER JOIN XDDBatch X (nolock)
  			ON 'AP' = X.Module and B.BatNbr = X.BatNbr LEFT OUTER JOIN APDoc A (nolock)
	  		ON B.BatNbr = A.BatNbr LEFT OUTER JOIN XDDBank K (nolock)
			ON A.CpnyID = K.CpnyID and A.Acct = K.Acct and A.Sub = K.Sub
  	WHERE 		B.Module = 'AP'
  			and B.Status = 'U'
  			and ( (@APVoid = 0 and B.EditScrnNbr IN ('03620', '03030')) or			-- Computer, Manual
  			      (@APVoid = 1 and B.EditScrnNbr IN ('03620', '03030', '03040'))		-- + Void
			    )
  			and B.PerPost >= @PerPost
			and K.PPFormatID Is Not Null	-- don't include Acct/Subs that are not setup
			and K.PPFormatID <> ''
	     		and ((X.FileType IS NOT NULL and X.FileType = 'P')  or X.FileType IS NULL)  
			and ((X.FileType IS NOT NULL and X.DepDate = 0)     or X.FileType IS NULL)
  	ORDER BY 	B.Module, B.BatNbr DESC
