
CREATE PROCEDURE XDDWrkCheckSel_Remove_Batch
   @AccessNbr		smallint,
   @RemoveGroup		varchar( 1 ),			-- "R"emove group, "D"-AD Remove group, "B"oth of these
   @BatNbr		varchar( 10 ),
   @UserID		varchar( 10 ),
   @Prog		varchar( 8 )

AS

   Declare	@RemoveGroup1	varchar( 1 )

   -- Set to not used Group Value if no Remove Group   
   if @RemoveGroup = '' SET @RemoveGroup = 'X'
   
   if @RemoveGroup = 'B'		-- Both types
   BEGIN
   	SET	@RemoveGroup = 'R'
   	SET	@RemoveGroup1 = 'D'
   END
   else
   BEGIN
   	-- If only one group, set second group to the same value
   	SET	@RemoveGroup1 = @RemoveGroup
   END   	

   -- This will deselct these vouchers for payment
   UPDATE	APDoc
   SET		Selected = 0,
		PmtAmt = 0,
		CuryPmtAmt = 0,
		DiscTkn = 0,
		CuryDiscTkn = 0,
		LUpd_Prog = @Prog,
		LUpd_DateTime = GetDate(),
		LUpd_User = @UserID
  FROM		APDoc INNER JOIN XDDWrkCheckSel
  		ON XDDWrkCheckSel.Accessnbr = @AccessNbr		-- AccessNbr
  		and (XDDWrkCheckSel.EBGroup = @RemoveGroup		-- Remove Group
  		     or XDDWrkCheckSel.EBGroup = @RemoveGroup1
  		     or XDDWrkCheckSel.EBChkWF = 'M')			-- or Manual Check Batch
  		and APDoc.Acct = XDDWrkCheckSel.Acct  
  		and APDoc.Sub = XDDWrkCheckSel.Sub  
  		and APDoc.DocType = XDDWrkCheckSel.DocType  
  		and APDoc.RefNbr = XDDWrkCheckSel.RefNbr  

  -- Should be APCheck/APCheckDet
  If not exists (SELECT * FROM APCheck (nolock) 
  			WHERE APCheck.BatNbr = @BatNbr)
  BEGIN
  	-- All documents deselected, void the batch
	UPDATE	Batch
	SET	Status = 'V'
	WHERE	BatNbr = @BatNbr
		and Module = 'AP'
		and OrigScrnNbr <> 'DD520'
  END			 
  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDWrkCheckSel_Remove_Batch] TO [MSDSL]
    AS [dbo];

