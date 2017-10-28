Create Procedure CF517p_PackerContractDBNav @parm1 varchar (6), @parm2 varchar(6) as 
    Select * from cftPSContrPkr p
	JOIN cftContact c on p.PkrContactID=c.ContactID Where ContrNbr = @parm1 and PkrContactID like @parm2
	Order by c.ContactName
