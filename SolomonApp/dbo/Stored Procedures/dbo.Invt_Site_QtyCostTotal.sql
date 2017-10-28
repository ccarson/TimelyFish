 Create Proc Invt_Site_QtyCostTotal
    @Parm1 VarChar(30)

as
 Select Sum(QtyOnHand),Sum(TotCost)
  From ItemSite
  Where Invtid = @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Invt_Site_QtyCostTotal] TO [MSDSL]
    AS [dbo];

