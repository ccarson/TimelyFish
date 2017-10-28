Create VIEW vcfPacker
as 
Select c.* from 
cftPacker p 
JOIN cftContact c on p.ContactID=c.ContactID
