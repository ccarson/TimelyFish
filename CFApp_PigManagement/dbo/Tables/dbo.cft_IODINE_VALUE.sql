CREATE TABLE [dbo].[cft_IODINE_VALUE] (
    [IodineID]              INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TattooID]              INT              NOT NULL,
    [KillDate]              DATETIME         NULL,
    [IodineValueNir]        DECIMAL (10, 2)  NULL,
    [IodineValueBarrowAgee] DECIMAL (10, 2)  NULL,
    [HotCarcassWeight]      DECIMAL (10, 2)  NULL,
    [BackFat]               DECIMAL (10, 2)  NULL,
    [CreatedDateTime]       DATETIME         CONSTRAINT [DF_cft_IODINE_VALUE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]       DATETIME         NULL,
    [UpdatedBy]             VARCHAR (50)     NULL,
    [msrepl_tran_version]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_IODINE_VALUE] PRIMARY KEY CLUSTERED ([IodineID] ASC) WITH (FILLFACTOR = 90)
);

