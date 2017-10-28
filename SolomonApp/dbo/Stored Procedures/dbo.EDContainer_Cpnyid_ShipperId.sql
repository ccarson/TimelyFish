 -- Created by Will Byron CEPSystems 5/11/99
CREATE PROCEDURE EDContainer_Cpnyid_ShipperId @parm1 varchar(10), @parm2 varchar(15)  AS
Select * from EDContainer
Where Cpnyid like @parm1 and
ShipperID like @parm2
Order BY Shipperid


