CREATE TABLE [dbo].[typetransl] (
    [doctype]  VARCHAR (2) NOT NULL,
    [trantype] VARCHAR (2) NOT NULL,
    CONSTRAINT [TypeTransl0] PRIMARY KEY CLUSTERED ([doctype] ASC, [trantype] ASC) WITH (FILLFACTOR = 90)
);

