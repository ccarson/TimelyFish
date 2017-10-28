Create Procedure xTstWgtHdr_TWKey @parm1 varchar (2) as 
    Select * from xTstWgtHdr Where TWKey = @parm1 Order by TWKey
