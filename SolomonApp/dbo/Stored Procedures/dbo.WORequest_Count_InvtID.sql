 CREATE PROCEDURE WORequest_Count_InvtID
   @InvtID   	varchar( 30 )

AS
	-- If there is a wild card in @InvtID
	-- use LIKE; otherwise use =
	IF PATINDEX('%[%]%', @InvtID) > 0
		SELECT	COUNT(L.OrdNbr)
		FROM	WORequest W WITH (NOLOCK)

		JOIN	SOLine L WITH (NOLOCK)
		  ON	L.CpnyID = W.CpnyID
		 AND	L.OrdNbr = W.OrdNbr
		 AND	L.LineRef = W.LineRef

		WHERE	L.InvtID + '' LIKE @InvtID
		  AND	L.Status = 'O'
	ELSE
		SELECT	COUNT(L.OrdNbr)
		FROM	WORequest W WITH (NOLOCK)

		JOIN	SOLine L WITH (NOLOCK)
		  ON	L.CpnyID = W.CpnyID
		 AND	L.OrdNbr = W.OrdNbr
		 AND	L.LineRef = W.LineRef

		WHERE	L.InvtID = @InvtID
		  AND	L.Status = 'O'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WORequest_Count_InvtID] TO [MSDSL]
    AS [dbo];

