CREATE TABLE [dbo].[cft_AR_FULL_TICKET_ASSIGNMENT] (
    [ARFullTicketAssignmentID] INT            IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FullTicketAssignmentID]   INT            NULL,
    [TicketID]                 INT            NULL,
    [CornProducerID]           VARCHAR (15)   NULL,
    [Assignment]               DECIMAL (7, 4) NULL,
    [GroupName]                VARCHAR (1000) NULL,
    [CreatedDateTime]          DATETIME       NULL,
    [CreatedBy]                VARCHAR (50)   NULL,
    [UpdatedDateTime]          DATETIME       NULL,
    [UpdatedBy]                VARCHAR (50)   NULL,
    [RowChangeTypeID]          TINYINT        NOT NULL,
    [UserName]                 NVARCHAR (128) CONSTRAINT [DF_cft_AR_FULL_TICKET_ASSIGNMENT_UserName] DEFAULT (suser_sname()) NOT NULL,
    [HostName]                 NVARCHAR (128) CONSTRAINT [DF_cft_AR_FULL_TICKET_ASSIGNMENT_HostName] DEFAULT (host_name()) NOT NULL,
    [AppName]                  NVARCHAR (128) CONSTRAINT [DF_cft_AR_FULL_TICKET_ASSIGNMENT_AppName] DEFAULT (app_name()) NOT NULL,
    [TimeStamp]                DATETIME       CONSTRAINT [DF_cft_AR_FULL_TICKET_ASSIGNMENT_TimeStamp] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_cft_AR_FULL_TICKET_ASSIGNMENT] PRIMARY KEY CLUSTERED ([ARFullTicketAssignmentID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_AR_FULL_TICKET_ASSIGNMENT_cft_ROW_CHANGE_TYPE] FOREIGN KEY ([RowChangeTypeID]) REFERENCES [dbo].[cft_ROW_CHANGE_TYPE] ([RowChangeTypeID])
);

