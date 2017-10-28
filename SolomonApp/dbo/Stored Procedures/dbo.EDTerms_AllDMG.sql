 /****** Object:  Stored Procedure dbo.EDTerms_All    Script Date: 5/28/99 1:17:46 PM ******/
CREATE Proc EDTerms_AllDMG @Parm1 varchar(2), @parm2  varchar(15) As
select * from EDTerms where TermsId like @parm1 and CustId like @parm2 order by TermsId, CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDTerms_AllDMG] TO [MSDSL]
    AS [dbo];

