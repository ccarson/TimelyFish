 Create Proc Delete_LotSerT_RefNbr @BatNbr varchar (10), @RefNbr as varchar(10) as

    CREATE TABLE #Deleted_LotSerT (
	         InvtId               Char (30),
        	 SiteId               Char (10),
	         WhseLoc              Char (10),
                 LotSerNbr            Char (25),
	         tstamp timestamp)

    IF @@ERROR <> 0 GOTO ABORT

    --Save original LotSerT Records
    Insert #Deleted_LotSert (InvtId, SiteId, WhseLoc, LotSerNbr)
           Select InvtId, SiteId, WhseLoc, LotSerNbr
                  From LotSert
                  Where BatNbr = @BatNbr
		  and RefNbr = @RefNbr
                    And Rlsed = 0

    Delete LotSerT from LotSerT where BatNbr = @BatNbr and RefNbr = @RefNbr and Rlsed = 0

    --Delete LotSerMst Record for this Batch if no other LotSerT Records Exists
    Delete M
           From LotSerMst M Join #Deleted_LotSerT D
                              On M.InvtId = D.InvtId
                             And M.SiteId = D.SiteId
                             And M.WhseLoc = D.WhseLoc
                             And M.LotSerNbr = D.LotSerNbr
                            Left Outer Join LotSerT L
                              On M.InvtId = L.InvtId
                             And M.SiteId = L.SiteId
                             And M.WhseLoc = L.WhseLoc
                             And M.LotSerNbr = L.LotSerNbr
           Where L.LotSerNbr is Null
Abort:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Delete_LotSerT_RefNbr] TO [MSDSL]
    AS [dbo];

