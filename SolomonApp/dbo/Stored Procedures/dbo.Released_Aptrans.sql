create proc Released_Aptrans @BatNbr varchar(10) As
Set NoCount ON
Select Count(*) from aptran With(NoLock) where batnbr = @batNbr and rlsed = '1'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Released_Aptrans] TO [MSDSL]
    AS [dbo];

