
CREATE PROCEDURE XDDBank_ARSetUp_PreNotes
AS
	-- Do any Accounts require prenotes?
	if exists(	SELECT 	B.Acct
			FROM 	xddbank B (nolock) left outer join xddfileformat F (nolock)
				On B.FormatID = F.FormatID, xddsetup S (nolock)
			WHERE 	F.Prenote = 1	-- FileFormat requires prenotes
				-- Either Getting defaults from Setup and Setup Requires prenotes or
				-- Not getting from Setup and Company Paying Account requires prenotes
				and ((S.ARAchprenote = 'Y' and B.filefromsetup = 1)
				or (B.ARachprenote = 'Y' and B.filefromsetup = 0))
		)

		-- If One XDDBank record requires AR PreNotes, now check if A/R Dflt Cash has been setup
		-- Now find out if one Company Paying/Cash Account is the Default Cash account
		-- If it doesn't exist, then return the ARSetup record to put in user message
			if exists(SELECT B.acct
				FROM 	xddbank B (nolock), arsetup A (nolock)
				WHERE 	B.acct = A.ChkAcct and B.sub = A.ChkSub)

				-- Return empty record
				SELECT 	*
				FROM 	arsetup (nolock)
				WHERE 	SetupID = ''
			else
				-- ARSetup for message
				SELECT	* from ARSetup (nolock)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBank_ARSetUp_PreNotes] TO [MSDSL]
    AS [dbo];

