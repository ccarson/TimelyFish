 Create Proc EDAcknowledgement_AddSent @EntityId varchar(35), @EntityType smallint,
  @Crtd_User varchar(10), @Crtd_Prog varchar(8), @GSNbr int, @GSRcvId varchar(15),
  @ISANbr int, @STNbr int As

  Insert Into EDAcknowledgement Select '01/01/1900' 'AckDate', 0 'AckStatus',
    GetDate() 'Crtd_Datetime', @Crtd_Prog 'Crtd_Prog', @Crtd_User 'Crtd_User',
    @EntityId 'EntityId', @EntityType 'EntityType', @GSNbr 'GSNbr', @GSRcvId 'GSRcvID', @ISANbr 'ISANbr',
    GetDate() 'Lupd_Datetime', @Crtd_Prog 'Lupd_Prog', @Crtd_User 'Lupd_User', ' ' 'S4Future01',
    ' ' 'S4Future02', 0 'S4Future03', 0 'S4Future04', 0 'S4Future05', 0 'S4Future06',
    '01/01/1900' 'S4Future07', '01/01/1900' 'S4Future08', 0 'S4Future09', 0 'S4Future10',
    ' ' 'S4Future11', ' ' 'S4Future12', '01/01/1900' 'SolomonDate', @STNbr 'STNbr',
    GetDate() 'TranslatorDate', ' ' 'User1', '01/01/1900' 'User10', ' ' 'User2', ' ' 'User3',
    ' ' 'User4', 0 'User5', 0 'User6', ' ' 'User7', ' ' 'User8', '01/01/1900' 'User9',
    NULL 'tstamp'


