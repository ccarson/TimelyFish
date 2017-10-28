 CREATE Proc ED850Header_StatusUpdate @CpnyId varchar(10), @EDIPOID varchar(10), @CustId varchar(10),@UpdateStatus varchar(2), @SolShipToNbr varchar(10), @NbrLines smallint As
Update ED850Header Set CustId = @CustId, UpdateStatus = @UpdateStatus, SolShipToNbr = @SolShipToNbr, NbrLines = @NbrLines
Where CpnyId = @CpnyId And EDIPOID = @EDIPOID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED850Header_StatusUpdate] TO [MSDSL]
    AS [dbo];

