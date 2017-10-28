CREATE TABLE [dbo].[cft_GPA_TEST_WEIGHT_DETAIL] (
    [GPATestWeightDetailID] INT             IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [GPATestWeightID]       INT             NOT NULL,
    [Increment]             DECIMAL (5, 2)  NOT NULL,
    [RangeFrom]             DECIMAL (18, 2) NOT NULL,
    [RangeTo]               DECIMAL (18, 2) NOT NULL,
    [Value]                 DECIMAL (14, 6) NOT NULL,
    [CreatedDateTime]       DATETIME        CONSTRAINT [DF_cft_GPA_TEST_WEIGHT_DETAIL_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (50)    NOT NULL,
    [UpdatedDateTime]       DATETIME        NULL,
    [UpdatedBy]             VARCHAR (50)    NULL,
    CONSTRAINT [PK_cft_GPA_TEST_WEIGHT_DETAIL] PRIMARY KEY CLUSTERED ([GPATestWeightDetailID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_GPA_TEST_WEIGHT_DETAIL_cft_GPA_TEST_WEIGHT] FOREIGN KEY ([GPATestWeightID]) REFERENCES [dbo].[cft_GPA_TEST_WEIGHT] ([GPATestWeightID])
);

