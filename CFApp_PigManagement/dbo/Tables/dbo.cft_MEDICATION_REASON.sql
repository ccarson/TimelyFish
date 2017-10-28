CREATE TABLE [dbo].[cft_MEDICATION_REASON] (
    [MedicationReasonID]  INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [MedicationReason]    VARCHAR (50)     NOT NULL,
    [CreatedDateTime]     DATETIME         CONSTRAINT [DF_cft_MEDICATION_REASON_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]     DATETIME         NULL,
    [UpdatedBy]           VARCHAR (50)     NULL,
    [msrepl_tran_version] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_MEDICATION_REASON] PRIMARY KEY CLUSTERED ([MedicationReasonID] ASC) WITH (FILLFACTOR = 90)
);

