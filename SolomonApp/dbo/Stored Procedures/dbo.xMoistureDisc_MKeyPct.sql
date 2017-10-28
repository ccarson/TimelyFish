Create Procedure xMoistureDisc_MKeyPct @parm1 varchar (2), @parm2 float as 
    Select * from xMoistureDisc Where MstKey = @parm1 and MstPct = @parm2 
