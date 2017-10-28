CREATE TABLE [dbo].[cft_FSA_OFFICE] (
    [FsaOfficeID]     VARCHAR (15) NOT NULL,
    [ContactID]       INT          NOT NULL,
    [Active]          BIT          CONSTRAINT [DF_cft_FSA_OFFICE_Active] DEFAULT (1) NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_FSA_OFFICE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_FSA_OFFICE] PRIMARY KEY CLUSTERED ([FsaOfficeID] ASC) WITH (FILLFACTOR = 90)
);

