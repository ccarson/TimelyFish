CREATE TABLE [dbo].[cft_FSA_OFFICE_CORN_PRODUCER] (
    [FsaOfficeCornProducerID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FsaOfficeID]             VARCHAR (15)    NOT NULL,
    [CornProducerID]          VARCHAR (15)    NOT NULL,
    [FsaPaymentAmount]        DECIMAL (18, 4) CONSTRAINT [DF_cft_FSA_OFFICE_CORN_PRODUCER_FsaPaymentAmount] DEFAULT (null) NULL,
    [FsaLoanNumber]           VARCHAR (100)   CONSTRAINT [DF_cft_FSA_OFFICE_CORN_PRODUCER_FsaLoanNumber] DEFAULT (null) NULL,
    [CreatedDateTime]         DATETIME        CONSTRAINT [DF_cft_FSA_OFFICE_CORN_PRODUCER_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]               VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]         DATETIME        NULL,
    [UpdatedBy]               VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_FSA_OFFICE_CORN_PRODUCER] PRIMARY KEY CLUSTERED ([FsaOfficeCornProducerID] ASC) WITH (FILLFACTOR = 90)
);

