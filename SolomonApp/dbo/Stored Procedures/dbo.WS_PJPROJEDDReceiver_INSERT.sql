
CREATE PROCEDURE WS_PJPROJEDDReceiver_INSERT
     @BodyText char(255),         @CpnyID char(10),          @Crtd_DateTime smalldatetime, @Crtd_Prog char(8),       @Crtd_user char(10),
     @DeliveryMethod char(1),     @DocType char(2),          @EDDEmail char(80),           @EDDFax char(10),         @EDDFaxPrefix char(15),
     @EDDFaxUseAreaCode smallint, @EmailFileType char(1),    @FaxComment char(1),          @FaxCover char(1),        @FaxReceiverName char(60),
     @FaxRecycle char(1),         @FaxReply char(1),         @FaxReview char(1),           @FaxSenderName char(60),  @FaxSenderNbr char(10),
     @FaxUrgent char(1),          @LineNbr smallint,         @Lupd_DateTime smalldatetime, @Lupd_Prog char(8),       @Lupd_User char(10),
     @NoteID int,                 @Priority char(1),         @PrjMgr char(1),              @Project char(16),        @S4Future01 char(30),
     @S4Future02 char(30),        @S4Future03 float,         @S4Future04 float,            @S4Future05 float,        @S4Future06 float,
     @S4Future07 smalldatetime,   @S4Future08 smalldatetime, @S4Future09 int,              @S4Future10 int,          @S4Future11 char(10),
     @S4Future12 char(10),        @SendersEmail char(80),    @SubjectText char(80),        @UsePrimaryPref smallint, @User1 char(30),
     @User2 char(30),             @User3 float,              @User4 float,                 @User5 char(10),          @User6 char(10),
     @User7 smalldatetime,        @User8 smalldatetime
AS
  BEGIN
   INSERT INTO [PJPROJEDDReceiver]
    ([BodyText],          [CpnyID],        [Crtd_DateTime],   [Crtd_Prog],      [Crtd_user],
     [DeliveryMethod],    [DocType],       [EDDEmail],        [EDDFax],         [EDDFaxPrefix],
     [EDDFaxUseAreaCode], [EmailFileType], [FaxComment],      [FaxCover],       [FaxReceiverName],
     [FaxRecycle],        [FaxReply],      [FaxReview],       [FaxSenderName],  [FaxSenderNbr],
     [FaxUrgent],         [LineNbr],       [Lupd_DateTime],   [Lupd_Prog],      [Lupd_User],
     [NoteID],            [Priority],      [PrjMgr],          [Project],        [S4Future01],
     [S4Future02],        [S4Future03],    [S4Future04],      [S4Future05],     [S4Future06],
     [S4Future07],        [S4Future08],    [S4Future09],      [S4Future10],     [S4Future11],
     [S4Future12],        [SendersEmail],  [SubjectText],     [UsePrimaryPref], [User1],
     [User2],             [User3],         [User4],           [User5],          [User6],
     [User7],             [User8])
   VALUES
    (@BodyText,          @CpnyID,        @Crtd_DateTime,   @Crtd_Prog,      @Crtd_user,
     @DeliveryMethod,    @DocType,       @EDDEmail,        @EDDFax,         @EDDFaxPrefix,
     @EDDFaxUseAreaCode, @EmailFileType, @FaxComment,      @FaxCover,       @FaxReceiverName,
     @FaxRecycle,        @FaxReply,      @FaxReview,       @FaxSenderName,  @FaxSenderNbr,
     @FaxUrgent,         @LineNbr,       @Lupd_DateTime,   @Lupd_Prog,      @Lupd_User,
     @NoteID,            @Priority,      @PrjMgr,          @Project,        @S4Future01,
     @S4Future02,        @S4Future03,    @S4Future04,      @S4Future05,     @S4Future06,
     @S4Future07,        @S4Future08,    @S4Future09,      @S4Future10,     @S4Future11,
     @S4Future12,        @SendersEmail,  @SubjectText,     @UsePrimaryPref, @User1,
     @User2,             @User3,         @User4,           @User5,          @User6,
     @User7,             @User8);
End


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJPROJEDDReceiver_INSERT] TO [MSDSL]
    AS [dbo];

