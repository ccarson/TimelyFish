CREATE TABLE [dbo].[cft_MEDICATION] (
    [MedicationID]        INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [MedicationTypeID]    INT              NOT NULL,
    [Name]                VARCHAR (25)     NOT NULL,
    [Description]         VARCHAR (25)     NULL,
    [WaterMedication]     BIT              CONSTRAINT [DF_cft_MEDICATION_WaterMedication] DEFAULT (0) NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_MEDICATION_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_MEDICATION] PRIMARY KEY CLUSTERED ([MedicationID] ASC) WITH (FILLFACTOR = 90)
);

