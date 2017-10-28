 Create Proc EDTerms_GlobalCodes @TermsId varchar(2) As
Select TermsBasisCode, TermsTypeCode From EDTerms Where TermsId = @TermsId And TermsType = 'G'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDTerms_GlobalCodes] TO [MSDSL]
    AS [dbo];

