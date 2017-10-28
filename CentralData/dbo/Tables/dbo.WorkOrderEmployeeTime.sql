CREATE TABLE [dbo].[WorkOrderEmployeeTime] (
    [EmployeeID]           INT           NOT NULL,
    [WorkOrderID]          INT           NOT NULL,
    [Date]                 SMALLDATETIME NOT NULL,
    [TimeIn]               SMALLDATETIME NULL,
    [TimeInMilitary]       SMALLDATETIME NULL,
    [TimeOut]              SMALLDATETIME NULL,
    [TimeOutMilitary]      SMALLDATETIME NULL,
    [TimeIn2]              SMALLDATETIME NULL,
    [TimeIn2Military]      SMALLDATETIME NULL,
    [TimeOut2]             SMALLDATETIME NULL,
    [TimeOut2Military]     SMALLDATETIME NULL,
    [TimeInOther]          SMALLDATETIME NULL,
    [TimeInOtherMilitary]  SMALLDATETIME NULL,
    [TimeOutOther]         SMALLDATETIME NULL,
    [TimeOutOtherMilitary] SMALLDATETIME NULL,
    [HourAdjustment]       FLOAT (53)    NULL,
    CONSTRAINT [aaaaaEmployeeTime_PK] PRIMARY KEY NONCLUSTERED ([EmployeeID] ASC, [WorkOrderID] ASC, [Date] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [EmployeeID]
    ON [dbo].[WorkOrderEmployeeTime]([EmployeeID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [WorkOrderID]
    ON [dbo].[WorkOrderEmployeeTime]([WorkOrderID] ASC) WITH (FILLFACTOR = 90);


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime';


GO
EXECUTE sp_addextendedproperty @name = N'DateCreated', @value = N'6/11/2002 2:05:37 PM', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime';


GO
EXECUTE sp_addextendedproperty @name = N'LastUpdated', @value = N'6/17/2002 9:37:48 AM', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DefaultView', @value = N'2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime';


GO
EXECUTE sp_addextendedproperty @name = N'OrderByOn', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime';


GO
EXECUTE sp_addextendedproperty @name = N'Orientation', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime';


GO
EXECUTE sp_addextendedproperty @name = N'RecordCount', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime';


GO
EXECUTE sp_addextendedproperty @name = N'Updatable', @value = N'True', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'DefaultValue', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'ワ줐첡䗬궹﨔ֲ㯃', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DecimalPlaces', @value = N'255', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'EmployeeID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'EmployeeID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'EmployeeID';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'DefaultValue', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'ᛔ繓䷇疶�잤꼝', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DecimalPlaces', @value = N'255', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'WorkOrderID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'WorkOrderID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'WorkOrderID';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'뀮쿩䕨㰍៰', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Short Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'Date';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'Ⱐ癝ࣱ䐏벓餲䳕', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Medium Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeIn', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeIn', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'睊緜୦䁉ಹ촲պ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Short Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeInMilitary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeInMilitary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'㜢ꆼꗬ䤛뚴㟏鸘帀', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Medium Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeOut', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'5', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeOut', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'溵갾ḻ䫅킐䴷�', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Short Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeOutMilitary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'6', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeOutMilitary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'쒮퐚῏䟎羾ࣷ面䧻', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Medium Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeIn2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'7', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeIn2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'꨹䇇枖쑳鼳☮', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Short Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeIn2Military', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeIn2Military', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeIn2Military';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'퇎ǫ䓿Ꞥ砝♐瑷', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Medium Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeOut2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'9', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeOut2', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'䘈䌈枩䠿璩킨⪉葨', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Short Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeOut2Military', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'10', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeOut2Military', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOut2Military';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'玻◊䫾嚸劥懲핃', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Medium Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeInOther', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'11', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeInOther', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOther';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'ﶚ㖻䈯㚀ﯣ괡뙕', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Short Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeInOtherMilitary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'12', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeInOtherMilitary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeInOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'씿㖹䶬钏ꔞ῭', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Medium Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeOutOther', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'13', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeOutOther', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOther';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'봳ޱ㡰䗬▫ꎓ劉', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'Short Time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMESentMode', @value = N'3', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'TimeOutOtherMilitary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'14', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'TimeOutOtherMilitary', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'TimeOutOtherMilitary';


GO
EXECUTE sp_addextendedproperty @name = N'AllowZeroLength', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'Attributes', @value = N'1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'CollatingOrder', @value = N'1033', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnHidden', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnOrder', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'ColumnWidth', @value = N'-1', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'DataUpdatable', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'GUID', @value = N'笉ꮊꂲ侄ʸ䨜棇崝', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DecimalPlaces', @value = N'255', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'Name', @value = N'HourAdjustment', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'OrdinalPosition', @value = N'15', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'Required', @value = N'False', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'Size', @value = N'4', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'SourceField', @value = N'HourAdjustment', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'SourceTable', @value = N'EmployeeTime_local', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';


GO
EXECUTE sp_addextendedproperty @name = N'Type', @value = N'6', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkOrderEmployeeTime', @level2type = N'COLUMN', @level2name = N'HourAdjustment';

