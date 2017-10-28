create proc Released_Apdocs @BatNbr varchar(10) As
Set NoCount ON
Select Count(*) from apdoc With(NoLock) where batnbr = @batNbr and rlsed = '1'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Released_Apdocs] TO [MSDSL]
    AS [dbo];

