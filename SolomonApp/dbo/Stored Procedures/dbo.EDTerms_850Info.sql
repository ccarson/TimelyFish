 CREATE Proc EDTerms_850Info @TermsId varchar(2) As
Select TermsId, DiscPct, DiscIntrv, DiscType, DueIntrv, DueType, Descr From Terms
Where TermsId = TermsId And ApplyTo In ('B','V')


