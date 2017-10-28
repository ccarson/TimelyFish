
CREATE VIEW [QQ_poreceipt]
AS
SELECT     R.BatNbr AS [Batch Number], B.Status AS [Batch Status], B.Rlsed AS [Batch Released], 
                      R.PONbr AS [PO Number], R.RcptType AS [Receipt/Return], R.RcptNbr AS [Receipt Number], 
                      convert(date,R.RcptDate) AS [Receipt Date], R.Status AS [Receipt Status], R.VendID AS [Vendor ID], 
                      R.PerEnt AS [Period Entered], R.PerClosed AS [Period Closed], R.VouchStage AS [Vouchered Stage], 
                      R.APRefno AS [AP Reference Number], R.RcptQty AS [Receipt Quantity], R.RcptQtyTot AS [Quantity Total], 
                      R.RcptCtrlQty AS [Control Quantity], R.RcptAmt AS [Receipt Amount], R.RcptAmtTot AS [Amount Total], 
                      R.RcptCtrlAmt AS [Control Amount], R.CpnyID AS [Company ID], R.CreateAD AS [Auto Create Voucher/AD], convert(date,R.Crtd_DateTime) AS [Created Date/Time], 
                      R.Crtd_Prog AS [Created Program], R.Crtd_User AS [Created User], convert(date,R.CuryEffDate) AS [Currency Effective Date], 
                      R.CuryFreight AS [Currency Freight Amount], R.CuryID AS [Currency ID], R.CuryMultDiv AS [Currency Multiply/Divide], 
                      R.CuryRate AS [Currency Rate], R.CuryRateType AS [Currency Rate Type], R.CuryRcptAmt AS [Currency Receipt Amount], 
                      R.CuryRcptAmtTot AS [Currency Receipt Amount Total], R.CuryRcptCtrlAmt AS [Currency Receipt Control Amount], 
                      R.CuryRcptItemTotal AS [Currency Receipt Item Total], R.DfltFromPO AS [Default from PO], 
                      R.ExcludeFreight AS [Exclude Freight from Discount], R.Freight AS [Freight Amount], R.InBal AS [In Balance], 
                      convert(date,R.LUpd_DateTime) AS [Last Updated Date/Time], R.LUpd_Prog AS [Last Updated Program], 
                      R.LUpd_User AS [Last Updated User], R.NoteID, R.OpenDoc AS [Open Document], 
                      R.PC_Status AS [Project Controller Status], R.ProjectID, R.RcptItemTotal AS [Receipt Item Total], R.ReopenPO, 
                      R.Rlsed AS [Receipt Released], R.RMAID AS [Return Materials Authorization ID], R.S4Future11 AS [EDI Invoice ID], R.ServiceCallID, 
                      R.User1, R.User2, R.User3, R.User4, R.User5, R.User6, convert(date,R.User7) AS [User7], 
                      convert(date,R.User8) AS [User8], R.VendInvcNbr AS [Vendor Invoice Number], R.WayBillNbr AS [Way Bill Number]
FROM	POReceipt R with (nolock) 
			INNER JOIN Batch B with (nolock) ON R.BatNbr = B.BatNbr AND R.CpnyID = B.CpnyID
			WHERE B.Module = 'PO'

