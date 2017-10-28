CREATE TABLE [dbo].[FlowType] (
    [FlowTypeID]  INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SystemID]    INT          NOT NULL,
    [Description] VARCHAR (30) NULL,
    CONSTRAINT [PK_FlowType] PRIMARY KEY CLUSTERED ([FlowTypeID] ASC, [SystemID] ASC) WITH (FILLFACTOR = 90)
);

