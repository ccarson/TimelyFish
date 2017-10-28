CREATE TABLE [dbo].[cft_VFDDispatch_Users] (
    [ContactID] VARCHAR (6)  NOT NULL,
    [Status]    CHAR (1)     NOT NULL,
    [UserId]    INT          NOT NULL,
    [UserName]  VARCHAR (50) NULL,
    [tstamp]    ROWVERSION   NOT NULL,
    CONSTRAINT [cft_VFDDispatch_Users0] PRIMARY KEY CLUSTERED ([UserId] ASC) WITH (FILLFACTOR = 100)
);

