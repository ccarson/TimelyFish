 CREATE Procedure Insert_AcctSub
	@YtdNetIncAcct 	varChar(10),
	@UserAddress 	varchar(21),
	@pUserID	VarChar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
/***** If YTD Net Income acct-sub combo doesn't exist, create it. *****/
	INSERT vw_AcctSub (Acct, Active, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User,
					Descr, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID,
					S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
					S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
					S4Future11, S4Future12, Sub, User1, User2, User3, User4,
					User5, User6, User7, User8)
	SELECT DISTINCT @YTDNetIncAcct,1, v.CpnyId, getdate(),'01520',@pUserID, RTRIM(a.Descr) + ' ' + RTRIM(COALESCE(b.descr,'')), 0,'','',0,'','',0,0,0,0,0,0,0,0,'','',v.Sub,'','',0,0,'','',0,0
	FROM vp_01520PostTran v LEFT JOIN SubAcct b ON v.Sub = b.Sub, GlSetup s (nolock), Account a (nolock)
	WHERE v.UserAddress = @UserAddress AND
      	s.ValidateAcctSub = 1 AND
      	a.Acct = @YtdNetIncAcct AND
      	(v.AcctType = 'E' OR v.AcctType = 'I') AND
      	NOT EXISTS (SELECT * FROM vw_AcctSub z  WHERE z.Acct = @YTDNetIncAcct and z.Sub = v.Sub and z.CpnyId = v.CpnyId)


