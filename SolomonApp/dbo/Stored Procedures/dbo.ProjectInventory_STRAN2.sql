 CREATE PROCEDURE ProjectInventory_STRAN2 AS

   SELECT i.*, p.*
     FROM InvProjAlloc i JOIN PJ_Account p
            ON i.WIP_COGS_Acct = p.gl_acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjectInventory_STRAN2] TO [MSDSL]
    AS [dbo];

