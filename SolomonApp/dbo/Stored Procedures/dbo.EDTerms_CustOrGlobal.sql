 Create Proc EDTerms_CustOrGlobal @TermsId varchar(2), @CustId varchar(15) As
Select * From EDTerms Where TermsId = @TermsId And CustId In (@CustId, '*') Order By TermsType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDTerms_CustOrGlobal] TO [MSDSL]
    AS [dbo];

