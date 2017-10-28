
CREATE PROCEDURE XDDMCB_APDoc_Delete
	@BatNbr		    varchar( 10 ),
	@RefNbr         varchar( 10 ),
	@Upd_Prog       varchar( 8 ),
	@Upd_User       varchar( 10 )

AS

    -- Remove Document level
    DELETE    FROM APDoc
    WHERE     BatNbr = @BatNbr
              and RefNbr = @RefNbr

   -- Also remove the vouchers from Selection (Update APDoc - vouchers)
   -- APTrans for this check Batch
   --       UnitDesc = Voucher Number
   --       CostType = Doc Type
   UPDATE	APDoc
   SET		Selected = 0,
		    PmtAmt = 0,
		    CuryPmtAmt = 0,
		    DiscTkn = 0,
		    CuryDiscTkn = 0,
		    LUpd_Prog = @Upd_Prog,
		    LUpd_DateTime = GetDate(),
		    LUpd_User = @Upd_User
   WHERE    VendID+DocType+RefNbr
            IN (Select VendID+left(CostType,2)+left(UnitDesc,10) 
                FROM APTran (nolock) 
                WHERE BatNbr = @BatNbr 
                and RefNbr = @RefNbr)
                
   -- Remove detail level             
   DELETE    FROM APTran
   WHERE     BatNbr = @BatNbr
             and RefNbr = @RefNbr
              
