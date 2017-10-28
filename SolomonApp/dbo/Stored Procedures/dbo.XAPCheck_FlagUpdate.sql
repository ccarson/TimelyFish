CREATE PROCEDURE XAPCheck_FlagUpdate @BatNbr char(10) AS
Update XAPCheck set Printed = 1 where BatNbr = @BatNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XAPCheck_FlagUpdate] TO [MSDSL]
    AS [dbo];

