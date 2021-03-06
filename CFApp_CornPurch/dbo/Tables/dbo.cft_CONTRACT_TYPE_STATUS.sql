﻿CREATE TABLE [dbo].[cft_CONTRACT_TYPE_STATUS] (
    [ContractTypeStatusID] TINYINT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]                 VARCHAR (20) NOT NULL,
    [CreatedDateTime]      DATETIME     CONSTRAINT [DF_cft_CONTRACT_TYPE_STATUS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50) NOT NULL,
    [UpdatedDateTime]      DATETIME     NULL,
    [UpdatedBy]            VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CONTRACT_TYPE_STATUS] PRIMARY KEY CLUSTERED ([ContractTypeStatusID] ASC) WITH (FILLFACTOR = 90)
);

