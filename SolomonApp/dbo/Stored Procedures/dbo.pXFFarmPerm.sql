

CREATE   Proc pXFFarmPerm
as
select ct.ContactName, ct.ContactID
	FROM cftContact ct 
	Where ct.ContactTypeID='04' AND ct.StatusTypeID='1' 
        Order by ct.ContactName




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXFFarmPerm] TO [MSDSL]
    AS [dbo];

