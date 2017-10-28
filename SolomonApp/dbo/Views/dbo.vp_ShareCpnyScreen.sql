 

CREATE VIEW vp_ShareCpnyScreen AS

SELECT distinct FromCpny = c.FromCompany, ToCpny = c.ToCompany, Screen = s.Number, s.Module
FROM vs_InterCompany c, vs_Screen s
WHERE c.module = 'ZZ'


 
