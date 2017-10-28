CREATE TABLE [dbo].[ManureCertification] (
    [ContactID]        INT          NOT NULL,
    [State]            VARCHAR (2)  NOT NULL,
    [CertificationNbr] VARCHAR (15) NULL,
    CONSTRAINT [PK_ManureCertification] PRIMARY KEY CLUSTERED ([ContactID] ASC, [State] ASC) WITH (FILLFACTOR = 90)
);

