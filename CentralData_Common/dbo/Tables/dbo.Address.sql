CREATE TABLE [dbo].[Address] (
    [AddressID]  INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TempID]     CHAR (50)    NULL,
    [Address1]   VARCHAR (30) NULL,
    [Address2]   VARCHAR (30) NULL,
    [City]       VARCHAR (30) NULL,
    [State]      VARCHAR (3)  NULL,
    [Zip]        VARCHAR (10) NULL,
    [Country]    VARCHAR (30) CONSTRAINT [DF_Address_Country] DEFAULT ('USA') NULL,
    [Longitude]  FLOAT (53)   NULL,
    [Latitude]   FLOAT (53)   NULL,
    [County]     VARCHAR (30) NULL,
    [Township]   VARCHAR (30) NULL,
    [SectionNbr] VARCHAR (30) NULL,
    [Range]      VARCHAR (30) NULL,
    CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED ([AddressID] ASC) WITH (FILLFACTOR = 90)
);
GO
GRANT SELECT
    ON OBJECT::[dbo].[Address] TO [hybridconnectionlogin_permissions]
    AS [dbo];
