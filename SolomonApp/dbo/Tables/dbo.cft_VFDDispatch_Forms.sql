CREATE TABLE [dbo].[cft_VFDDispatch_Forms] (
    [FormId]              INT           NOT NULL,
    [FormName]            VARCHAR (50)  NULL,
    [FormType]            VARCHAR (10)  NULL,
    [SharePointStorage]   BIT           NOT NULL,
    [SharePointDocLibUrl] VARCHAR (100) NULL,
    [Status]              CHAR (1)      NOT NULL,
    [tstamp]              ROWVERSION    NOT NULL,
    CONSTRAINT [cft_VFDDispatch_Forms0] PRIMARY KEY CLUSTERED ([FormId] ASC) WITH (FILLFACTOR = 90)
);

