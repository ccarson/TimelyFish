 /****** Object:  Stored Procedure dbo.ARDocCustidRefNbrDocType_PWP    Script Date: 06/7/06 ******/
Create proc ARDocCustidRefNbrDocType_PWP @parm1 varchar ( 15), @parm2 varchar ( 10), @parm3 varchar ( 2) As

SELECT ARCpnyID = CpnyID, ARDocType = Doctype, ARProject = ProjectID, ARRefNbr = RefNbr,
       Custid, ARDocBal = DocBal, ARDueDate = DueDate
  FROM Ardoc
 WHERE ardoc.custid = @parm1
   AND ardoc.refnbr = @parm2
   AND ardoc.doctype = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDocCustidRefNbrDocType_PWP] TO [MSDSL]
    AS [dbo];

