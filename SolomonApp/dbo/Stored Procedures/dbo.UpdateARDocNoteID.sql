 CREATE PROCEDURE UpdateARDocNoteID @CustID CHAR(15), @DocType CHAR(2), @RefNbr CHAR(10), @NoteID INT AS
	UPDATE ARDoc SET NoteID=@NoteID WHERE CustID=@CustID AND DocType=@DocType AND RefNbr=@RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UpdateARDocNoteID] TO [MSDSL]
    AS [dbo];

