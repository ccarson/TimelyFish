CREATE TABLE [dbo].[cft_ADDRESS] (
    [AddressID]       INT          IDENTITY (50000, 1) NOT FOR REPLICATION NOT NULL,
    [EmailAddress]    VARCHAR (50) NULL,
    [Address1]        VARCHAR (30) NULL,
    [Address2]        VARCHAR (30) NULL,
    [City]            VARCHAR (30) NULL,
    [State]           VARCHAR (2)  NULL,
    [Zip]             VARCHAR (10) NULL,
    [Country]         VARCHAR (30) CONSTRAINT [DF_cft_ADDRESS_Country] DEFAULT ('USA') NULL,
    [Longitude]       FLOAT (53)   NULL,
    [Latitude]        FLOAT (53)   NULL,
    [County]          VARCHAR (30) NULL,
    [Township]        VARCHAR (30) NULL,
    [SectionNbr]      VARCHAR (30) NULL,
    [Range]           VARCHAR (30) NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_ADDRESS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_ADDRESS] PRIMARY KEY CLUSTERED ([AddressID] ASC) WITH (FILLFACTOR = 90)
);

