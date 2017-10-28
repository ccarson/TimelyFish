CREATE TABLE [careglobal].[CARE_USERS] (
    [username]     VARCHAR (15)  NOT NULL,
    [password]     VARCHAR (300) NULL,
    [windowsuser]  VARCHAR (300) NULL,
    [disabled]     BIT           CONSTRAINT [DF_CARE_USERS_disabled] DEFAULT ((0)) NOT NULL,
    [pass_changed] DATETIME      NULL,
    CONSTRAINT [PK_CARE_USERS] PRIMARY KEY CLUSTERED ([username] ASC) WITH (FILLFACTOR = 80)
);

