Create Procedure CF303p_cftRoom_RoomNbr @parm1 varchar (6), @parm2 varchar (10) as 
    Select * from cftRoom Where ContactId = @parm1 and RoomNbr = @parm2
