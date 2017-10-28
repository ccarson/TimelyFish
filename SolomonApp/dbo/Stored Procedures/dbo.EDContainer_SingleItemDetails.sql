 CREATE PROCEDURE EDContainer_SingleItemDetails @parm1 varchar(10), @parm2 varchar( 20 ), @parm3  varchar( 5 )  AS
select * from edcontainerdet, edcontainer  where edcontainerdet.cpnyid = @parm1 and edcontainerdet.shipperid = @parm2 and edcontainerdet.lineref = @parm3 and edcontainerdet.containerid = edcontainer.containerid order by edcontainerdet.linenbr


