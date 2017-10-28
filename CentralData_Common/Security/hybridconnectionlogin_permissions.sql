CREATE ROLE [hybridconnectionlogin_permissions]
    AUTHORIZATION [dbo];


GO
ALTER ROLE [hybridconnectionlogin_permissions] ADD MEMBER [HybridConnectionLogin];

