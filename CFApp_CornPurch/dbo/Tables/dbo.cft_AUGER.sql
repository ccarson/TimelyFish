CREATE TABLE [dbo].[cft_AUGER] (
    [AugerID]         INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Size]            VARCHAR (25) NOT NULL,
    [Active]          BIT          CONSTRAINT [DF_cft_AUGER_Active] DEFAULT (1) NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_AUGER_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_AUGER] PRIMARY KEY CLUSTERED ([AugerID] ASC) WITH (FILLFACTOR = 90)
);

