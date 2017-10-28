CREATE TABLE [dbo].[PhoneNumber-Delete] (
    [ID]           INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [TempID]       INT          NOT NULL,
    [PhoneTypeID]  VARCHAR (10) NULL,
    [PhoneNbr]     VARCHAR (10) NOT NULL,
    [SpeedDialNbr] INT          NULL,
    [Comment]      VARCHAR (60) NULL,
    CONSTRAINT [PK_PhoneNumber] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 90)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Orientation', @value = 0, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PhoneNumber-Delete';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DisplayControl', @value = N'109', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PhoneNumber-Delete', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Format', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PhoneNumber-Delete', @level2type = N'COLUMN', @level2name = N'ID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_IMEMode', @value = N'0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PhoneNumber-Delete', @level2type = N'COLUMN', @level2name = N'ID';

