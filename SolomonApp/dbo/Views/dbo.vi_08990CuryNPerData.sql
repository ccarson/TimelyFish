 

Create View vi_08990CuryNPerData as

Select

BaseCuryDec = c.DecPl,
PerToPost = a.PerNbr,
CurrYr = SUBSTRING(a.PerNbr,1, 4)

From glsetup g, currncy c, arsetup a
where g.basecuryid = c.curyid



 
