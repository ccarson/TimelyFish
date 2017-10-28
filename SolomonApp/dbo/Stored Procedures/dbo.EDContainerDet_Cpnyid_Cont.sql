 CREATE PROCEDURE EDContainerDet_Cpnyid_Cont  @parm1 varchar(10), @parm2 varchar(10) AS
Select *
From EDContainerDet
Where Cpnyid like @Parm1 and ContainerID like @Parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDContainerDet_Cpnyid_Cont] TO [MSDSL]
    AS [dbo];

