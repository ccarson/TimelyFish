 CREATE PROC [dbo].[AP03673_pre]
	@ri_id		smallint
as

        ---  Clean up old records if any

        DELETE FROM AP03673_Wrk
        WHERE   RI_ID = @RI_ID


        ---  Update the where clause with the ri_id

        EXEC    SetRIWhere_sp   @ri_id, 'AP03673_Wrk'


        ---  Insert check records into the work table
        ---  which are currently selected

        INSERT  AP03673_Wrk (RI_ID, ClassID, Descr, Vendor_VendID, APHist_CpnyID, APHist_FiscYr,
							APHist_PtdCrAdjs00, APHist_PtdCrAdjs01, APHist_PtdCrAdjs02, APHist_PtdCrAdjs03,
							APHist_PtdCrAdjs04, APHist_PtdCrAdjs05, APHist_PtdCrAdjs06, APHist_PtdCrAdjs07,
							APHist_PtdCrAdjs08, APHist_PtdCrAdjs09, APHist_PtdCrAdjs10, APHist_PtdCrAdjs11,
							APHist_PtdCrAdjs12, APHist_PtdDiscTkn00, APHist_PtdDiscTkn01, APHist_PtdDiscTkn02,
							APHist_PtdDiscTkn03, APHist_PtdDiscTkn04, APHist_PtdDiscTkn05, APHist_PtdDiscTkn06,
							APHist_PtdDiscTkn07, APHist_PtdDiscTkn08, APHist_PtdDiscTkn09, APHist_PtdDiscTkn10,
							APHist_PtdDiscTkn11, APHist_PtdDiscTkn12, APHist_PtdDrAdjs00, APHist_PtdDrAdjs01,
							APHist_PtdDrAdjs02, APHist_PtdDrAdjs03, APHist_PtdDrAdjs04, APHist_PtdDrAdjs05,
							APHist_PtdDrAdjs06,APHist_PtdDrAdjs07, APHist_PtdDrAdjs08, APHist_PtdDrAdjs09,
							APHist_PtdDrAdjs10, APHist_PtdDrAdjs11, APHist_PtdDrAdjs12, APHist_PtdDrAdjs13,
							APHist_PtdPaymt00, APHist_PtdPaymt01, APHist_PtdPaymt02, APHist_PtdPaymt03,
							APHist_PtdPaymt04, APHist_PtdPaymt05, APHist_PtdPaymt06, APHist_PtdPaymt07,
							APHist_PtdPaymt08, APHist_PtdPaymt09, APHist_PtdPaymt10, APHist_PtdPaymt11,
							APHist_PtdPaymt12, APHist_PtdPurch00, APHist_PtdPurch01, APHist_PtdPurch02,
							APHist_PtdPurch03, APHist_PtdPurch04, APHist_PtdPurch05, APHist_PtdPurch06,
							APHist_PtdPurch07, APHist_PtdPurch08, APHist_PtdPurch09, APHist_PtdPurch10,
							APHist_PtdPurch11, APHist_PtdPurch12)
        SELECT  DISTINCT
                @RI_ID,
                VendClass.ClassID,
                VendClass.Descr,
                Vendor.VendID,
                APHist.CpnyID,
                APHist.FiscYr,
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

        FROM VendClass LEFT OUTER JOIN Vendor ON VendClass.ClassID = Vendor.ClassID
        	LEFT OUTER JOIN APHist ON APHist.VendID = Vendor.VendID


        ---  Update the apHist information

        EXEC    AP03673_pre1    @ri_id

	
