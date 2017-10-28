 Create Procedure SCM_GetARDocs_Terms
	@parmBatNbr Varchar(10)
	AS
	SELECT * FROM ARdoc,Terms (NoLock)
		Where
			ArDoc.Batnbr = @parmBatNbr
			And
			Ardoc.Terms = Terms.TermsID
			And
			Refnbr LIKE '%'
		ORDER BY
			Refnbr


