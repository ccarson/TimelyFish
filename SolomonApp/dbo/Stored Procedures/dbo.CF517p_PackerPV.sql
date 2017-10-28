Create Procedure CF517p_PackerPV @parm1 varchar (15), @parm2 varchar(6) as 
    Select * from cftPacker p
	JOIN cftContact c on p.ContactID=c.ContactID Where p.CustID = @parm1 and p.ContactID like @parm2
	Order by c.ContactName
