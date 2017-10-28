Create Procedure CF517p_ContractPV @parm1 varchar (10)
AS
    Select * from cftPSContr where ContrNbr like @parm1	Order by ContrNbr
