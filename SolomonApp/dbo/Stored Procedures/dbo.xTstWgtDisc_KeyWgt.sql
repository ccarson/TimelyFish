Create Procedure xTstWgtDisc_KeyWgt @parm1 varchar (2), @parm2 float as 
    Select * from xTstWgtDisc Where TWKey = @parm1 and Wgt = @parm2
