 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_03400Exception2 AS 

/****** File Name: 0315vp_03400Exception2.Sql					******/
/****** Last Modified by Scott Guan on 10/02/98 at 12:55 am 			******/
/****** Determine if records to be released violate exception rules. 	******/

/***** Vendor does not exist *****/
SELECT DISTINCT w.UserAddress, Module = "AP", d.BatNbr, Situation = -1
FROM WrkRelease w inner join APDoc d
on w.Module = "AP" AND w.BatNbr = d.BatNbr 
Left outer Join Vendor v
on d.vendid = v.vendid
WHERE  
	v.vendid is null
	
UNION

/***** Sales Tax ID does not exist *****/
SELECT DISTINCT w.UserAddress, Module = "AP", d.BatNbr, Situation = -2
from wrkrelease w INNER JOIN APdoc D 
ON w.Module = "AP" AND w.BatNbr = d.BatNbr 
left outer join 
salestax s1 on taxid00 = s1.taxid
left outer join 
salestax s2 on taxid01 = s2.taxid
left outer join 
salestax s3 on taxid02 = s3.taxid
left outer join 
salestax s4 on taxid03 = s4.taxid
where ((taxid00 <> ' ' and s1.taxid is null) 
   or (taxid01 <> ' ' and s2.taxid is null) 
   or (taxid02 <> ' ' and s3.taxid is null) 
   or (taxid03 <> ' ' and s4.taxid is null)) 

 

 
