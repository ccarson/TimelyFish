CREATE PROCEDURE XAPCheck_BatNbr_All @BatNbr char(10) AS
Select distinct BatNbr, CpnyID, Acct, Sub from XAPCheck where BatNbr like @BatNbr  and Printed = 1 order by BatNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XAPCheck_BatNbr_All] TO [MSDSL]
    AS [dbo];

