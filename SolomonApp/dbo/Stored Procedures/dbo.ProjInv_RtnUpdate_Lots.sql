 CREATE Proc ProjInv_RtnUpdate_Lots @CpnyId varchar(10), @RcptNbr varchar(15), @QtyPrec int, @LUpd_Prog VarChar(8), @LUpd_User VarChar(10)
 As

Declare @CPSOnOff int
Declare @InvtID Varchar(30)
Declare @SiteID Varchar(10)
Declare @WhseLoc VarChar(10)
Declare @LotSerNbr VarChar(25)

-- initialize
Set @CPSOnOff = (select CPSOnOff from Insetup)

--sales orders
Declare csr_Rtn Cursor For SELECT DISTINCT l.InvtID, l.SiteID, l.WhseLoc 
                             FROM INPrjAllocationLot l WITH(NOLOCK) 
                            WHERE l.SrcNbr = @RcptNbr AND l.SrcType = 'RN'  

Open csr_Rtn
Fetch Next From csr_Rtn Into @InvtID, @SiteID, @WhseLoc
  While @@Fetch_Status = 0
    Begin
    
	  --Update ItemSite and Location
      exec ProjInv_Plan_UpdtInvtOrderQtys @InvtID, @SiteID, @WhseLoc, @CPSOnOff, @QtyPrec, @LUpd_Prog, @LUpd_User

      Fetch Next From csr_Rtn Into  @InvtID, @SiteID, @WhseLoc
    End
Close csr_Rtn
Deallocate csr_Rtn


Declare csr_RtnLots Cursor For Select Distinct i.InvtID, i.SiteID, i.WhseLoc, i.LotSerNbr
                                     FROM INPrjAllocationLot i WITH(NOLOCK) 
                                    WHERE i.SrcNbr = @RcptNbr AND i.SrcType = 'RN' 

Open csr_RtnLots

Fetch Next From csr_RtnLots Into @InvtID, @SiteID, @WhseLoc,@LotSerNbr
  While @@Fetch_Status = 0
    Begin

        --Update LotSerMst
		exec ProjInv_Plan_UpdtInvtOrderLotQtys @InvtID, @SiteID, @WhseLoc, @LotSerNbr, @CPSOnOff, @QtyPrec, @LUpd_Prog, @LUpd_User

		Fetch Next From csr_RtnLots Into  @InvtID, @SiteID, @WhseLoc,@LotSerNbr
	End
		
Close csr_RtnLots

Deallocate csr_RtnLots



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_RtnUpdate_Lots] TO [MSDSL]
    AS [dbo];

