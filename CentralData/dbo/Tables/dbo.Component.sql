CREATE TABLE [dbo].[Component] (
    [ComponentClassID] INT NOT NULL,
    [ComponentTypeID]  INT NOT NULL,
    CONSTRAINT [aaaaaComponents_PK] PRIMARY KEY NONCLUSTERED ([ComponentTypeID] ASC, [ComponentClassID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [ComponentID]
    ON [dbo].[Component]([ComponentTypeID] ASC) WITH (FILLFACTOR = 90);


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component';


GO
EXECUTE sp_addextendedproperty @name = N'DateCreated', @value = N'6/12/2002 11:28:30 AM', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component';


GO
EXECUTE sp_addextendedproperty @name = N'LastUpdated', @value = N'6/17/2002 9:37:48 AM', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DefaultView', @value = N'2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'Components_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component';


GO
EXECUTE sp_addextendedproperty @name = N'OrderByOn', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component';


GO
EXECUTE sp_addextendedproperty @name = N'Orientation', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component';


GO
EXECUTE sp_addextendedproperty @name = N'RecordCount', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component';


GO
EXECUTE sp_addextendedproperty @name = N'Updatable', @value = N'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'17', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'鮣�䨼沗帹�ᓭ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'ComponentID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'ComponentID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'Components_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Component', @level2type = N'COLUMN', @level2name = N'ComponentTypeID';

