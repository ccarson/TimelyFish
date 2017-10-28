Create Procedure xMoistureHdr_MstKey @parm1 varchar (2) as 
    Select * from xMoistureHdr Where MstKey Like @parm1 Order by MstKey
