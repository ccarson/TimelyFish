 Create Proc SOHeader_SOTypeID_OrdNbr @parm1 varchar ( 4), @parm2 varchar ( 15) as
    Select * from SOHeader where SOTypeID like @parm1

       and OrdNbr like @parm2
                  order by OrdNbr, SOTypeID


