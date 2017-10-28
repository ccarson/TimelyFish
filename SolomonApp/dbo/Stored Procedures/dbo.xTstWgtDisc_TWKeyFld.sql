Create Procedure xTstWgtDisc_TWKeyFld @parm1 varchar (2), @parm2 varchar (5) as 
    Select * from xTstWgtDisc Where TWKey = @parm1 and KeyFld Like @parm2 Order by TWKey, Wgt
