CREATE PROCEDURE WS_RQReason_INSERT
            @Crtd_DateTime smalldatetime, @Crtd_Prog char(8), @Crtd_User char(10), @ItemNbr char(10), @ItemLineNbr smallint,
            @ItemType char(1), @InvtID char(30), @LUpd_DateTime smalldatetime, @LUpd_Prog char(8), @LUpd_User char(10),
            @S4Future1 char(30), @S4Future2 char(30), @S4Future3 float, @S4Future4 float, @S4Future5 float,
            @S4Future6 float, @S4Future7 smalldatetime, @S4Future8 smalldatetime, @S4Future9 int, @S4Future10 int,
            @S4Future11 char(10), @S4Future12 char(10), @User1 char(30), @User2 char(30), @User3 float,
            @User4 float, @User5 char(10), @User6 char(10), @User7 smalldatetime, @User8 smalldatetime,
            @ZZReason text
            AS
            BEGIN
            INSERT INTO [RQReason]
            ([Crtd_DateTime], [Crtd_Prog], [Crtd_User], [ItemNbr], [ItemLineNbr], 
            [ItemType], [InvtID], [LUpd_DateTime], [LUpd_Prog], [LUpd_User],
            [S4Future1], [S4Future2], [S4Future3], [S4Future4], [S4Future5],
            [S4Future6], [S4Future7], [S4Future8], [S4Future9], [S4Future10],
            [S4Future11], [S4Future12], [User1], [User2], [User3],
            [User4], [User5], [User6], [User7], [User8],
            [ZZReason])
            VALUES
            (@Crtd_DateTime, @Crtd_Prog, @Crtd_User, @ItemNbr, @ItemLineNbr,
            @ItemType, @InvtID, @LUpd_DateTime, @LUpd_Prog, @LUpd_User,
            @S4Future1, @S4Future2, @S4Future3, @S4Future4, @S4Future5,
            @S4Future6, @S4Future7, @S4Future8, @S4Future9, @S4Future10,
            @S4Future11, @S4Future12, @User1, @User2, @User3,
            @User4, @User5, @User6, @User7, @User8,
            @ZZReason);
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQReason_INSERT] TO [MSDSL]
    AS [dbo];

