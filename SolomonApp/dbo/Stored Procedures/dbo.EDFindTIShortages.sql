 Create Proc EDFindTIShortages @Cpnyid varchar(10), @EDIPOID varchar(15) As
-- Create a temporary work table.  This table will automatically be dropped when the session
-- that created is terminated.
Create Table #POReconcile (OrdNbr varchar(15), SolShiptoId varchar(10), InvtId varchar(30), POQty Float, SOQty Float)
-- Populate the work table with the values from EDI.
Insert Into #POReconcile Select ' ',A.SolShipToId, B.InvtId, A.Qty, 0 From ED850SDQ A Inner Join
  ED850LineItem B On A.CpnyId = B.CpnyId And A.EDIPOID = B.EDIPOID And A.LineId = B.Lineid
  Where A.CpnyId = @CpnyId And A.EDIPOID = @EDIPOID
-- Add the order numbers
Update #POReconcile Set OrdNbr = B.OrdNbr From #POReconcile A Inner Join SOHeader B On
  A.SolShipToId = B.ShipToId Where B.Cancelled = 0 And B.EDIPOID = @EDIPOID
-- Add the sales order qty's
Update #POReconcile Set SOQty = C.Qtyord From #POReconcile A Inner Join SOHeader B On
  A.OrdNbr = B.OrdNbr Inner Join SOLine C On B.CpnyId = C.CpnyId And B.OrdNbr = C.OrdNbr
  And A.InvtId = C.InvtId
-- Select the lines that are different
Select OrdNbr, InvtId, IsNull(SOQty,0), POQty From #POReconcile Where SOQty <> POQty Order By OrdNbr





GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDFindTIShortages] TO [MSDSL]
    AS [dbo];

