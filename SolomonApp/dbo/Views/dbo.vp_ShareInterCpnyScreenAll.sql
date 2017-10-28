 



CREATE VIEW vp_ShareInterCpnyScreenAll AS

/***** Created by Jason Hong on 8/31/98 *****/
/***** Last Modified by Chuck Schroeder on 10/09/98 at 10:10am *****/

SELECT v.FromCpny, v.ToCpny, v.Screen, v.Module,
	FromAcct = COALESCE (i3.FromAcct, i2.FromAcct, i1.FromAcct),
	ToAcct = COALESCE (i3.ToAcct, i2.ToAcct, i1.ToAcct), 
	FromSub = COALESCE (i3.FromSub, i2.FromSub, i1.FromSub), 
	ToSub = COALESCE (i3.ToSub, i2.ToSub, i1.ToSub)
FROM vp_ShareCpnyScreen v 
	LEFT OUTER JOIN vs_InterCompany i1 ON
		i1.Screen = "ALL" AND i1.Module = "**" AND 
		v.FromCpny = i1.FromCompany AND v.ToCpny = i1.ToCompany
	LEFT OUTER JOIN vs_InterCompany i2 ON 
		i2.Screen = "ALL" AND i2.Module = v.Module AND 
		v.FromCpny = i2.FromCompany AND v.ToCpny = i2.ToCompany
	LEFT OUTER JOIN vs_InterCompany i3 ON 
		i3.Screen = SUBSTRING(v.Screen, 1, 5) AND 
		v.FromCpny = i3.FromCompany AND v.ToCpny = i3.ToCompany
WHERE (COALESCE (i3.FromAcct, i2.FromAcct, i1.FromAcct)) IS NOT NULL



 
