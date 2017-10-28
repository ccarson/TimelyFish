CREATE TABLE [dbo].[cft_GPA_SHRINK_DEDUCTION_DETAIL] (
    [GPAShrinkDeductionDetailID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [GPAShrinkDeductionID]       INT             NOT NULL,
    [Increment]                  DECIMAL (5, 2)  NOT NULL,
    [RangeFrom]                  DECIMAL (5, 2)  NOT NULL,
    [RangeTo]                    DECIMAL (5, 2)  NOT NULL,
    [Value]                      DECIMAL (14, 6) NOT NULL,
    [CreatedDateTime]            DATETIME        CONSTRAINT [DF_cft_GPA_SHRINK_DEDUCTION_DETAIL_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                  VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]            DATETIME        NULL,
    [UpdatedBy]                  VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_GPA_SHRINK_DEDUCTION_DETAIL] PRIMARY KEY CLUSTERED ([GPAShrinkDeductionDetailID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_GPA_SHRINK_DEDUCTION_DETAIL_cft_GPA_SHRINK_DEDUCTION] FOREIGN KEY ([GPAShrinkDeductionID]) REFERENCES [dbo].[cft_GPA_SHRINK_DEDUCTION] ([GPAShrinkDeductionID])
);

