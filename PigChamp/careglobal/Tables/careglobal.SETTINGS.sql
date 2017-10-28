CREATE TABLE [careglobal].[SETTINGS] (
    [setting_group] VARCHAR (50) NOT NULL,
    [setting_name]  VARCHAR (50) NOT NULL,
    [setting_value] FLOAT (53)   NOT NULL,
    CONSTRAINT [PK_SETTINGS] PRIMARY KEY CLUSTERED ([setting_group] ASC, [setting_name] ASC) WITH (FILLFACTOR = 90)
);

