 /****** Object:  Stored Procedure dbo.EDContainerDet_Invtid    Script Date: 5/28/99 1:17:40 PM ******/
CREATE PROCEDURE EDContainerDet_InvtidDMG @parm1 varchar(10) AS
Select Distinct Invtid
From EDContainerDet
Where ContainerID like @Parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_InvtidDMG] TO [MSDSL]
    AS [dbo];

