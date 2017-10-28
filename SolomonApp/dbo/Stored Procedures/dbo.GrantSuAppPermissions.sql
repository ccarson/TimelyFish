 CREATE PROCEDURE GrantSuAppPermissions
AS
EXEC ('grant select on [Snote] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [Terms] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [ARTran] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [ARDoc] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [Customer] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select, insert on [ARPrintQueue] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [vp_24630wrk] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select, insert on [wrkcmugl] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [PurchOrd] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [PRCheckTran] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [SOShipHeader] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [SOHeader] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [PJInvHdr] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [SMServCall] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [SMInvoice] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [Employee] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [SOType] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select on [pjproj] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select, insert, delete, update on [vs_AcctSub] to [07718158D19D4f5f9D23B55DBF5DF1]')
EXEC ('grant select, insert, delete, update on [vs_AcctXref] to [07718158D19D4f5f9D23B55DBF5DF1]')

EXEC GrantBFGRoup


GO
GRANT CONTROL
    ON OBJECT::[dbo].[GrantSuAppPermissions] TO [MSDSL]
    AS [dbo];

