Create Procedure xScaleTkt_TktNbr @parm1 varchar (10) as 
    Select * from xScaleTkt Where TktNbr Like @parm1 Order by TktNbr
