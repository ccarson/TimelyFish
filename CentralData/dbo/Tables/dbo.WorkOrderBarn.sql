CREATE TABLE [dbo].[WorkOrderBarn] (
    [WorkOrderID] INT         NOT NULL,
    [BarnNbr]     VARCHAR (6) NOT NULL,
    CONSTRAINT [PK_WorkOrderBarn] PRIMARY KEY CLUSTERED ([WorkOrderID] ASC, [BarnNbr] ASC) WITH (FILLFACTOR = 90)
);

