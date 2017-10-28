 CREATE PROCEDURE DMG_CustSlsPer_Convert
AS
	Insert into CustSlsPer (CreditPct, Crtd_DateTime, Crtd_Prog, Crtd_User, CustID, LUpd_DateTime, LUpd_Prog,
				LUpd_User, NoteID, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
				S4Future06, S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
				SlsperID, User1, User10, User2, User3, User4, User5, User6, User7, User8, User9)

		select distinct
		IsNull(S.CmmnPct, 0),
		getdate(), 'SQL', 'SQL',
		C.CustID,
		GetDate(), 'SQL', 'SQL',
		0, '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
		C.SlsperID,
		'', '', '', '', '', '', 0, 0, '', ''
		from 	Customer C
			left outer join Salesperson S
				on c.SlsPerID = S.SlsPerID
		Where 	C.SlsPerID <> ''
		  and 	C.CustID not in (Select CustID from CustSlsPer)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CustSlsPer_Convert] TO [MSDSL]
    AS [dbo];

