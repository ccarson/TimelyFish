CREATE TABLE [dbo].[MrgAudit] (
    [Record_Sta]    INT           NOT NULL,
    [Remote_Cmp]    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]        VARCHAR (4)   NOT NULL,
    [FormSerialID]  VARCHAR (10)  NOT NULL,
    [Time_Stamp]    DATETIME      NULL,
    [RowNbr]        CHAR (2)      NOT NULL,
    [FormName]      VARCHAR (50)  NOT NULL,
    [Comment]       VARCHAR (100) NOT NULL,
    [CurrentDate]   VARCHAR (4)   NOT NULL,
    [FieldName]     VARCHAR (50)  NULL,
    [ReplyFlag]     VARCHAR (10)  CONSTRAINT [DF_MrgAudit_ReplyFlag] DEFAULT (0) NULL,
    [FarmWrote]     VARCHAR (50)  NULL,
    [FieldSHouldBe] VARCHAR (50)  NULL
);

