CREATE TABLE [dbo].[Wrk11400_Values] (
    [BaseCury]       SMALLINT      CONSTRAINT [DF_Wrk11400_Values_BaseCury] DEFAULT ((0)) NOT NULL,
    [BMICury]        SMALLINT      CONSTRAINT [DF_Wrk11400_Values_BMICury] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_Wrk11400_Values_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Inv_Unit_Price] SMALLINT      CONSTRAINT [DF_Wrk11400_Values_Inv_Unit_Price] DEFAULT ((0)) NOT NULL,
    [Inv_Unit_Qty]   SMALLINT      CONSTRAINT [DF_Wrk11400_Values_Inv_Unit_Qty] DEFAULT ((0)) NOT NULL,
    [UserAddress]    CHAR (21)     CONSTRAINT [DF_Wrk11400_Values_UserAddress] DEFAULT (' ') NOT NULL,
    [WrkMoney]       SMALLINT      CONSTRAINT [DF_Wrk11400_Values_WrkMoney] DEFAULT ((0)) NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL
);

