CREATE TABLE [dbo].[FormSerialIDTemp] (
    [FarmID]       VARCHAR (8) NOT NULL,
    [FormSerialID] VARCHAR (8) NOT NULL,
    CONSTRAINT [PK_FormSerialIDTemp] PRIMARY KEY CLUSTERED ([FarmID] ASC, [FormSerialID] ASC) WITH (FILLFACTOR = 90)
);

