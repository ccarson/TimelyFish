
Create Proc Fetch_Invt_ProductLineID @parm1 varchar ( 30) as
        SELECT InvtID, ProdLineID
          FROM InventoryADG 
         WHERE InvtId = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Fetch_Invt_ProductLineID] TO [MSDSL]
    AS [dbo];

