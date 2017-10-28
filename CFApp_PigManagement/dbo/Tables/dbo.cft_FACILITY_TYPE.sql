CREATE TABLE [dbo].[cft_FACILITY_TYPE] (
    [FacilityTypeID]          INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FacilityTypeDescription] VARCHAR (50)     NULL,
    [CreatedDateTime]         DATETIME         CONSTRAINT [DF_cft_FACILITY_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]               VARCHAR (50)     NOT NULL,
    [UpdatedDateTime]         DATETIME         NULL,
    [UpdatedBy]               VARCHAR (50)     NULL,
    [msrepl_tran_version]     UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    CONSTRAINT [PK_cft_FACILITY_TYPE] PRIMARY KEY CLUSTERED ([FacilityTypeID] ASC) WITH (FILLFACTOR = 90)
);

