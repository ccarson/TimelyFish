 Create Proc SOShipHeader_OrdNbr @parm1 varchar ( 15) as
    Select * from SOShipHeader where OrdNbr like @parm1
                  order by OrdNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_OrdNbr] TO [MSDSL]
    AS [dbo];

