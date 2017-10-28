
CREATE PROCEDURE XDDBatch_PerPost_AP_UnDeposited
  	@PerPost	varchar(6)
AS
  	Select TOP 1	*
  	FROM 		Batch B (nolock) LEFT OUTER JOIN XDDBatch X (nolock)
  			ON 'AP' = X.Module and B.BatNbr = X.BatNbr
  	WHERE 		B.Module = 'AP'
  			and (Select count(*) from APDoc A (nolock) where A.BatNbr = B.BatNbr and A.Status IN ('C','O')) > 0
  			and ( (B.EditScrnNbr = '03620' and B.Status = 'U')
  			       or 
  			      (B.EditScrnNbr = '03030' and b.OrigScrnNbr = 'DD520' and B.Status = 'H')
  			    )	
  			and B.PerPost >= @PerPost
	     		and ((X.FileType IS NOT NULL and X.FileType IN ('E', 'W')) or X.FileType IS NULL)  
			and ((X.FileType IS NOT NULL and X.DepDate = 0)            or X.FileType IS NULL)
  	ORDER BY 	B.Module, B.BatNbr DESC

