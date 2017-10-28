CREATE TABLE [dbo].[WCBasket] (
    [Crtd_DateTime]     SMALLDATETIME NOT NULL,
    [Crtd_Prog]         CHAR (8)      NOT NULL,
    [Crtd_User]         CHAR (10)     NOT NULL,
    [LUpd_DateTime]     SMALLDATETIME NOT NULL,
    [LUpd_Prog]         CHAR (8)      NOT NULL,
    [LUpd_User]         CHAR (10)     NOT NULL,
    [shopper_id]        CHAR (32)     NOT NULL,
    [date_changed]      SMALLDATETIME NOT NULL,
    [marshalled_basket] IMAGE         NOT NULL,
    CONSTRAINT [WCBasket0] PRIMARY KEY CLUSTERED ([shopper_id] ASC) WITH (FILLFACTOR = 90)
);

