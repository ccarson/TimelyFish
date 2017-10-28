CREATE TRIGGER [dbo].[GLTran_StdCstVar] on [dbo].[GLTran] 
	FOR INSERT 
	As
	
	SET NOCOUNT ON;

	DECLARE @TranList TABLE (
		Acct	Char (10),
		BatNbr 	Char (10), 
		ColonPos	smallint,
		InvtId	Char (30),
		LineNbr	smallint,
		Module	Char (2),
		NewAcct Char (10),
		NewSub	Char (24),
		RefNbr	Char (10),
		SiteId	Char (10),
		Sub	Char (24),
		TranDesc	Char (30)
	)

	IF ISNULL((SELECT COUNT(*) FROM Inserted WHERE Crtd_Prog = '04400' AND RefNbr > '' AND TranDesc Like 'PPV%'), 0) > 0
	BEGIN
		--get the data for the gltran ppv line
		INSERT INTO @TranList (Acct, BatNbr, InvtId, LineNbr, Module, NewAcct, NewSub, RefNbr, Sub, ColonPos, TranDesc, SiteId)
		SELECT Acct, BatNbr, '', LineNbr, Module, '', '', RefNbr, Sub, 0, TranDesc, '' 
			FROM Inserted 
			WHERE Crtd_Prog = '04400' AND RefNbr > '' AND TranDesc Like 'PPV%' 

		Update @TranList Set ColonPos = CharIndex(':', TranDesc)
		Update @TranList Set InvtId = LTrim(RTrim(SubString(TranDesc, ColonPos + 1, 30)))
		Update @TranList Set SiteId = Coalesce((Select Max(pt.SiteId) from POTran (NOLOCK) pt INNER JOIN @TranList tl ON  pt.RcptNbr = tl.RefNbr), '')

		--get the updated account values - first see if a site specific value has been specified for this item
		UPDATE t 
			SET t.NewAcct = i.User6, t.NewSub = i.User1 
			FROM @TranList t 
			INNER JOIN ItemSite i (NOLOCK) on t.InvtId = i.InvtId and i.SiteId = t.SiteId
			WHERE i.User6 <> '' -- Holds the Account
			AND i.User1 <> ''  -- Holds the subaccount
		
		-- second, if the first update did not run, then try for the item, but not specific to the site
		UPDATE t 
			SET t.NewAcct = i.User6, t.NewSub = i.User1 
			FROM @TranList t 
			INNER JOIN ItemSite i (NOLOCK) on t.InvtId = i.InvtId
			WHERE t.NewAcct = '' AND t.NewSub = ''  -- Don't overwrite updates from the previous update statement
			AND i.User6 <> '' -- Holds the Account
			AND i.User1 <> ''  -- Holds the subaccount

		-- Now do the actual GL update	
		UPDATE g 
			SET g.Acct = t.NewAcct, g.Sub = t.NewSub 
			FROM GLTran g 
			INNER JOIN @TranList t on g.BatNbr = t.BatNbr and g.Module = t.Module and g.LineNbr = t.LineNbr
			WHERE t.NewAcct > '' and t.NewSub > ''  -- Account and Subacct are required - don't overwrite with blank values 
	END
