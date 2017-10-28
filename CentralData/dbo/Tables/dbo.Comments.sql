CREATE TABLE [dbo].[Comments] (
    [CommentsID]        INT            NOT NULL,
    [Source_Table_Name] VARCHAR (60)   NOT NULL,
    [Source_ID]         INT            NOT NULL,
    [Comment_Type]      VARCHAR (60)   NOT NULL,
    [Comments]          VARCHAR (2000) NOT NULL,
    [Sort_Order]        INT            NULL,
    [Crtd_dateTime]     DATETIME       NOT NULL,
    [Crtd_User]         VARCHAR (20)   NOT NULL,
    [Lupd_dateTime]     DATETIME       NULL,
    [Lupd_User]         VARCHAR (20)   NULL,
    CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED ([CommentsID] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Comments] TO [hybridconnectionlogin_permissions]
    AS [dbo];

