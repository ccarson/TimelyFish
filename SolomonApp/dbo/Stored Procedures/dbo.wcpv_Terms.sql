 CREATE Procedure wcpv_Terms
	@TermsID VARCHAR(2) = '%'
as
	SELECT
		descr, termsid
	FROM
		terms
	WHERE
		termsid LIKE @TermsID
	ORDER BY Descr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[wcpv_Terms] TO [MSDSL]
    AS [dbo];

