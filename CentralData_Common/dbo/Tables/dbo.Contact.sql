CREATE TABLE [dbo].[Contact] (
    [ContactID]             INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ContactName]           VARCHAR (50)     NOT NULL,
    [ContactTypeID]         INT              NOT NULL,
    [Title]                 INT              NULL,
    [ContactFirstName]      VARCHAR (30)     NULL,
    [ContactMiddleName]     VARCHAR (30)     NULL,
    [ContactLastName]       VARCHAR (30)     NULL,
    [EMailAddress]          VARCHAR (50)     NULL,
    [EmployeeFlag]          SMALLINT         DEFAULT ((0)) NULL,
    [VendorFlag]            SMALLINT         DEFAULT ((0)) NULL,
    [CustomerFlag]          SMALLINT         DEFAULT ((0)) NULL,
    [TranSchedMethodTypeID] INT              DEFAULT ((1)) NOT NULL,
    [VetFlag]               SMALLINT         DEFAULT ((0)) NULL,
    [StatusTypeID]          INT              DEFAULT ((1)) NULL,
    [SolomonContactID]      CHAR (6)         NULL,
    [ShortName]             CHAR (30)        NULL,
    [msrepl_tran_version]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [PQACertRequired]       VARCHAR (3)      NULL,
    [MobileAccess]          SMALLINT         NULL,
    CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ContactName]
    ON [dbo].[Contact]([ContactName] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [ShortName]
    ON [dbo].[Contact]([ShortName] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_ContactTypeID]
    ON [dbo].[Contact]([ContactTypeID] ASC, [ContactName] ASC, [ContactID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Contact] TO [hybridconnectionlogin_permissions]
    AS [dbo];
