CREATE PROCEDURE XBDetermineFormat @BatNbr char(10) AS
select distinct RepFormat from XAPCheck where batnbr = @BatNbr




GO
GRANT CONTROL
    ON OBJECT::[dbo].[XBDetermineFormat] TO [MSDSL]
    AS [dbo];

