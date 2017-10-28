 

CREATE VIEW vr_Refnbr_Doctype as
select refnbrtype=rtrim(refnbr) + '-' + rtrim(doctype), *
from ardoc 

 
