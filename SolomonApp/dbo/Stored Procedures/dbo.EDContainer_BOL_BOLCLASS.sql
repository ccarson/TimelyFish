 Create Procedure EDContainer_BOL_BOLCLASS @parm1 varchar(20) As
Select * from EDContainer A, EDContainerDet B, inventoryadg C,  EDBOLCLASS D
where A.BOLNbr = @parm1 and A.ContainerId = B.ContainerId  and b.invtid = c.invtid
and c.BOLClass = D.BOLClass order by A.ContainerId, c.BOLClass



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainer_BOL_BOLCLASS] TO [MSDSL]
    AS [dbo];

