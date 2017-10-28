 CREATE PROCEDURE EDContainer_Cpnyid_ContainerID @parm1 varchar(10), @parm2 varchar(10)  AS
Select * from EDContainer
Where Cpnyid like @parm1 and
ContainerID like @parm2
Order BY ContainerID


