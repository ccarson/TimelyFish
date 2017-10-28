 Create Procedure WOSOLine_InvtID_OrdNbr_CustID
	@InvtID 	varchar(30),
	@OrdNbr 	varchar(15),
	@CustID		varchar(15)
as

	Select		*
	From		SOLine
	Where		Status = 'O'
	And 		InvtID = @InvtID
	And		QtyOrd >= 0
	And		OrdNbr IN (Select OrdNbr From SOHeader Where SOTypeID IN ('SO','CS','INVC','KA','RMSH','WC') and CustID = @CustID)
	And		OrdNbr LIKE @OrdNbr
	Order by 	InvtID, OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOSOLine_InvtID_OrdNbr_CustID] TO [MSDSL]
    AS [dbo];

