Create Procedure CF517p_PackerPV @parm1 varchar (15), @parm2 varchar(6) as 
    Select p.*,c.* from cftPSContrPkr p
	JOIN cftContact c on p.PkrContactID=c.ContactID Where CustID = @parm1 and PkrContactID like @parm2
	Order by c.ContactName
