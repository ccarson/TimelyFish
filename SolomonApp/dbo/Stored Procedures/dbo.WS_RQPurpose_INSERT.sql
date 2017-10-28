CREATE PROCEDURE WS_RQPurpose_INSERT
            @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), @lupd_datetime smalldatetime, @lupd_prog char(8),
            @lupd_user char(10), @PurposeNbr char(10), @PurposeType char(1), @S4Future1 char(30), @S4Future2 char(30),
            @S4Future3 float, @S4Future4 float, @S4Future5 float, @S4Future6 float, @S4Future7 smalldatetime,
            @S4Future8 smalldatetime, @S4Future9 int, @S4Future10 int, @S4Future11 char(10), @S4Future12 char(10),
            @User1 char(30), @User2 char(30), @User3 float, @User4 float, @User5 char(10),
            @User6 char(10), @User7 smalldatetime, @User8 smalldatetime, @ZZText text
            AS
            BEGIN
            INSERT INTO [RQPurpose]
            ([crtd_datetime], [crtd_prog], [crtd_user], [lupd_datetime], [lupd_prog],
            [lupd_user], [PurposeNbr], [PurposeType], [S4Future1], [S4Future2],
            [S4Future3], [S4Future4], [S4Future5], [S4Future6], [S4Future7],
            [S4Future8], [S4Future9], [S4Future10], [S4Future11], [S4Future12],
            [User1], [User2], [User3], [User4], [User5],
            [User6], [User7], [User8], [ZZText])
            VALUES
            (@crtd_datetime, @crtd_prog, @crtd_user, @lupd_datetime, @lupd_prog,
            @lupd_user, @PurposeNbr, @PurposeType, @S4Future1, @S4Future2,
            @S4Future3, @S4Future4, @S4Future5, @S4Future6, @S4Future7,
            @S4Future8, @S4Future9, @S4Future10, @S4Future11, @S4Future12,
            @User1, @User2, @User3, @User4, @User5,
            @User6, @User7, @User8, @ZZText);
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_RQPurpose_INSERT] TO [MSDSL]
    AS [dbo];

