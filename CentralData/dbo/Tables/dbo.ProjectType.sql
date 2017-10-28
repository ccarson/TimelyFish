CREATE TABLE [dbo].[ProjectType] (
    [ProjectTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ProjectTypeDescription] VARCHAR (50) NULL,
    CONSTRAINT [aaaaaProjectType_PK] PRIMARY KEY NONCLUSTERED ([ProjectTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [WorkTypeID]
    ON [dbo].[ProjectType]([ProjectTypeID] ASC) WITH (FILLFACTOR = 90);


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'DateCreated', @value = N'6/11/2002 10:39:06 AM', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'LastUpdated', @value = N'6/17/2002 9:37:47 AM', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DefaultView', @value = N'2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'ProjectType_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'OrderByOn', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'Orientation', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'RecordCount', @value = N'5', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'Updatable', @value = N'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'17', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'쏒뮁꧎䴳릆뀒䨒お', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'ProjectTypeID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'ProjectTypeID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'ProjectType_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeID';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'学䆇芤䏁�쁄', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'ProjectTypeDescription', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'50', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'ProjectTypeDescription', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'ProjectType_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'10', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';


GO
EXECUTE sp_addextendedproperty @name = N'UnicodeCompression', @value = N'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProjectType', @level2type = N'COLUMN', @level2name = N'ProjectTypeDescription';

