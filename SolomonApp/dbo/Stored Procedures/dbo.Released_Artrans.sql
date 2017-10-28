create proc Released_Artrans @BatNbr varchar(10) As
Set NoCount ON
Select Count(*) from artran With(NoLock) where batnbr = @batNbr and rlsed = '1'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Released_Artrans] TO [MSDSL]
    AS [dbo];

