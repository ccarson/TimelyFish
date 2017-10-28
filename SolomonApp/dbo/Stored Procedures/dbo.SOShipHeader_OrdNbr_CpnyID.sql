 Create Proc SOShipHeader_OrdNbr_CpnyID @parm1 varchar ( 15) , @parm2 varchar(10) as
    Select * from SOShipHeader where CpnyID like @parm2 and OrdNbr like @parm1
                  order by OrdNbr


