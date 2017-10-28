 CREATE Proc EDTerms_FromEDI @DiscType varchar(1), @DiscIntrv smallint, @DiscPct float, @DueIntrv smallint As
Select Min(TermsId),Count(*) from Terms where DiscType = @DiscType and DiscIntrv = @DiscIntrv and DiscPct = @DiscPct and DueIntrv = @DueIntrv And TermsType = 'S'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDTerms_FromEDI] TO [MSDSL]
    AS [dbo];

