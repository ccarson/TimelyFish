CREATE TABLE [dbo].[cft_MARKETER] (
    [MarketerID]       TINYINT      IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FirstName]        VARCHAR (50) NOT NULL,
    [MiddleInitial]    VARCHAR (50) NULL,
    [LastName]         VARCHAR (50) NOT NULL,
    [EmployeeID]       VARCHAR (50) NULL,
    [MarketerStatusID] TINYINT      NOT NULL,
    [CreatedDateTime]  DATETIME     CONSTRAINT [DF_cft_MARKETER_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]        VARCHAR (50) NOT NULL,
    [UpdatedDateTime]  DATETIME     NULL,
    [UpdatedBy]        VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_MARKETER] PRIMARY KEY CLUSTERED ([MarketerID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_MARKETER_cft_MARKETER_STATUS] FOREIGN KEY ([MarketerStatusID]) REFERENCES [dbo].[cft_MARKETER_STATUS] ([MarketerStatusID])
);

