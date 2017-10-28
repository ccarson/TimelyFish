CREATE TABLE [dbo].[Phone] (
    [PhoneID]   INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PhoneNbr]  VARCHAR (10) NOT NULL,
    [Extension] VARCHAR (50) NULL,
    [SpeedDial] INT          NULL,
    CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED ([PhoneID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [PhoneNumber]
    ON [dbo].[Phone]([PhoneNbr] ASC) WITH (FILLFACTOR = 90);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Phone] TO [SE\ITDevelopers]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Phone] TO [hybridconnectionlogin_permissions]
    AS [dbo];
