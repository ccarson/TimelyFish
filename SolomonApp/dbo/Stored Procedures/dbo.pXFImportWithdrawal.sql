
CREATE    PROCEDURE pXFImportWithdrawal
	 @parm1 As varchar(10)
 AS 
 SELECT f.*
	FROM cftFeedOrder f
	JOIN cftFeedOrder f2 ON f.ContactID=f2.ContactID 
	AND f.BarnNbr=f2.BarnNbr AND f.BinNbr=f2.BinNbr AND f.PigGroupID=f2.PigGroupID
	AND f.Status='C' AND f2.DateDel<>'1900-01-01' AND f2.DateDel>f.DateDel AND f2.OrdNbr=@parm1
	Order by f.DateDel Desc



