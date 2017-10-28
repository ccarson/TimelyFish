CREATE TABLE [dbo].[WorkOrderComponents] (
    [WorkOrderID]     INT CONSTRAINT [DF__WorkOrder__WorkO__5708E33C] DEFAULT (0) NOT NULL,
    [SiteComponentID] INT NOT NULL,
    CONSTRAINT [PK_WorkOrderComponents] PRIMARY KEY CLUSTERED ([WorkOrderID] ASC, [SiteComponentID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_WorkOrderComponents_SiteComponents] FOREIGN KEY ([SiteComponentID]) REFERENCES [dbo].[SiteComponents] ([SiteComponentID]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [WorkOrderID]
    ON [dbo].[WorkOrderComponents]([WorkOrderID] ASC) WITH (FILLFACTOR = 90);


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents';


GO
EXECUTE sp_addextendedproperty @name = N'DateCreated', @value = N'6/12/2002 11:27:49 AM', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents';


GO
EXECUTE sp_addextendedproperty @name = N'LastUpdated', @value = N'6/17/2002 9:37:46 AM', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DefaultView', @value = N'2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'WorkOrderComponents_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents';


GO
EXECUTE sp_addextendedproperty @name = N'OrderByOn', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents';


GO
EXECUTE sp_addextendedproperty @name = N'Orientation', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents';


GO
EXECUTE sp_addextendedproperty @name = N'RecordCount', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents';


GO
EXECUTE sp_addextendedproperty @name = N'Updatable', @value = N'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'DefaultValue', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'독챓䰸䩌㖝୙ꫳ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DecimalPlaces', @value = N'255', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'WorkOrderID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'WorkOrderID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'WorkOrderComponents_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderComponents', @level2type = N'COLUMN', @level2name = N'WorkOrderID';

