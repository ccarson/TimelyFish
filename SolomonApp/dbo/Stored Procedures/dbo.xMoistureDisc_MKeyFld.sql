Create Procedure xMoistureDisc_MKeyFld @parm1 varchar (2), @parm2 varchar (5) as 
    Select * from xMoistureDisc Where MstKey = @parm1 and KeyFld Like @parm2 Order by MstKey, MstPct
