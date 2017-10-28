CREATE TABLE [dbo].[cft_COMMISSION_RATE_DETAIL] (
    [CommissionRateDetailID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [CommissionRateID]       INT             CONSTRAINT [DF_cft_COMMISSION_RATE_DETAIL_CommissionRateID] DEFAULT (null) NULL,
    [RangeFrom]              DECIMAL (18, 4) NOT NULL,
    [RangeTo]                DECIMAL (18, 4) NOT NULL,
    [Value]                  DECIMAL (20, 6) NOT NULL,
    [CreatedDateTime]        DATETIME        CONSTRAINT [DF_cft_COMMISSION_RATE_DETAIL_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]              VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]        DATETIME        NULL,
    [UpdatedBy]              VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_COMMISSION_RATE_DETAIL] PRIMARY KEY CLUSTERED ([CommissionRateDetailID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_COMMISSION_RATE_DETAIL_cft_STANDARD_RATE] FOREIGN KEY ([CommissionRateID]) REFERENCES [dbo].[cft_STANDARD_RATE] ([CommissionRateID])
);

