CREATE TABLE [dbo].[cft_BARN_HEALTH] (
    [BarnHealthID]        INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteHealthID]        INT              NOT NULL,
    [BarnID]              INT              NOT NULL,
    [PigGroupID]          INT              NULL,
    [NumberOfDead]        INT              NULL,
    [NumberOfInjections]  INT              NULL,
    [MedicationID]        INT              NULL,
    [MedicationReasonID]  INT              NULL,
    [MedicationStartDate] DATETIME         NULL,
    [MedicationEndDate]   DATETIME         NULL,
    [Comment]             VARCHAR (2000)   NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_BARN_HEALTH_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_BARN_HEALTH] PRIMARY KEY CLUSTERED ([BarnHealthID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_BARN_HEALTH_cft_MEDICATION] FOREIGN KEY ([MedicationID]) REFERENCES [dbo].[cft_MEDICATION] ([MedicationID])
);

