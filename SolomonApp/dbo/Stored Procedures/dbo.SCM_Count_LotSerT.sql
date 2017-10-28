 /*	This procedure is used by INBR and will calculate the correct
	number for INTran.LotSerCntr
*/
create procedure SCM_Count_LotSerT
	@InvtID		varchar (30),
	@BatNbr		varchar (10) As

	Select Count(*) from LotSerT
		Where 	LotSerT.BatNbr = @BatNbr
			And LotSerT.InvtID = @InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Count_LotSerT] TO [MSDSL]
    AS [dbo];

