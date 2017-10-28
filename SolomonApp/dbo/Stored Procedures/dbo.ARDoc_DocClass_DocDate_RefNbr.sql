 Create Procedure ARDoc_DocClass_DocDate_RefNbr @parm1 smalldatetime, @parm2 varchar ( 10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
    Select * from ARDoc where ARDoc.DocClass = 'R'
        and ARDoc.NbrCycle > 0
        and ARDoc.DocDate <= @parm1
        and ARDoc.RefNbr like @parm2
        order by CuryId, RefNbr


