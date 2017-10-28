 Create Proc Delete_TrnsfrDoc_BatNbr @parm1 varchar ( 10) as

    Exec Delete_LotSerT_BatNbr @Parm1

    Delete INTran
           from INTran
	   where BatNbr = @parm1

    Delete TrnsfrDoc
           from TrnsfrDoc
           where BatNbr = @parm1


