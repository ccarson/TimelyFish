CREATE TABLE [dbo].[cft_Form] (
    [FormID]      INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Form_Name]   VARCHAR (30)  NOT NULL,
    [Form_Status] VARCHAR (1)   NOT NULL,
    [ReportLink]  VARCHAR (255) NULL,
    CONSTRAINT [pk_Form] PRIMARY KEY CLUSTERED ([FormID] ASC) WITH (FILLFACTOR = 80)
);

