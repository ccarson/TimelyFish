create proc Released_Ardocs @BatNbr varchar(10) As
Set NoCount ON
Select Count(*) from ardoc With(NoLock) where batnbr = @batNbr and rlsed = '1'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Released_Ardocs] TO [MSDSL]
    AS [dbo];

