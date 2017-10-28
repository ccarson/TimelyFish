
Create Procedure ProjInv_AutoFTT_Issues 
       @BatNbr VarChar(10), 
       @CpnyID VarChar(10) 

AS

     SELECT DISTINCT CASE WHEN i.TranType = 'RP' 
                            THEN i.RefNbr 
                          ELSE i.SRCNBR END SrcNbr, 
                     CASE WHEN i.TranType = 'RP' 
                            THEN 'RFI' 
                          ELSE SRCTYPE END SrcType,
                     i.TRANTYPE,
                     CASE WHEN i.TranType = 'II' 
                            THEN i.RefNbr
                          ELSE ' ' END IssueRefNbr
       FROM INTRAN i WITH(NOLOCK)
      WHERE ((i.TranType = 'II' AND i.SrcNbr <> ' ') OR i.TranType = 'RP')
        AND i.ProjectID <> ''
        AND i.Batnbr = @BatNbr
        AND i.CpnyID = @CpnyID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_AutoFTT_Issues] TO [MSDSL]
    AS [dbo];

