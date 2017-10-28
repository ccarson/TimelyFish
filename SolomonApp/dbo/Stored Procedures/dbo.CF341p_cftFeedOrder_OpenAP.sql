
Create Procedure CF341p_cftFeedOrder_OpenAP @parm1 varchar (2) as 
    Select * from cftFeedOrder Where BatNbrIN = '' and BatNbrAP = '' and Status = @parm1
	Order by OrdNbr

