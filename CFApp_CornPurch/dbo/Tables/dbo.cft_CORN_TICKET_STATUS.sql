CREATE TABLE [dbo].[cft_CORN_TICKET_STATUS] (
    [TicketStatusID]  INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]            VARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_CORN_TICKET_STATUS_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CORN_TICKET_STATUS] PRIMARY KEY CLUSTERED ([TicketStatusID] ASC) WITH (FILLFACTOR = 90)
);

