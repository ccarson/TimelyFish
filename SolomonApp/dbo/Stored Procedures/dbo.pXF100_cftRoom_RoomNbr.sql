Create Procedure pXF100_cftRoom_RoomNbr @parm1 varchar (6), @parm2 varchar (10) as 
    Select * from cftRoom Where ContactId = @parm1 and RoomNbr = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF100_cftRoom_RoomNbr] TO [MSDSL]
    AS [dbo];

