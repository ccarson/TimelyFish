Create Procedure xDamageHdr_DmgKey @parm1 varchar (2) as 
    Select * from xDamageHdr Where DmgKey Like @parm1 Order by DmgKey

GO
GRANT CONTROL
    ON OBJECT::[dbo].[xDamageHdr_DmgKey] TO [MSDSL]
    AS [dbo];

