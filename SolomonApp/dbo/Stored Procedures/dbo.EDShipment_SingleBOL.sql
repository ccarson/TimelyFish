 CREATE Proc EDShipment_SingleBOL @parm1 varchar (20)  AS
Select * from EDShipment where bolnbr like @parm1 order by bolnbr


