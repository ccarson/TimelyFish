Create Procedure CF300p_cftFeedOrder_SrcOrdNbr @parm1 varchar (10) as 
    Select * from cftFeedOrder JOIN cftContact on cftFeedOrder.ContactID=cftContact.ContactID Where DateReq>=GetDate()-30 and OrdNbr Like @parm1 Order by OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF300p_cftFeedOrder_SrcOrdNbr] TO [MSDSL]
    AS [dbo];

