 CREATE PROC [dbo].[AR08690_pre]
	@ri_id		smallint
as

        ---  Clean up old records if any

        DELETE FROM AR08690_Wrk
        WHERE   RI_ID = @RI_ID

        ---  Update the where clause with the ri_id

        EXEC    SetRIWhere_sp   @ri_id, 'AR08690_Wrk'

        ---  Insert check records into the work table
        ---  which are currently selected

        INSERT  AR08690_Wrk (RI_ID, ClassID, Descr ,Customer_CustID, ARHist_FiscYr, ARHist_PTDCOGS00,
							ARHist_PTDCOGS01, ARHist_PTDCOGS02, ARHist_PTDCOGS03, ARHist_PTDCOGS04,
							ARHist_PTDCOGS05, ARHist_PTDCOGS06, ARHist_PTDCOGS07, ARHist_PTDCOGS08,
							ARHist_PTDCOGS09, ARHist_PTDCOGS10, ARHist_PTDCOGS11, ARHist_PTDCOGS12,
							ARHist_PTDCRMemo00, ARHist_PTDCRMemo01, ARHist_PTDCRMemo02, ARHist_PTDCRMemo03,
							ARHist_PTDCRMemo04, ARHist_PTDCRMemo05, ARHist_PTDCRMemo06, ARHist_PTDCRMemo07,
							ARHist_PTDCRMemo08,ARHist_PTDCRMemo09, ARHist_PTDCRMemo10, ARHist_PTDCRMemo11,
							ARHist_PTDCRMemo12, ARHist_PTDDisc00, ARHist_PTDDisc01, ARHist_PTDDisc02,
							ARHist_PTDDisc03, ARHist_PTDDisc04, ARHist_PTDDisc05, ARHist_PTDDisc06,
							ARHist_PTDDisc07, ARHist_PTDDisc08, ARHist_PTDDisc09, ARHist_PTDDisc10,
							ARHist_PTDDisc11, ARHist_PTDDisc12, ARHist_PTDDRMemo00, ARHist_PTDDRMemo01,
							ARHist_PTDDRMemo02, ARHist_PTDDRMemo03, ARHist_PTDDRMemo04, ARHist_PTDDRMemo05,
							ARHist_PTDDRMemo06, ARHist_PTDDRMemo07, ARHist_PTDDRMemo08, ARHist_PTDDRMemo09,
							ARHist_PTDDRMemo10, ARHist_PTDDRMemo11, ARHist_PTDDRMemo12, ARHist_PTDSales00,
							ARHist_PTDSales01, ARHist_PTDSales02, ARHist_PTDSales03, ARHist_PTDSales04,
							ARHist_PTDSales05, ARHist_PTDSales06, ARHist_PTDSales07, ARHist_PTDSales08,
							ARHist_PTDSales09, ARHist_PTDSales10, ARHist_PTDSales11, ARHist_PTDSales12)
        SELECT  DISTINCT
                @RI_ID,
                CustClass.ClassID,
                CustClass.Descr,
                Customer.CustID,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,

                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL

        FROM CustClass
			left outer join CUSTOMER
				on CustClass.ClassID = Customer.ClassID

        ---  Update the arHist information

        EXEC    ar08690_pre1    @ri_id


