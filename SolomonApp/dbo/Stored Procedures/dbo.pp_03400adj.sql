 CREATE PROCEDURE pp_03400adj @UserAddress VARCHAR(21), @ProgID VARCHAR(8), @Sol_User VARCHAR(10), @DiscTknAcct VARCHAR(10),@DiscTknSub VARCHAR(24), @BaseDecPl INT, @BaseCuryID VARCHAR(10),@BkupWthldAcct varchar(10),@BkupWthldSub varchar(24), @result INT OUTPUT AS

/***** File Name: 0363pp_03400Adj.Sql				*****/

---DECLARE @Progid CHAR (8),
---        @Sol_User CHAR (10)

---SELECT @ProgID =   '03400',
---       @Sol_User = 'SOLOMON'

/****************************/
/***** APAdjust - Checks ****/
/****************************/

/***** Release 03620 - Checks Only					*****/
/***** All references to APDoc, APTran go to APCheck, APCheckDet	*****/
/***** AP Adjust - Checks Only *****/
INSERT APAdjust (AdjAmt, AdjBatNbr, AdjBkupWthld, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgAcct, AdjgDocDate,
	AdjgDocType, AdjgPerPost, AdjgRefNbr, AdjgSub,
        Crtd_DateTime, Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdbkupWthld, CuryAdjdCuryId, CuryAdjdDiscAmt,
	CuryAdjdMultDiv, CuryAdjdRate, CuryAdjgAmt, CuryAdjgbkupWthld, CuryAdjgDiscAmt, CuryRGOLAmt, DateAppl,
	LUpd_dateTime, LUpd_Prog, LUpd_User, PerAppl, prepay_refnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
        User1, User2, User3, User4, User5, User6, User7, User8, VendId)
	SELECT 
		CASE WHEN o.DocType = 'PP' THEN
			CASE  WHEN k.CuryID <> c.CuryID THEN
				ABS(k.PmtAmt)
			ELSE
			CASE WHEN c.CuryMultDiv = 'M' THEN
				abs(Round( convert(dec(28,3),k.CuryPmtAmt)*convert(dec(19,9),c.Curyrate), @BaseDecPl))
			ELSE
	  			abs(Round( convert(dec(28,3),k.CuryPmtAmt)/convert(dec(19,9),c.Curyrate), @BaseDecPl))
			END
			END
		ELSE

		CASE WHEN k.CuryID <> c.CuryID THEN

		CASE WHEN o.CuryMultDiv = 'M' THEN
			CASE WHEN k.CuryMultDiv = 'M' THEN
				CASE WHEN
					ABS(Round((convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt)+convert(dec(28,3),k.BWAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.BWAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocAmt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt)+convert(dec(28,3),k.BWAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.BWAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
				ELSE
				CASE WHEN
					ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt)+convert(dec(28,3),k.BWAmt))*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.BWAmt)/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocAmt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt)+convert(dec(28,3),k.BWAmt))*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.BWAmt)/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
			END
		ELSE
			CASE WHEN k.CuryMultDiv = 'M' THEN
				CASE WHEN
					ABS(Round((convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt+convert(dec(28,3),k.BWAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate)- (convert(dec(28,3),k.BWAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate)),@BaseDecPl))>o.OrigDocAmt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt+convert(dec(28,3),k.BWAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.BWAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate)),@BaseDecPl))
				END
				ELSE
				CASE WHEN
					ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt+convert(dec(28,3),k.BWAmt))*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.BWAmt)*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate)),@BaseDecPl))>o.OrigDocAmt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt+convert(dec(28,3),k.BWAmt))*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.BWAmt)*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate)),@BaseDecPl))
				END
			END		END
	 ELSE
		CASE WHEN o.CuryMultDiv = 'M' THEN
			CASE WHEN
				round(ABS( (convert(dec(28,3),k.CuryPmtAmt)+convert(dec(28,3),k.curydiscamt)+convert(dec(28,3),k.CuryBWAmt))*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.curydiscamt)*convert(dec(19,9),o.CuryRate))- (convert(dec(28,3),k.CuryBWAmt)*convert(dec(19,9),o.CuryRate))),@BaseDecPl)> o.docbal
			THEN
				o.docbal
			ELSE
				round(ABS( (convert(dec(28,3),k.CuryPmtAmt)+convert(dec(28,3),k.curydiscamt)+convert(dec(28,3),k.CuryBWAmt))*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.curydiscamt)*convert(dec(19,9),o.CuryRate))- (convert(dec(28,3),k.CuryBWAmt)*convert(dec(19,9),o.CuryRate))),@BaseDecPl)
			END

		ELSE
			CASE WHEN
				round(ABS( (convert(dec(28,3),k.CuryPmtAmt)+convert(dec(28,3),k.curydiscamt)+convert(dec(28,3),k.CuryBWAmt))/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.curydiscamt)/convert(dec(19,9),o.CuryRate))- (convert(dec(28,3),k.CuryBWAmt)*convert(dec(19,9),o.CuryRate))),@BaseDecPl)> o.docbal
			THEN
				o.docbal
			ELSE
				round(ABS( (convert(dec(28,3),k.CuryPmtAmt)+convert(dec(28,3),k.curydiscamt)+convert(dec(28,3),k.CuryBWAmt))/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.curydiscamt)/convert(dec(19,9),o.CuryRate))- (convert(dec(28,3),k.CuryBWAmt)*convert(dec(19,9),o.CuryRate))),@BaseDecPl)
			END
		END
	 END END,
	k.BatNbr,	
	CASE  WHEN k.CuryID <> c.CuryID THEN          -----------BWAmt
		CASE WHEN o.CuryMultDiv = 'M' THEN
		 	CASE WHEN k.CuryMultDiv = 'M' THEN
		  		abs(Round( Round((convert(dec(28,3),k.BWAmt)/convert(dec(19,9),k.Curyrate)),@BaseDecPl)*convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	ELSE
		  		abs(Round( Round((convert(dec(28,3),k.BWAmt)*convert(dec(19,9),k.Curyrate)),@BaseDecPl)*convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	END
		ELSE
		 	CASE WHEN k.CuryMultDiv = 'M' THEN
		  		abs(Round( Round((convert(dec(28,3),k.BWAmt)/convert(dec(19,9),k.Curyrate)),@BaseDecPl)/convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	ELSE
		  		abs(Round( Round((convert(dec(28,3),k.BWAmt)*convert(dec(19,9),k.Curyrate)),@BaseDecPl)/convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	END
		END

	ELSE
	 CASE WHEN k.CuryMultDiv = 'M' THEN
	  abs( convert(dec(28,3),k.curyBWAmt)*convert(dec(19,9),o.CuryRate))
	 ELSE
	  abs( convert(dec(28,3),k.curyBWAmt)/convert(dec(19,9),o.CuryRate))
	 END
	END,
	 k.DocType,
	CASE  WHEN k.CuryID <> c.CuryID THEN
		CASE WHEN o.CuryMultDiv = 'M' THEN
		 	CASE WHEN k.CuryMultDiv = 'M' THEN
		  		abs(Round( Round((convert(dec(28,3),k.DiscAmt)/convert(dec(19,9),k.Curyrate)),@BaseDecPl)*convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	ELSE
		  		abs(Round( Round((convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.Curyrate)),@BaseDecPl)*convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	END
		ELSE
		 	CASE WHEN k.CuryMultDiv = 'M' THEN
		  		abs(Round( Round((convert(dec(28,3),k.DiscAmt)/convert(dec(19,9),k.Curyrate)),@BaseDecPl)/convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	ELSE
		  		abs(Round( Round((convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.Curyrate)),@BaseDecPl)/convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	END
		END

	ELSE
	 CASE WHEN k.CuryMultDiv = 'M' THEN
		   abs( Round(convert(dec(28,3),k.curydiscamt)*convert(dec(19,9),o.CuryRate), @BaseDecPl))
	 ELSE
	  	   abs( Round(convert(dec(28,3),k.curydiscamt)/convert(dec(19,9),o.CuryRate), @BaseDecPl))
	 END
	END,
	k.RefNbr, c.Acct, c.DateEnt, c.CheckType,
	b.PerPost, c.CheckNbr, c.Sub, GETDATE(), @ProgID, @Sol_User,
	CASE  WHEN k.CuryID <> c.CuryID THEN
	 CASE WHEN k.CuryMultDiv = 'M' THEN
		CASE WHEN
	  		abs(Round( convert(dec(28,3),k.PmtAmt)/convert(dec(19,9),k.Curyrate), cur.DecPl))>o.CuryDocBal
		THEN
			o.CuryDocBal
		ELSE
			abs(Round( convert(dec(28,3),k.PmtAmt)/convert(dec(19,9),k.Curyrate), cur.DecPl))
		END
	 ELSE
	  	CASE WHEN
			abs(Round( convert(dec(28,3),k.PmtAmt)*convert(dec(19,9),k.Curyrate), cur.DecPl))>o.CuryDocBal
		THEN
			o.CuryDocBal
		ELSE
			abs(Round( convert(dec(28,3),k.PmtAmt)*convert(dec(19,9),k.Curyrate), cur.DecPl))
		END
	 END
	ELSE
	  ABS(k.CuryPmtAmt)
	END,
	
	CASE  WHEN k.CuryID <> c.CuryID THEN
	 CASE WHEN k.CuryMultDiv = 'M' THEN
	  abs(Round((convert(dec(28,3),k.BWAmt)/convert(dec(19,9),k.Curyrate)),cur.DecPl))
	 ELSE
	  abs(Round((convert(dec(28,3),k.BWAmt)*convert(dec(19,9),k.Curyrate)),cur.DecPl))
	 END
	ELSE
	 ABS(k.CuryBWAmt)
	END,
	 k.CuryId,
	CASE  WHEN k.CuryID <> c.CuryID THEN
	 CASE WHEN k.CuryMultDiv = 'M' THEN
	  abs(Round((convert(dec(28,3),k.DiscAmt)/convert(dec(19,9),k.Curyrate)),cur.DecPl))
	 ELSE
	  abs(Round((convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.Curyrate)),cur.DecPl))
	 END
	ELSE
	 ABS(k.CuryDiscAmt)
	END,
	k.CuryMultDiv, k.CuryRate,
	CASE  WHEN k.CuryID <> c.CuryID THEN
		ABS(k.CuryPmtAmt)
	ELSE
	  CASE WHEN c.CuryMultDiv = 'M' THEN
		abs(Round( convert(dec(28,3),k.CuryPmtAmt)*convert(dec(19,9),c.Curyrate), @BaseDecPl))
	  ELSE
	  	abs(Round( convert(dec(28,3),k.CuryPmtAmt)/convert(dec(19,9),c.Curyrate), @BaseDecPl))
	  END
	END,

	CASE  WHEN k.CuryID <> c.CuryID THEN
		ABS(k.CuryBWAmt)
	ELSE
	  CASE WHEN k.CuryMultDiv = 'M' THEN
	  	abs(Round( convert(dec(28,3),k.CuryBWAmt)*convert(dec(19,9),k.Curyrate), @BaseDecPl))
	  ELSE
	  	abs(Round( convert(dec(28,3),k.CuryBWAmt)/convert(dec(19,9),k.Curyrate), @BaseDecPl))
	  END
	END,

	CASE  WHEN k.CuryID <> c.CuryID THEN
		ABS(k.CuryDiscAmt)
	ELSE
	  CASE WHEN k.CuryMultDiv = 'M' THEN
	  	abs(Round( convert(dec(28,3),k.curydiscamt)*convert(dec(19,9),k.Curyrate), @BaseDecPl))
	  ELSE
	  	abs(Round( convert(dec(28,3),k.curydiscamt)/convert(dec(19,9),k.Curyrate), @BaseDecPl))
	  END
	END,

	---RGOL
CASE WHEN o.Doctype = 'PP' THEN 0 ELSE
	CASE WHEN k.CuryID <> c.CuryID THEN
		CASE WHEN k.Curyid = @BaseCuryID THEN
		0
		WHEN c.Curyid = @BaseCuryID THEN
		ABS(k.CuryPmtAmt)
		- ---subtract
		CASE WHEN k.CuryMultDiv = 'M' THEN
		  CASE WHEN o.CuryMultDiv = 'M' THEN
			CASE WHEN
				ABS(Round((convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocAmt
			THEN
				o.OrigDocAmt
			ELSE
				ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
			END
		  ELSE
			CASE WHEN
				ABS(Round((convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocAmt
			THEN
				o.OrigDocAmt
			ELSE
				ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate),@BaseDecPl))
			END
		  END
		ELSE ---k.CuryMultDiv = 'D'
		  CASE WHEN o.CuryMultDiv = 'D' THEN
			CASE WHEN
				ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocAmt
			THEN
				o.OrigDocAmt
			ELSE
				ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate),@BaseDecPl))
			END
		  ELSE
			CASE WHEN
				ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocAmt
			THEN
				o.OrigDocAmt
			ELSE
				ABS(Round( (convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
			END
		  END
		END

		ELSE
		 CASE WHEN k.CuryMultDiv = 'M' THEN
		 	CASE WHEN o.CuryMultDiv = 'M' THEN
				ABS(convert(dec(28,3),k.PmtAmt))-ABS(Round((convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
			ELSE
				ABS(convert(dec(28,3),k.PmtAmt))-ABS(Round((convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),k.DiscAmt))/convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate),@BaseDecPl))
			END
		 ELSE ---CASE WHEN k.CuryMultDiv = 'D' THEN
			CASE WHEN o.CuryMultDiv = 'D' THEN
				ABS(convert(dec(28,3),k.PmtAmt))-ABS(Round((convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)/convert(dec(19,9),o.CuryRate),@BaseDecPl))
			ELSE
				ABS(convert(dec(28,3),k.PmtAmt))-ABS(Round((convert(dec(28,3),k.PmtAmt)+convert(dec(28,3),k.DiscAmt))*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate) - convert(dec(28,3),k.DiscAmt)*convert(dec(19,9),k.CuryRate)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
			END
		 END
	 	END
	 ELSE
	 	CASE WHEN (convert(dec(19,9),c.Curyrate) = convert(dec(19,9),o.Curyrate)) AND (c.CuryMultDiv = o.CuryMultDiv) THEN
			0
		ELSE
		   CASE WHEN k.CuryMultDiv = 'M' THEN
			CASE WHEN c.CuryMultDiv = 'M' THEN
			   Round(abs( convert(dec(28,3),k.CuryPmtAmt)*convert(dec(19,9),c.Curyrate)), @BaseDecPl)+Round(abs( convert(dec(28,3),k.curydiscamt)*convert(dec(19,9),k.Curyrate)), @BaseDecPl) -
				CASE WHEN
					Round(ABS( convert(dec(28,3),k.CuryPmtAmt)+ convert(dec(28,3),k.curydiscamt))* convert(dec(19,9),o.CuryRate), @BaseDecPl)> o.docbal
				THEN
					o.docbal
				ELSE
					Round(ABS( convert(dec(28,3),k.CuryPmtAmt)+ convert(dec(28,3),k.curydiscamt))* convert(dec(19,9),o.CuryRate), @BaseDecPl)
				END
			ELSE
			   Round(abs( convert(dec(28,3),k.CuryPmtAmt)/convert(dec(19,9),c.Curyrate)), @BaseDecPl)+Round(abs( convert(dec(28,3),k.curydiscamt)*convert(dec(19,9),k.Curyrate)), @BaseDecPl) -
				CASE WHEN
					Round(ABS( convert(dec(28,3),k.CuryPmtAmt)+ convert(dec(28,3),k.curydiscamt))* convert(dec(19,9),o.CuryRate), @BaseDecPl)> o.docbal
				THEN
					o.docbal
				ELSE
					Round(ABS( convert(dec(28,3),k.CuryPmtAmt)+ convert(dec(28,3),k.curydiscamt))* convert(dec(19,9),o.CuryRate), @BaseDecPl)
				END
			END
		   ELSE ---CASE WHEN k.CuryMultDiv = 'D' THEN
			CASE WHEN c.CuryMultDiv = 'D' THEN
 		   	  Round(abs( convert(dec(28,3),k.CuryPmtAmt)/convert(dec(19,9),c.Curyrate))+abs( convert(dec(28,3),k.curydiscamt)/convert(dec(19,9),k.Curyrate)), @BaseDecPl) -
				CASE WHEN
					Round(ABS( convert(dec(28,3),k.CuryPmtAmt)+ convert(dec(28,3),k.curydiscamt))/ convert(dec(19,9),o.CuryRate), @BaseDecPl)> o.docbal
				THEN
					o.docbal
				ELSE
					Round(ABS( convert(dec(28,3),k.CuryPmtAmt)+ convert(dec(28,3),k.curydiscamt))/ convert(dec(19,9),o.CuryRate), @BaseDecPl)
				END
			ELSE
		   	  Round(abs( convert(dec(28,3),k.CuryPmtAmt)*convert(dec(19,9),c.Curyrate))+abs( convert(dec(28,3),k.curydiscamt)/convert(dec(19,9),k.Curyrate)), @BaseDecPl) -
				CASE WHEN
					Round(ABS( convert(dec(28,3),k.CuryPmtAmt)+ convert(dec(28,3),k.curydiscamt))/ convert(dec(19,9),o.CuryRate), @BaseDecPl)> o.docbal
				THEN
					o.docbal
				ELSE
					Round(ABS( convert(dec(28,3),k.CuryPmtAmt)+ convert(dec(28,3),k.curydiscamt))/ convert(dec(19,9),o.CuryRate), @BaseDecPl)
				END
			END
		   END
		END
	 END
END,

	c.DateEnt,
	GETDATE(), @ProgID, @Sol_User, b.PerPost, '',
	'', '', 0, 0, 0, 0, '', '', 0, 0, '', '',  '', '', 0, 0, '', '', '', '', c.VendID
FROM WrkRelease w inner loop join Batch b
	ON b.BatNbr = w.BatNbr AND b.Module = 'AP'
inner join APCheck c
	ON c.BatNbr = b.BatNbr
inner join APCheckDet k
	ON c.BatNbr = k.BatNbr  AND c.CheckRefNbr = k.CheckRefNbr
inner join APDoc o
	ON o.Doctype = k.DocType and o.RefNbr = k.RefNbr
inner join currncy cur
	ON k.curyid = cur.curyid
WHERE  w.Module = 'AP' AND w.UserAddress = @UserAddress
	IF @@ERROR < > 0 GOTO ABORT

/***** APAdjust - Prepayment Application - no MC or MC with non base check*****/
INSERT APAdjust (AdjAmt, AdjBatNbr, AdjBkupWthld, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgAcct, AdjgDocDate,
	AdjgDocType, AdjgPerPost, AdjgRefNbr, AdjgSub,
        Crtd_DateTime, Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdBkupWthld, CuryAdjdCuryId, CuryAdjdDiscAmt,
	CuryAdjdMultDiv, CuryAdjdRate, CuryAdjgAmt, CuryAdjgBkupWthld, CuryAdjgDiscAmt, CuryRGOLAmt, DateAppl,
	LUpd_dateTime, LUpd_prog, LUpd_User, PerAppl, prepay_refnbr, 
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,

        User1, User2, User3, User4, User5, User6, User7, User8, VendId)
SELECT
	CASE WHEN t.CuryMultDiv = 'M' THEN
		case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.DocBal then
			  d.DocBal
		     else
			abs(Round( convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	ELSE
	  	case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.DocBal then
			 d.DocBal
		     else
			abs(Round( convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	END,
	j.AdjBatNbr, j.AdjBkupWthld , t.TranType,
	0, t.RefNbr, j.AdjgAcct, j.AdjgDocDate,
	j.AdjgDocType, d.PerPost, j.AdjgRefNbr,  j.AdjgSub, GETDATE(), @ProgID, @Sol_User,
	CASE WHEN j.CuryAdjdCuryID = t.CuryID  THEN
		CASE WHEN j.CuryAdjdAmt > d.curyDocBal THEN
			d.curydocbal
		ELSE
			j.curyadjdamt
		END
		ELSE
	  CASE WHEN t.CuryMultDiv = 'D' THEN
		case when abs(Round( convert(dec(28,3),j.AdjAmt)*convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.curyDocBal then
			  d.curyDocBal
		     else
			abs(Round( convert(dec(28,3),j.AdjAmt)*convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	  ELSE
	  	case when abs(Round( convert(dec(28,3),j.AdjAmt)/convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.curyDocBal then
			 d.curyDocBal
		     else
			abs(Round( convert(dec(28,3),j.AdjAmt)/convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	  END

	END,
		CASE WHEN j.CuryAdjdCuryID = t.CuryID  THEN
		CASE WHEN j.CuryAdjdBkupWthld > d.CuryBWAmt THEN
			d.CuryBWAmt
		ELSE
			j.CuryAdjdBkupWthld
		END
		ELSE
	  CASE WHEN t.CuryMultDiv = 'D' THEN
		case when abs(Round( convert(dec(28,3),j.AdjBkupWthld)*convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.CuryBWAmt then
			  d.CuryBWAmt
		     else
			abs(Round( convert(dec(28,3),j.AdjBkupWthld)*convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	  ELSE
	  	case when abs(Round( convert(dec(28,3),j.AdjBkupWthld)/convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.CuryBWAmt then
			 d.CuryBWAmt
		     else
			abs(Round( convert(dec(28,3),j.AdjBkupWthld)/convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	  END

	END
	, t.CuryId, 0, t.CuryMultDiv, t.CuryRate,	
	Round(
	CASE WHEN j.CuryAdjdCuryID = t.CuryID THEN
	  CASE WHEN j.CuryadjdMultDiv = 'M' THEN
			case when abs(Round(convert(dec(28,3),j.CuryAdjdAmt), c.decpl)) > d.curyDocBal then
				abs(Round(convert(dec(28,3),d.curyDocBal) * convert(dec(19,9),j.Curyadjdrate),c.decpl))
		     	else
				abs(Round(convert(dec(28,3),j.CuryAdjdAmt) * convert(dec(19,9),j.Curyadjdrate), c.decpl))
		     	end

	  ELSE
			case when abs(Round(convert(dec(28,3),j.CuryAdjdAmt) , c.decpl)) > d.curyDocBal then
				abs(Round(convert(dec(28,3),d.curyDocBal) / convert(dec(19,9),j.Curyadjdrate), c.decpl))
		     	else
				abs(Round(convert(dec(28,3),j.CuryAdjdAmt) / convert(dec(19,9),j.Curyadjdrate),c.decpl))
		     	end
	  END
	ELSE
		CASE WHEN j.CuryAdjgAmt > d.DocBal THEN
			d.docbal
		ELSE
			j.curyadjgamt
		END
	END,@BaseDecPl), 
	Round(
	CASE WHEN j.CuryAdjdCuryID = t.CuryID THEN
	  CASE WHEN j.CuryadjdMultDiv = 'M' THEN
			case when abs(Round(convert(dec(28,3),j.CuryAdjdBkupWthld), c.decpl)) > d.CuryBWAmt then
				abs(Round(convert(dec(28,3),d.CuryBWAmt) * convert(dec(19,9),j.Curyadjdrate),c.decpl))
		     	else
				abs(Round(convert(dec(28,3),j.CuryAdjdBkupWthld) * convert(dec(19,9),j.Curyadjdrate), c.decpl))
		     	end

	  ELSE
			case when abs(Round(convert(dec(28,3),j.CuryAdjdBkupWthld) , c.decpl)) > d.CuryBWAmt then
				abs(Round(convert(dec(28,3),d.CuryBWAmt) / convert(dec(19,9),j.Curyadjdrate), c.decpl))
		     	else
				abs(Round(convert(dec(28,3),j.CuryAdjdBkupWthld) / convert(dec(19,9),j.Curyadjdrate),c.decpl))
		     	end
	  END
	ELSE
		CASE WHEN j.CuryAdjgBkupWthld > d.BWAmt THEN
			d.BWAmt
		ELSE
			j.CuryAdjgBkupWthld
		END
	END,@BaseDecPl),
	0,

	---rgol
	Round(
	CASE WHEN j.CuryAdjdCuryID <> t.CuryID  THEN
		---3rd currency not allowed for pre-pays,
		---no rgol if this is a BAS cury doc being applied to
		0
	ELSE
	  CASE WHEN convert(dec(19,9),t.Curyrate) = convert(dec(19,9),j.CuryAdjdRate) THEN
			0
  	  ELSE
		CASE WHEN j.CuryAdjdCuryID = t.CuryID THEN
	  	  CASE WHEN j.CuryadjdMultDiv = 'M' THEN
			case when abs(Round(convert(dec(28,3),j.CuryAdjdAmt), c.decpl))> d.curyDocBal then
			  	convert(dec(28,3),d.curyDocBal)*convert(dec(19,9),j.Curyadjdrate)
		     	else
				abs(Round(convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),j.Curyadjdrate), c.decpl))
		     	end
	  	  ELSE
			case when abs(Round(convert(dec(28,3),j.CuryAdjdAmt), c.decpl))> d.curyDocBal then
			  	convert(dec(28,3),d.curyDocBal)/convert(dec(19,9),j.Curyadjdrate)
		     	else
				abs(Round(convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),j.Curyadjdrate), c.decpl))
		     	end
	   	  END
		ELSE
			CASE WHEN j.CuryAdjgAmt > d.DocBal THEN
				d.docbal
			ELSE
				j.curyadjgamt
			END
		END
		- ---subtract
		CASE WHEN j.CuryAdjdCuryID = t.CuryID THEN
	  		CASE WHEN t.CuryMultDiv = 'M' THEN
				case when abs(Round(convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),t.Curyrate), c.decpl))> d.DocBal then
			  		d.DocBal
		     		else
					abs(Round(convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),t.Curyrate), c.decpl))
		     		end
	  		ELSE
  				case when abs(Round(convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),t.Curyrate), c.decpl))> d.DocBal then
			 		d.DocBal
		     		else
					abs(Round(convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),t.Curyrate), c.decpl))
		     		end
	  		END
		ELSE
	  		case when j.curyadjgamt > d.docbal then
				d.docbal
	  		else
				j.curyadjgamt
	  		end

		END
	    END
	END, @BaseDecPl), 
	t.TranDate,
	GETDATE(), @ProgID, @Sol_User, d.PerPost, p.PrePay_RefNbr, '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
	'', '', 0, 0, '', '', '', '', t.VendId
FROM  WrkRelease w inner loop join APDoc d
	ON d.BatNbr = w.BatNbr
inner join APTran t
	ON t.BatNbr = d.BatNbr AND d.RefNbr = t.RefNbr
	Inner join AP_PPApplic p on p.AdjdRefNbr = d.RefNbr
inner join APAdjust j
	ON p.PrePay_RefNbr = j.AdjdRefNbr AND j.AdjdDocType = 'PP' AND j.curyadjdcuryid = d.curyid
inner join currncy c 
	ON c.curyid = d.curyid
WHERE w.Module = 'AP'
	AND w.UserAddress = @UserAddress
	AND t.RecordID =
		(select min(recordid) from aptran x where x.Batnbr = t.BATNBR and x.refnbr = t.refnbr and x.TranType IN ( 'VO', 'AC') )
	AND j.s4future11 <> 'V' and p.Crtd_Prog = '03010'
	IF @@ERROR < > 0 GOTO ABORT


/***** APAdjust - Prepayment Application MC with Base check*****/
INSERT APAdjust (AdjAmt, AdjBatNbr, AdjBkupWthld, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgAcct, AdjgDocDate,
	AdjgDocType, AdjgPerPost, AdjgRefNbr, AdjgSub,
        Crtd_DateTime, Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdBkupWthld, CuryAdjdCuryId, CuryAdjdDiscAmt,
	CuryAdjdMultDiv, CuryAdjdRate, CuryAdjgAmt, CuryAdjgBkupWthld, CuryAdjgDiscAmt, CuryRGOLAmt, DateAppl,
	LUpd_dateTime, LUpd_prog, LUpd_User, PerAppl, prepay_refnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,

        User1, User2, User3, User4, User5, User6, User7, User8, VendId)
SELECT
	  CASE WHEN t.CuryMultDiv = 'M' THEN
		case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.DocBal then
			  d.DocBal
		     else
			abs(Round( convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	  ELSE
	  	case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.DocBal then
			 d.DocBal
		     else
			abs(Round( convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	  END,
	j.AdjBatNbr, 0, t.TranType,
	0, t.RefNbr, j.AdjgAcct, j.AdjgDocDate,
	j.AdjgDocType, d.PerPost, j.AdjgRefNbr,  j.AdjgSub, GETDATE(), @ProgID, @Sol_User,

	case when abs(Round( convert(dec(28,3),j.AdjAmt), @BaseDecPl))> d.curyDocBal then
	  d.curyDocBal
	else
	  abs(Round( convert(dec(28,3),j.AdjAmt), @BaseDecPl))
	end,
	0, t.CuryId, 0, t.CuryMultDiv, t.CuryRate,

	  CASE WHEN d.CuryMultDiv = 'M' THEN
			case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt), @BaseDecPl))> d.curyDocBal then
			  	abs(Round(convert(dec(28,3),d.curyDocBal)*convert(dec(19,9),Coalesce(cur.Rate, d.CuryRate)), @BaseDecPl))
		     	else
				abs(Round( convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),Coalesce(cur.Rate, d.CuryRate)), @BaseDecPl))
		     	end

	  ELSE
			case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt), @BaseDecPl))> d.curyDocBal then
			  	abs(Round(convert(dec(28,3),d.curyDocBal)/convert(dec(19,9),Coalesce(cur.Rate, d.CuryRate)), @BaseDecPl))
		     	else
				abs(Round( convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),Coalesce(cur.Rate, d.CuryRate)), @BaseDecPl))
		     	end
	  END,
	0, 0,

	---rgol

	  CASE WHEN coalesce(cur.MultDiv, d.CuryMultDiv) = 'M' THEN
			case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt), @BaseDecPl))> d.curyDocBal then
			  	abs(Round(convert(dec(28,3),d.curyDocBal)*convert(dec(19,9),Coalesce(cur.Rate, d.CuryRate)), @BaseDecPl))
		     	else
				abs(Round( convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),Coalesce(cur.Rate, d.CuryRate)), @BaseDecPl))
		     	end

	  ELSE
			case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt), @BaseDecPl))> d.curyDocBal then
			  	abs(Round(convert(dec(28,3),d.curyDocBal)/convert(dec(19,9),Coalesce(cur.Rate, d.CuryRate)), @BaseDecpl))
		     	else
				abs(Round( convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),Coalesce(cur.Rate, d.CuryRate)), @BaseDecPl))
		     	end
	  END
	-  ---subtract
		  CASE WHEN t.CuryMultDiv = 'M' THEN
		case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.DocBal then
			  d.DocBal
		     else
			abs(Round( convert(dec(28,3),j.CuryAdjdAmt)*convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	  ELSE
	  	case when abs(Round( convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),t.Curyrate), @BaseDecPl))> d.DocBal then
			 d.DocBal
		     else
			abs(Round( convert(dec(28,3),j.CuryAdjdAmt)/convert(dec(19,9),t.Curyrate), @BaseDecPl))
		     end
	  END,
	t.TranDate,
	GETDATE(), @ProgID, @Sol_User, d.PerPost, p.PrePay_RefNbr, '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
	'', '', 0, 0, '', '', '', '', t.VendId
FROM WrkRelease w  inner loop join APDoc d
	ON d.BatNbr = w.BatNbr
inner join  APTran t
	ON t.BatNbr = d.BatNbr AND d.RefNbr = t.RefNbr
	Inner join AP_PPApplic p on p.AdjdRefNbr = d.RefNbr
inner join APAdjust j
	ON p.PrePay_RefNbr = j.AdjdRefNbr AND j.AdjdDocType = 'PP' AND j.curyadjdcuryid = @BaseCuryID
left join  CuryRate cur
	ON cur.FromCuryId = d.curyid
          	and cur.ToCuryId = @BaseCuryID
        	and cur.ratetype = d.curyratetype
             	and cur.EffDate =
			(select max(EffDate) from CuryRate Cury2 where
               		Cury2.FromCuryId = d.curyid
               		and Cury2.ToCuryId = @BaseCuryID
          		and Cury2.ratetype = d.curyratetype
          		and Cury2.EffDate <=  j.AdjgDocDate)
WHERE w.Module = 'AP' AND w.UserAddress = @UserAddress
	AND t.RecordID = (select min(recordid) from aptran x where x.Batnbr = t.BATNBR and x.refnbr = t.refnbr and x.TranType IN ( 'VO', 'AC') )
	AND j.s4future11 <> 'V'
	AND j.curyadjdcuryid <> d.curyid and p.Crtd_Prog = '03010'
	IF @@ERROR < > 0 GOTO ABORT

/*   If the Voucher being applied to the prepayment is only a portion of the original prepayment amount, the original
     prepayment accounts are relieved proportionally as their percent of the original total. In this process, a
     rounding error could occur. The following statement determines if rounding errors will occur and stores that amount to
     apply to the last PP offset line when subsequently generating the AP Trans.
*/


select rectoadjust=max(t.recordid),
       offset_curytranamt =
	 sum(j.curyadjdamt) - sum(round (convert (dec (28,3), j.curyadjdamt) *  convert(dec(28,3),t.curytranamt)/ convert(dec(28,3),pp.curyorigdocamt), c.decpl)),
       offset_tranamt =
	 sum(j.curyadjgamt) - sum(round (convert (dec (28,3),j.curyadjgamt)* convert(dec(28,3),t.tranamt)/convert(dec(28,3),pp.origdocamt), @BaseDecPl))
  into #temp_round_adj
  FROM WrkRelease w inner loop join APDoc d
	ON w.BatNbr = d.BatNbr
	Inner join AP_PPApplic p on p.AdjdRefNbr = d.RefNbr
  inner join APTran t
	ON t.Refnbr = p.PrePay_RefNbr AND t.TranType = 'PP' and t.DrCr = 'D'
  inner join APAdjust j
	ON d.refnbr = j.AdjdRefNbr and j.AdjdDocType = d.doctype
  inner join APDOC pp
	ON pp.refnbr = t.refnbr and pp.doctype = t.trantype
  inner join currncy c
        ON c.curyid = d.curyid
 WHERE w.Module = 'AP' AND
        w.UserAddress = @UserAddress AND d.DocType IN ('AC', 'VO') ---AC,AD allowed?
	  AND Exists( Select * from AP_PPApplic p where p.AdjdRefNbr = d.RefNbr)
	  AND j.s4future11 <> 'V'
	  AND exists(select j2.adjbatnbr from apadjust j2 where j2.adjbatnbr = j.adjbatnbr AND
			j2.adjgrefnbr = j.adjgrefnbr AND j2.adjddoctype = 'PP' AND
			j2.adjdrefnbr = p.prepay_refnbr And j2.s4future11 <> 'V') and p.Crtd_Prog = '03010'
 Group By j.AdjdRefNbr, j.AdjdDocType

/*** Insert APTran Pre-payment Offset ***/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, Component, CostType, CostTypeWO, CpnyId,
        Crtd_DateTime, Crtd_Prog, Crtd_User, CuryId, CuryMultDiv, CuryRate,
        CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
        CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
        EmployeeID, Excpt, ExtRefNbr, FiscYr, InstallNbr, InvcTypeId,
        JobRate, JrnlType, Labor_Class_Cd, LineId, LineNbr,
        LineRef, LineType, LUpd_dateTime, LUpd_Prog, LUpd_User, MasterDocNbr,
        NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, PmtMethod, POLineRef,
        ProjectID, Qty, Rcptnbr, RefNbr,        Rlsed,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
        TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
        TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
        UnitPrice, User1, User2, User3, User4, User5, User6, User7, User8, VendId,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT t.Acct , 1, p.PrePay_RefNbr, d.BatNbr, '', '', '', '', t.CpnyId, GETDATE(), @ProgID, @Sol_User,
	d.CuryId, d.CuryMultDiv,
        d.CuryRate, 0, 0, 0, 0,
	round (convert (dec (28,3), j.curyadjdamt) *  convert(dec(28,3),t.curytranamt)/ convert(dec(28,3),pp.curyorigdocamt), c.decpl)
                 + IsNull(z.Offset_curytranamt,0) + ROUND(Convert(dec(28,3), pp.CuryBWAmt), c.decpl),

	0, 0, 0, 0, 0,
        'C', '',
        '', 0, d.InvcNbr, SUBSTRING(d.PerPost, 1, 4), 0, '',
        0, 'AP', '', 0, 32767, '', '', GETDATE(), @ProgID, @Sol_User, d.MasterDocNbr,
        0, '', '',

        Case
                When t.PC_Status <> '' then '1'
                Else ''
                End,

        d.PerEnt, d.PerPost, '', '', t.ProjectID, 0, '', d.RefNbr, 0, '', '', 0, 0, 0, 0,
        '', '', 0, 0,

        Case d.s4Future11
                When 'VM' Then d.s4Future11
                        Else ''
                End,
        Case d.s4Future11
                When 'VM' Then d.s4future12
                Else ''
                End,

         '', t.Sub , t.TaskID, 0, 0, 0, 0, '', '', '', '', '', '', '',
	round (convert (dec (28,3),j.curyadjgamt)* convert(dec(28,3),t.tranamt)/convert(dec(28,3),pp.origdocamt), @BaseDecPl)
                 + IsNull(z.Offset_tranamt,0) + ROUND(Convert(dec(28,3), pp.BWAmt), c.decpl),

	'', d.DocDate,
        t.TranDesc, t.TranType, 0, 0, 0, 0, '',
        0, '', '', 0, 0, '', '', '', '', d.VendId,
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w inner loop join APDoc d
	ON w.BatNbr = d.BatNbr
	Inner join AP_PPApplic p on p.AdjdRefNbr = d.RefNbr
inner join APTran t
	ON t.Refnbr = p.PrePay_RefNbr AND t.TranType = 'PP' and t.DrCr = 'D'
inner join APAdjust j
	ON d.refnbr = j.AdjdRefNbr and j.AdjdDocType = d.doctype
inner join APDOC pp
	ON pp.refnbr = t.refnbr and pp.doctype = t.trantype
inner join currncy c
        ON c.curyid = d.curyid
 Left Join #temp_round_adj z
        ON t.Recordid = z.RecToAdjust
WHERE w.Module = 'AP' AND
        w.UserAddress = @UserAddress AND d.DocType IN ('AC', 'VO') ---AC,AD allowed?
	  AND Exists( Select * from AP_PPApplic p where p.AdjdRefNbr = d.RefNbr)
	  AND j.s4future11 <> 'V'
	  AND exists(select j2.adjbatnbr from apadjust j2 where j2.adjbatnbr = j.adjbatnbr AND
			j2.adjgrefnbr = j.adjgrefnbr AND j2.adjddoctype = 'PP' AND
			j2.adjdrefnbr = p.prepay_refnbr And j2.s4future11 <> 'V')
			and p.Crtd_Prog = '03010'
-- Create a temp table to get the sum of adjustment amounts when there are multiple adjust records to a single doc
-- For Multiple Pre-Payments
			select

       CuryDocBal = sum(j.curyadjdamt),
       CuryDiscBal = sum(j.curyadjdDiscAmt),
	 DocBal = sum(j.adjamt),
	 DiscBal = SUM(j.AdjDiscAmt),
	 BkupWthld = SUM(j.AdjBkupWthld),
	 CuryBkupWthld = SUM(j.curyadjdbkupwthld)
  into #temp_Sum_Adj
From WrkRelease w inner loop join APDoc d
	ON d.BatNbr = w.BatNbr
inner join APAdjust j
	ON d.refnbr = j.AdjdRefNbr AND d.doctype = j.adjddoctype
WHERE Exists( Select * from AP_PPApplic p where p.AdjdRefNbr = d.RefNbr and p.Crtd_Prog = '03010') AND
	 w.Module = 'AP'  AND
	d.doctype in ('VO', 'AC') 

			
/*** update this VO/AC apdoc to adjust for pre-payment applied ***/
UPDATE d SET
	
	
	d.CuryDocBal = CONVERT(DEC(28,3),d.CuryDocBal) - CASE WHEN ts.curydocbal > d.CuryDocBal
						THEN  CONVERT(DEC(28,3),d.CuryDocBal) + CONVERT(DEC(28,3),d.CuryBWAmt)
						ELSE CONVERT(DEC(28,3),ts.curydocbal) + CONVERT(DEC(28,3),ts.CuryBkupWthld) END,

	d.CuryDiscBal = CONVERT(DEC(28,3),d.CuryDiscBal) - CASE WHEN ts.CuryDiscBal > d.CuryDiscBal
						THEN  CONVERT(DEC(28,3),d.CuryDiscBal)
						ELSE CONVERT(DEC(28,3),ts.CuryDiscBal) END,

	d.DocBal = CONVERT(DEC(28,3),d.DocBal)  - CASE WHEN ts.docbal > d.DocBal
						THEN  (CONVERT(DEC(28,3),d.DocBal) + CONVERT(DEC(28,3),d.BWAmt))
						ELSE (CONVERT(DEC(28,3),ts.docbal) + CONVERT(DEC(28,3),ts.bkupwthld)) END,

	d.DiscBal = CONVERT(DEC(28,3),d.DiscBal)  - CASE WHEN ts.discBal > d.DiscBal
						THEN  CONVERT(DEC(28,3),d.DiscBal)
						ELSE CONVERT(DEC(28,3),ts.discbal) END,

	PerClosed = CASE WHEN d.DocBal - j.AdjAmt <= 0 THEN j.PerAppl Else PerClosed END,
	OpenDoc = CASE WHEN d.DocBal - j.AdjAmt <= 0 THEN 0 Else OpenDoc END,
	LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User
From WrkRelease w inner loop join APDoc d
	ON d.BatNbr = w.BatNbr
inner join APAdjust j
	ON d.refnbr = j.AdjdRefNbr AND d.doctype = j.adjddoctype, #temp_Sum_Adj ts
WHERE Exists( Select * from AP_PPApplic p where p.AdjdRefNbr = d.RefNbr and p.Crtd_Prog = '03010') AND
	 w.Module = 'AP'  AND
	d.doctype in ('VO', 'AC')
	

UPDATE j 
SET adjamt = 
	CASE WHEN j.AdjAmt > j2.AdjAmt 
	THEN round(convert(dec(28,3), j.AdjAmt)
		- convert(dec(28,3), j2.AdjAmt), @BaseDecPl) 
	ELSE 0 END,
curyadjdamt = 
	CASE WHEN j.CuryAdjdAmt > j2.CuryAdjdAmt 
		THEN round(convert(dec(28,3), j.CuryAdjdAmt) 
			- convert(dec(28,3), j2.CuryAdjdAmt), c.DecPl) 
	ELSE 0 END,
curyadjgamt = Round(
	CASE WHEN j.CuryAdjgAmt > j2.CuryAdjgAmt 
		THEN round(convert(dec(28,3), j.curyadjgamt) 
			- convert(dec(28,3), j2.CuryAdjgAmt),  c.DecPl) 
	ELSE 0 END, @BaseDecPl),
	adjbkupwthld = 
	CASE WHEN j.AdjBkupWthld > j2.adjbkupwthld 
	THEN round(convert(dec(28,3), j.AdjBkupWthld)
		- convert(dec(28,3), j2.AdjBkupWthld), @BaseDecPl) 
	ELSE 0 END,
CuryAdjdBkupWthld = 
	CASE WHEN j.CuryAdjdBkupWthld > j2.CuryAdjdBkupWthld 
		THEN round(convert(dec(28,3), j.CuryAdjdBkupWthld) 
			- convert(dec(28,3), j2.CuryAdjdBkupWthld), c.DecPl) 
	ELSE 0 END,
CuryAdjgBkupWthld = Round(
	CASE WHEN j.CuryAdjgBkupWthld > j2.CuryAdjgBkupWthld 
		THEN round(convert(dec(28,3), j.CuryAdjgBkupWthld) 
			- convert(dec(28,3), j2.CuryAdjgBkupWthld),  c.DecPl) 
	ELSE 0 END, @BaseDecPl),
LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User
FROM vp_PP_ApplySum j2 
	inner join APAdjust j
		ON j2.AdjdRefNbr = j.AdjdRefNbr 
			AND j.adjbatnbr = j2.adjbatnbr 
			AND j.AdjdDocType = 'PP'
	inner join currncy c
		ON c.curyid = j.CuryAdjdCuryID
WHERE j2.UserAddress = @UserAddress
	AND j.s4future11 <> 'V'

IF @@ERROR < > 0 GOTO ABORT

/*** update Pre-Payment apdoc to adjust for pre-payment applied ***/
UPDATE pp SET
/* If the current cury doc balance for the pre-payment is 0 (a check has been created), then the balance should
	remain 0 and not be adjusted for the new voucher amount.	*/
	pp.CuryDocBal = CASE WHEN d.CuryOrigDocAmt = 0 THEN
				pp.CuryDocBal
			ELSE CASE WHEN pp.CuryDocBal = 0  THEN
				pp.CuryDocBal
			     ELSE
				CuryAdjdAmt
			     END
			END,
	pp.CuryDiscBal = CuryAdjdDiscAmt,
/* If the current doc balance for the pre-payment is 0 (a check has been created), then the balance should
	remain 0 and not be adjusted for the new voucher amount. */
	pp.DocBal = CASE WHEN d.CuryOrigDocAmt = 0 THEN
			pp.DocBal
		    ELSE
			CASE WHEN pp.DocBal = 0  THEN
				pp.DocBal
			     ELSE
				AdjAmt
		    	END
		    END,
	pp.DiscBal = AdjDiscAmt,
	pp.LUpd_DateTime = GETDATE(),
	pp.LUpd_Prog = @ProgID,
	pp.LUpd_User = @Sol_User,
	pp.PerClosed = CASE WHEN AdjAmt = 0 THEN j.PerAppl ELSE pp.PerClosed END,
	pp.OpenDoc = CASE WHEN AdjAmt = 0 THEN 0 ELSE pp.OpenDoc END
From WrkRelease w inner loop join APDoc d
	ON d.BatNbr = w.BatNbr
inner join APDoc pp
Inner join AP_PPApplic p on p.AdjdRefNbr = pp.RefNbr
	ON pp.RefNbr = p.PrePay_RefNbr AND pp.DocType = 'PP'
inner join APAdjust j
	ON p.PrePay_RefNbr = j.AdjdRefNbr AND j.AdjdDocType = 'PP'
WHERE  w.Module = 'AP'
	AND w.UserAddress = @UserAddress
	AND j.s4future11 <> 'V' and p.Crtd_Prog = '03010'

/***** APAdjust - Other Documents *****/
INSERT APAdjust (AdjAmt, AdjBatNbr, AdjBkupWthld, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgAcct, AdjgDocDate,
	AdjgDocType, AdjgPerPost, AdjgRefNbr, AdjgSub,
        Crtd_DateTime, Crtd_Prog, Crtd_User, CuryAdjdAmt, CuryAdjdBkupWthld, CuryAdjdCuryId, CuryAdjdDiscAmt,
	CuryAdjdMultDiv, CuryAdjdRate, CuryAdjgAmt, CuryAdjgBkupWthld, CuryAdjgDiscAmt, CuryRGOLAmt, DateAppl,
	LUpd_dateTime, LUpd_prog, LUpd_User, PerAppl, prepay_refnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
        User1, User2, User3, User4, User5, User6, User7, User8, VendId)
SELECT CASE WHEN o.DocType = 'PP' THEN
			CASE  WHEN t.CuryID <> d.CuryID THEN
				ABS(t.TranAmt)
			ELSE
			CASE WHEN d.CuryMultDiv = 'M' THEN
				abs(Round( convert(dec(28,3),t.CuryTranAmt)*convert(dec(19,9),d.Curyrate), @BaseDecPl))
			ELSE
	  			abs(Round( convert(dec(28,3),t.CuryTranAmt)/convert(dec(19,9),d.Curyrate), @BaseDecPl))
			END
			END
		ELSE
		CASE  WHEN t.CuryID <> d.CuryID THEN
		CASE WHEN o.CuryMultDiv = 'M' THEN
			CASE WHEN t.CuryMultDiv = 'M' THEN
				CASE WHEN
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate) - Round((convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate),@BaseDecPl))> o.OrigDocAmt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate) - Round((convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
			 ELSE
				CASE WHEN
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))*convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate) - Round(convert(dec(28,3),t.Jobrate)*convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocamt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))*convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate) - Round(convert(dec(28,3),t.Jobrate)*convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
			 END
		ELSE
			CASE WHEN t.CuryMultDiv = 'M' THEN
				CASE WHEN
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate) - Round((convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate),@BaseDecPl))> o.OrigDocAmt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate) - Round((convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
			 ELSE
				CASE WHEN
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))*convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate) - Round(convert(dec(28,3),t.Jobrate)*convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocamt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))*convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate) - Round(convert(dec(28,3),t.Jobrate)*convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
			 END		END
	ELSE
	 CASE WHEN o.CuryMultDiv = 'M' THEN
		CASE WHEN
			round(ABS( (convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.CuryUnitPrice))*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),t.CuryUnitPrice)*convert(dec(19,9),o.CuryRate))),@BaseDecPl)>o.docbal
		THEN
			o.docbal
		ELSE
			round(ABS( (convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.CuryUnitPrice))*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),t.CuryUnitPrice)*convert(dec(19,9),o.CuryRate))),@BaseDecPl)
		END
 	 ELSE
		CASE WHEN
			round(ABS( (convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.CuryUnitPrice))/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),t.CuryUnitPrice)/convert(dec(19,9),o.CuryRate))),@BaseDecPl)>o.docbal
		THEN
			o.docbal
		ELSE
			round(ABS( (convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.CuryUnitPrice))/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),t.CuryUnitPrice)/convert(dec(19,9),o.CuryRate))),@BaseDecPl)
		END
	 END
	 END 
	END,
	t.BatNbr, 
	
	CASE  WHEN t.CuryID <> d.CuryID THEN
		CASE WHEN o.CuryMultDiv = 'M' THEN
		 	CASE WHEN t.CuryMultDiv = 'M' THEN
		  		abs(Round( Round((convert(dec(28,3),t.POQty)/convert(dec(19,9),t.Curyrate)),@BaseDecPl)*convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	ELSE
		  		abs(Round( Round((convert(dec(28,3),t.POQty)*convert(dec(19,9),t.Curyrate)),@BaseDecPl)*convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	END
		 ELSE
		 	CASE WHEN t.CuryMultDiv = 'M' THEN
		  		abs(Round( Round((convert(dec(28,3),t.POQty)/convert(dec(19,9),t.Curyrate)),@BaseDecPl)/convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	ELSE
		  		abs(Round( Round((convert(dec(28,3),t.POQty)*convert(dec(19,9),t.Curyrate)),@BaseDecPl)/convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	END
		 END
	ELSE
	 CASE WHEN t.CuryMultDiv = 'M' THEN
	  abs( convert(dec(28,3),t.POQty)*convert(dec(19,9),o.CuryRate))
	 ELSE
	  abs( convert(dec(28,3),t.POQty)/convert(dec(19,9),o.CuryRate))
	 END
	END, 
	
	t.CostType,
	
	CASE  WHEN t.CuryID <> d.CuryID THEN
		CASE WHEN o.CuryMultDiv = 'M' THEN
		 	CASE WHEN t.CuryMultDiv = 'M' THEN
		  		abs(Round( Round((convert(dec(28,3),t.JobRate)/convert(dec(19,9),t.Curyrate)),@BaseDecPl)*convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	ELSE
		  		abs(Round( Round((convert(dec(28,3),t.JobRate)*convert(dec(19,9),t.Curyrate)),@BaseDecPl)*convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	END
		 ELSE
		 	CASE WHEN t.CuryMultDiv = 'M' THEN
		  		abs(Round( Round((convert(dec(28,3),t.JobRate)/convert(dec(19,9),t.Curyrate)),@BaseDecPl)/convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	ELSE
		  		abs(Round( Round((convert(dec(28,3),t.JobRate)*convert(dec(19,9),t.Curyrate)),@BaseDecPl)/convert(dec(19,9),o.CuryRate), @BaseDecPl))
		 	END
		 END
	ELSE
	 CASE WHEN t.CuryMultDiv = 'M' THEN
	  abs( convert(dec(28,3),t.CuryUnitPrice)*convert(dec(19,9),o.CuryRate))
	 ELSE
	  abs( convert(dec(28,3),t.CuryUnitPrice)/convert(dec(19,9),o.CuryRate))
	 END
	END,

	t.UnitDesc, t.Acct,
	CASE d.DocType
		WHEN 'PP'
			Then o.DocDate
	Else
			d.DocDate
	END,
	t.TranType, d.PerPost, t.RefNbr, t.Sub, GETDATE(), @ProgID, @Sol_User,
	CASE  WHEN t.CuryID <> d.CuryID THEN
	 CASE WHEN t.CuryMultDiv = 'M' THEN
  	  CASE WHEN abs(Round( convert(dec(28,3),t.TranAmt)/convert(dec(19,9),t.Curyrate), c.DecPl))> o.CuryDocBal
		THEN o.CuryDocBal
	  ELSE
		abs(Round( convert(dec(28,3),t.TranAmt)/convert(dec(19,9),t.Curyrate), c.DecPl))
	  END
	 ELSE
	  CASE WHEN abs(Round( convert(dec(28,3),t.TranAmt)*convert(dec(19,9),t.Curyrate), c.DecPl))> o.CuryDocBal
		THEN o.CuryDocBal
	  ELSE
		abs(Round( convert(dec(28,3),t.TranAmt)*convert(dec(19,9),t.Curyrate), c.DecPl))
	  END
	 END
	ELSE
	 abs(t.CuryTranAmt)
	END,
	CASE  WHEN t.CuryID <> d.CuryID THEN
	 CASE WHEN t.CuryMultDiv = 'M' THEN
	  abs(Round( convert(dec(28,3),t.POQty)/convert(dec(19,9),o.Curyrate),c.DecPl))
	 ELSE
	  abs(Round( convert(dec(28,3),t.POQty)*convert(dec(19,9),o.Curyrate),c.DecPl))
	 END
	ELSE
	CASE WHEN t.CuryMultDiv = 'M' THEN
	  abs( convert(dec(28,3),t.POUnitPrice)/convert(dec(19,9),o.CuryRate))
	 ELSE
	  abs( convert(dec(28,3),t.POUnitPrice)*convert(dec(19,9),o.CuryRate))
	 END
	END, 	
	
	t.CuryId,
	CASE  WHEN t.CuryID <> d.CuryID THEN
	 CASE WHEN t.CuryMultDiv = 'M' THEN
	  abs(Round( convert(dec(28,3),t.JobRate)/convert(dec(19,9),o.Curyrate),c.DecPl))
	 ELSE
	  abs(Round( convert(dec(28,3),t.JobRate)*convert(dec(19,9),o.Curyrate),c.DecPl))
	 END
	ELSE
	 abs(t.CuryUnitPrice)
	END, 
	t.CuryMultDiv,
	t.CuryRate,
	CASE  WHEN t.CuryID <> d.CuryID THEN
		abs(t.CuryTranAmt)
	ELSE
	  CASE WHEN d.CuryMultDiv = 'M' THEN
 	  	abs(Round( convert(dec(28,3),t.CuryTranAmt)*convert(dec(19,9),d.Curyrate), @BaseDecPl))
	  ELSE
	  	abs(Round( convert(dec(28,3),t.CuryTranAmt)/convert(dec(19,9),d.Curyrate), @BaseDecPl))
	  END
	END, 
	CASE  WHEN t.CuryID <> d.CuryID THEN
		abs(t.POUnitPrice)
	ELSE
	  CASE WHEN t.CuryMultDiv = 'M' THEN
	  	abs(Round( convert(dec(28,3),t.POUnitPrice)/convert(dec(19,9),o.Curyrate), @BaseDecPl))
	  ELSE
	  	abs(Round( convert(dec(28,3),t.POUnitPrice)*convert(dec(19,9),o.Curyrate), @BaseDecPl))
	  END

	END,
		CASE  WHEN t.CuryID <> d.CuryID THEN
		abs(t.CuryUnitPrice)
	ELSE
	  CASE WHEN t.CuryMultDiv = 'M' THEN
	  	abs(Round( convert(dec(28,3),t.CuryUnitPrice)*convert(dec(19,9),o.Curyrate), @BaseDecPl))
	  ELSE
	  	abs(Round( convert(dec(28,3),t.CuryUnitPrice)/convert(dec(19,9),o.Curyrate), @BaseDecPl))
	  END

	END,
		---RGOL next
	(CASE WHEN o.DocType = 'PP' THEN 0 ELSE
	CASE WHEN d.CuryID <> o.CuryID THEN
		CASE WHEN o.CuryID = @BaseCuryID THEN
		0
		WHEN d.CuryID = @BaseCuryID THEN
			abs(t.CuryTranAmt)
			-
	 		CASE WHEN t.CuryMultDiv = 'M' THEN
	 		  CASE WHEN o.CuryMultDiv = 'M' THEN
				CASE WHEN
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate) - Round((convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate),@BaseDecPl))> o.OrigDocAmt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate) - Round((convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
			  ELSE
				CASE WHEN
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate) - Round((convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate),@BaseDecPl))> o.OrigDocAmt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate) - Round((convert(dec(28,3),t.Jobrate))/convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
		  	  END
	 		ELSE --- t.CuryMultDiv = 'D'
	 		  CASE WHEN o.CuryMultDiv = 'D' THEN
				CASE WHEN
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))*convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate) - Round(convert(dec(28,3),t.Jobrate)*convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocamt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))*convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate) - Round(convert(dec(28,3),t.Jobrate)*convert(dec(19,9),t.CuryRate),c.DecPl)/convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
			  ELSE
				CASE WHEN
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))*convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate) - Round(convert(dec(28,3),t.Jobrate)*convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate),@BaseDecPl))>o.OrigDocamt
				THEN
					o.OrigDocAmt
				ELSE
					ABS(Round( Round((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.Jobrate))*convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate) - Round(convert(dec(28,3),t.Jobrate)*convert(dec(19,9),t.CuryRate),c.DecPl)*convert(dec(19,9),o.CuryRate),@BaseDecPl))
				END
			  END
	 		END

		ELSE
			CASE WHEN t.CuryMultDiv = 'M' THEN
				CASE WHEN o.CuryMultDiv = 'M' THEN
			  		round(convert(dec(28,3),t.TranAmt)-ABS((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.jobrate))/convert(dec(19,9),t.CuryRate)*convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),t.jobrate))/convert(dec(19,9),t.CuryRate)*convert(dec(19,9),o.CuryRate)),@BaseDecPl)
				ELSE
			  		round(convert(dec(28,3),t.TranAmt)-ABS((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.jobrate))/convert(dec(19,9),t.CuryRate)/convert(dec(19,9),o.CuryRate) - (convert(dec(28,3),t.jobrate))/convert(dec(19,9),t.CuryRate)/convert(dec(19,9),o.CuryRate)),@BaseDecPl)
				END
			ELSE --- t.CuryMultDiv = 'D'
				CASE WHEN o.CuryMultDiv = 'D' THEN
		  	  		round(convert(dec(28,3),t.TranAmt)-ABS((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.jobrate))*convert(dec(19,9),t.CuryRate)/convert(dec(19,9),o.CuryRate) - convert(dec(28,3),t.jobrate)*convert(dec(19,9),t.CuryRate)/convert(dec(19,9),o.CuryRate)),@BaseDecPl)
				ELSE
		  	  		round(convert(dec(28,3),t.TranAmt)-ABS((convert(dec(28,3),t.TranAmt)+convert(dec(28,3),t.jobrate))*convert(dec(19,9),t.CuryRate)*convert(dec(19,9),o.CuryRate) - convert(dec(28,3),t.jobrate)*convert(dec(19,9),t.CuryRate)*convert(dec(19,9),o.CuryRate)),@BaseDecPl)
				END
			END
		END
	ELSE
		CASE WHEN convert(dec(19,9),d.Curyrate) = convert(dec(19,9),o.Curyrate) AND d.CuryMultDiv = o.CuryMultDiv THEN
		   0
		ELSE
		   CASE WHEN d.CuryMultDiv = 'M' THEN
		   	CASE WHEN t.CuryMultDiv = 'M' THEN
		   	  Round(abs( convert(dec(28,3),t.CuryTranAmt)*convert(dec(19,9),d.Curyrate)), @BaseDecPl)+Round(abs( convert(dec(28,3),t.CuryUnitPrice)*convert(dec(19,9),t.Curyrate)), @BaseDecPl) -
				CASE WHEN
					Round((convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.curyunitprice))*convert(dec(19,9),o.CuryRate), @BaseDecPl)>o.docbal
				THEN
					o.docbal
				ELSE
					Round((convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.curyunitprice))*convert(dec(19,9),o.CuryRate), @BaseDecPl)
				END
		   	ELSE
	   		  Round(abs( convert(dec(28,3),t.CuryTranAmt)*convert(dec(19,9),d.Curyrate)), @BaseDecPl)+Round(abs( convert(dec(28,3),t.CuryUnitPrice)*convert(dec(19,9),t.Curyrate)), @BaseDecPl) -
				CASE WHEN
					Round((convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.curyunitprice))/convert(dec(19,9),o.CuryRate), @BaseDecPl)>o.docbal
				THEN
					o.docbal
				ELSE
					Round((convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.curyunitprice))/convert(dec(19,9),o.CuryRate), @BaseDecPl)
				END
			END
		    ELSE ---CASE WHEN d.CuryMultDiv = 'D' THEN
		   	CASE WHEN t.CuryMultDiv = 'D' THEN
 			   Round(abs( convert(dec(28,3),t.CuryTranAmt)/convert(dec(19,9),d.Curyrate)), @BaseDecPl)+Round(abs( convert(dec(28,3),t.CuryUnitPrice)/convert(dec(19,9),t.Curyrate)), @BaseDecPl) -
				CASE WHEN
					Round((convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.curyunitprice))/convert(dec(19,9),o.CuryRate), @BaseDecPl)>o.docbal
				THEN
					o.docbal
				ELSE
					Round((convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.curyunitprice))/convert(dec(19,9),o.CuryRate), @BaseDecPl)
				END
			ELSE
 			   Round(abs( convert(dec(28,3),t.CuryTranAmt)/convert(dec(19,9),d.Curyrate)), @BaseDecPl)+Round(abs( convert(dec(28,3),t.CuryUnitPrice)/convert(dec(19,9),t.Curyrate)), @BaseDecPl) -
				CASE WHEN
					Round((convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.curyunitprice))*convert(dec(19,9),o.CuryRate), @BaseDecPl)>o.docbal
				THEN
					o.docbal
				ELSE
					Round((convert(dec(28,3),t.CuryTranAmt)+convert(dec(28,3),t.curyunitprice))*convert(dec(19,9),o.CuryRate), @BaseDecPl)
				END
			END
		    END
		END
	END
	END),

	t.TranDate,
	GETDATE(), @ProgID, @Sol_User, d.PerPost, '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
	'', '', 0, 0, '', '', '', '', t.VendId
FROM WrkRelease w inner loop join APTran t
	ON t.BatNbr = w.BatNbr AND t.DRCR = 'S' AND (t.TranType = 'HC' or t.TranType = 'EP')
inner join APDoc d
	ON d.DocType = t.TranType AND d.RefNbr = t.RefNbr AND d.BatNbr = t.BatNbr AND
	d.Acct = t.Acct AND d.Sub = t.Sub
inner join APDoc o
	ON o.RefNbr = t.UnitDesc AND o.DocType = t.CostType
inner join currncy c
	ON c.curyid = t.curyid
WHERE w.Module = 'AP' AND w.UserAddress = @UserAddress


IF @@ERROR < > 0 GOTO ABORT

/***** update the apadjust record to adjust records with discount for rounding *****/
UPDATE APAdjust SET
	adjdiscamt =
		CASE WHEN round(convert(dec(28,3),j.AdjAmt) 
					+ convert(dec(28,3),j.AdjDiscAmt),@BaseDecPl)
				> convert(dec(28,3),d.DocBal ) 
			OR ROUND(Convert(dec(28,3),d.CuryDocBal) 
				- Convert(dec(28,3),j.CuryAdjdDiscAmt) 
				- Convert(dec(28,3),j.CuryAdjdAmt), c.DecPl) = 0
		THEN round(convert(dec(28,3),d.docbal) 
			- convert(dec(28,3),j.AdjAmt), @BaseDecPl)
		ELSE adjdiscamt 
		END,
	CuryAdjgDiscAmt = CuryAdjgDiscAmt -
		Case WHEN (ckd.CuryId = d.CuryId OR ckc.CuryId = d.CuryId) 
		THEN	
			CASE WHEN round(convert(dec(28,3),j.CuryAdjgAmt),@BaseDecPl) 
					+ round(convert(dec(28,3),j.CuryAdjgDiscAmt),@BaseDecPl)
					- round(convert(dec(28,3),j.CuryRGOLAmt),@BaseDecPl) 
				> convert(dec(28,3),d.DocBal )
				  OR ROUND(Convert(dec(28,3),d.CuryDocBal) 
				- Convert(dec(28,3),j.CuryAdjdDiscAmt) 
				- Convert(dec(28,3),j.CuryAdjdAmt), c.DecPl) = 0
			THEN round(round(convert(dec(28,3),j.CuryAdjgAmt),@BaseDecPl)
					+ Round(convert(dec(28,3),j.CuryAdjgDiscAmt),@BaseDecPl)
					- round(convert(dec(28,3),j.CuryRGOLAmt),@BaseDecPl) 
					- convert(dec(28,3),d.docbal),@BaseDecPl) 
			ELSE 0 
		END
		ELSE 0
	END,
	LUpd_DateTime = GETDATE(), LUpd_Prog = @ProgID, LUpd_User = @Sol_User
FROM APAdjust j
INNER JOIN WrkRelease w
		on j.AdjBatNbr = w.BatNbr 
			AND w.Module = 'AP' 
INNER JOIN APDoc d
		on d.RefNbr = j.AdjdRefNbr 
			AND j.AdjdDocType = d.DocType
INNER JOIN Currncy c
	on c.Curyid = j.CuryAdjdCuryId
LEFT JOIN APDoc ckd
		on ckd.refnbr = j.AdjgRefNbr 
			AND ckd.DocType = j.AdjgDocType 
			AND j.AdjgAcct = ckd.Acct 
			AND j.AdjgSub = ckd.Sub
LEFT JOIN APCheck ckc
		on ckc.CheckNbr = j.AdjgRefNbr 
			AND ckc.CheckType = j.AdjgDocType 
			AND j.AdjgAcct = ckc.Acct 
			AND j.AdjgSub = ckc.Sub
WHERE j.AdjDiscAmt <> 0 
	AND w.UserAddress = @UserAddress 

IF @@ERROR < > 0 GOTO ABORT

/***** update the apadjust record to adjust records with RGOL for rounding *****/
UPDATE APAdjust SET
	AdjAmt = 
		CASE WHEN j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl) 
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl) 
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='D' 
			AND ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='D' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
		THEN ROUND(convert(dec(28,3),d.DocBal)
			- convert(dec(28,3),j.AdjDiscAmt),@BaseDecPl) 
		ELSE AdjAmt 
		END,
	CuryAdjdAmt = 
		CASE WHEN j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='D' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='D' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
		THEN ROUND(convert(dec(28,3),d.CuryDocBal)
			- convert(dec(28,3),j.CuryAdjdDiscAmt), cd.DecPl) 
		ELSE CuryAdjdAmt 
		END,
	CuryRGOLAmt = 
		CASE WHEN j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate), cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='D' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl) 
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='D' 
			AND ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
		THEN ROUND(convert(dec(28,3),j.CuryRGOLAmt)
			- convert(dec(28,3),d.DocBal)
			+ convert(dec(28,3),j.AdjAmt)
			+ convert(dec(28,3),j.AdjDiscAmt),@BaseDecPl) 
		ELSE j.CuryRGOLAmt 
		END
FROM WrkRelease w 
	INNER JOIN APAdjust j 
		on j.AdjBatNbr = w.BatNbr 
			AND w.Module = 'AP' 
	INNER JOIN APDoc d 
		on d.RefNbr = j.AdjdRefNbr 
			AND j.AdjdDocType = d.DocType
	INNER JOIN Currncy cd 
		ON cd.CuryID = d.CuryID
	INNER JOIN APCheck c 
		on c.CheckNbr = j.AdjgRefNbr 
			AND c.CheckType = j.AdjgDocType 
			AND j.AdjgAcct = c.Acct 
			AND j.AdjgSub = c.Sub
	INNER JOIN Currncy cc 
		ON cc.CuryID=c.CuryID
WHERE w.UserAddress = @UserAddress 
	AND ROUND(j.CuryRGOLAmt,@BaseDecPl) <> 0 
	AND c.CuryID <> d.CuryID

IF @@ERROR < > 0 GOTO ABORT

/***** update the apadjust record to adjust records with RGOL for rounding *****/
UPDATE APAdjust SET
	AdjAmt = 
		CASE WHEN j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='M' 
			AND ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='D' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='D' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
		THEN ROUND(convert(dec(28,3),d.DocBal)
			- convert(dec(28,3),j.AdjDiscAmt),@BaseDecPl) 
		ELSE AdjAmt 
		END,
	CuryAdjdAmt = 
		CASE WHEN j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='D' 
			AND ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='D' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
		THEN ROUND(convert(dec(28,3),d.CuryDocBal)
			- convert(dec(28,3),j.CuryAdjdDiscAmt),cd.DecPl) 
		ELSE CuryAdjdAmt 
		END,
	CuryRGOLAmt = 
		CASE WHEN j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D'	
			AND c.CuryMultDiv='M' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					/ convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='M' 
			AND c.CuryMultDiv='D' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
			OR j.CuryAdjdMultDiv='D' 
			AND c.CuryMultDiv='D' 
			AND	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					* convert(dec(19,9),c.CuryRate),cc.DecPl)
				<= ROUND(convert(dec(28,3),j.CuryAdjgAmt)
					+ convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
		THEN ROUND(convert(dec(28,3),j.CuryRGOLAmt)
			- convert(dec(28,3),d.DocBal)
			+ convert(dec(28,3),j.AdjAmt)
			+ convert(dec(28,3),j.AdjDiscAmt),@BaseDecPl) 
		ELSE j.CuryRGOLAmt 
		END
FROM WrkRelease w 
	INNER JOIN APAdjust j 
		on j.AdjBatNbr = w.BatNbr 
			AND w.Module = 'AP' 
	INNER JOIN APDoc d 
		on d.RefNbr = j.AdjdRefNbr 
			AND j.AdjdDocType = d.DocType
	INNER JOIN Currncy cd 
		ON cd.CuryID=d.CuryID
	INNER JOIN APDoc c 
		on c.refnbr = j.AdjgRefNbr 
			AND c.DocType = CASE WHEN j.adjgdoctype = 'CK' THEN 'VC' else j.AdjgDocType END 
			AND j.AdjgAcct = c.Acct 
			AND j.AdjgSub = c.Sub
	INNER JOIN Currncy cc 
		ON cc.CuryID=c.CuryID
WHERE w.UserAddress = @UserAddress 
	AND c.CuryID <> d.CuryID 

IF @@ERROR < > 0 GOTO ABORT

-- If the converted value of the voucher's current curydocbal - sum of this batch's curyadjustments <>
--              voucher's current Base docbal - Base adjustments then adjamt and RGOL need adjusted by the difference
-- Used for Manual Checks
UPDATE APAdjust SET

	AdjAmt = CASE WHEN (j.CuryAdjdMultDiv='M'AND
	                  ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )*convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)= 0 AND
                      ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) <> 0)
	                 OR (j.CuryAdjdMultDiv='D' AND
	                  ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )/convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)= 0 AND
                      ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) <> 0)
	               THEN AdjAmt +
                             CASE WHEN j.CuryAdjdMultDiv='M'
                               THEN ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) -
                                     ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )*convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
                               ELSE
                                    ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) -
                                      ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )/convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
                              END
                   ELSE AdjAmt END,

	CuryRGOLAmt = CASE WHEN (j.CuryAdjdMultDiv='M'AND
	                  ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)= 0 AND
                      ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) <> 0)
	                 OR (j.CuryAdjdMultDiv='D' AND
	                  ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )/convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)= 0 AND
                      ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) <> 0)

	               THEN CuryRGOLAmt +
                        CASE WHEN j.CuryAdjdMultDiv='M'
                           THEN ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt ) * convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)-
                                 ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl)
                             ELSE
                                ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt ) / convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)-
                                 ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl)
                         END
                   ELSE CuryRGOLAmt END

FROM WrkRelease w
INNER JOIN APAdjust j on j.AdjBatNbr = w.BatNbr AND w.Module = 'AP'
INNER JOIN APDoc d on d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType
INNER JOIN APDoc c on c.refnbr = j.AdjgRefNbr AND c.DocType = j.AdjgDocType AND j.AdjgAcct = c.Acct AND j.AdjgSub = c.Sub
WHERE w.UserAddress = @UserAddress AND c.CuryID = d.CuryID AND d.CuryID <> @BaseCuryID

IF @@ERROR < > 0 GOTO ABORT

-- If the converted value of the voucher's current curydocbal - sum of this batch's curyadjustments <>
--              voucher's current Base docbal - Base adjustments then adjamt and RGOL need adjusted by the difference
-- Used for System Checks
UPDATE APAdjust SET
	AdjAmt =
		CASE WHEN (j.CuryAdjdMultDiv='M'
			AND ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )
				* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)= 0 
			AND ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) <> 0)
			OR (j.CuryAdjdMultDiv='D' 
			AND ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )
				/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)= 0 
			AND ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) <> 0)
		THEN AdjAmt + 
			CASE WHEN j.CuryAdjdMultDiv='M'
			THEN ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) 
				- ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )
				* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
			ELSE 
				ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) 
					- ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
            END
		ELSE AdjAmt 
		END,
	CuryRGOLAmt =	
		CASE WHEN (j.CuryAdjdMultDiv='M'
			AND ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )
				* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)= 0
			AND ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) <> 0)
			OR (j.CuryAdjdMultDiv='D' 
			AND ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt )
				/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)= 0 
			AND ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) <> 0)
		THEN CuryRGOLAmt + 
			CASE WHEN j.CuryAdjdMultDiv='M'
			THEN ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt ) 
				* convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
				- ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) 
            ELSE 
				ROUND(convert(dec(28,3),d.CuryDocBal - j.CuryAdjdAmt - CuryadjdDiscAmt ) 
					/ convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)
					- ROUND(convert(dec(28,3),d.DocBal - j.AdjAmt - AdjDiscAmt ),@BaseDecPl) 
			END                                 
		ELSE CuryRGOLAmt 
		END
FROM WrkRelease w 
	INNER JOIN APAdjust j 
		on j.AdjBatNbr = w.BatNbr 
			AND w.Module = 'AP' 
	INNER JOIN APDoc d 
		on d.RefNbr = j.AdjdRefNbr 
			AND j.AdjdDocType = d.DocType
	INNER JOIN APCheck c 
		on c.Checknbr = j.AdjgRefNbr 
			AND c.CheckType = j.AdjgDocType 
			AND j.AdjgAcct = c.Acct 
			AND j.AdjgSub = c.Sub
WHERE w.UserAddress = @UserAddress 
	AND c.CuryID = d.CuryID 
	AND d.CuryID <> @BaseCuryID

IF @@ERROR < > 0 GOTO ABORT

/***** APAdjust - Void Checks (03040) *****/
INSERT APAdjust (AdjAmt, AdjBatNbr, AdjBkupWthld, AdjdDocType, AdjDiscAmt, AdjdRefNbr, AdjgAcct, AdjgDocDate,
	AdjgDocType, AdjgPerPost, AdjgRefNbr, AdjgSub,
        Crtd_DateTime, Crtd_Prog, Crtd_User,
        CuryAdjdAmt, CuryAdjdBkupWthld, CuryAdjdCuryId, CuryAdjdDiscAmt,
	CuryAdjdMultDiv, CuryAdjdRate, CuryAdjgAmt, CuryAdjgBkupWthld, CuryAdjgDiscAmt, CuryRGOLAmt, 
	DateAppl, LUpd_DateTime, LUpd_Prog, LUpd_User,
	PerAppl, prepay_refnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
        User1, User2, User3, User4, User5, User6, User7, User8, VendId)
SELECT (a.AdjAmt) * -1, t.BatNbr, (a.AdjBkupWthld) * -1, a.AdjdDocType, (a.AdjDiscAmt) * -1, a.AdjdRefNbr, a.AdjgAcct,
	t.TrANDate, 'VC', t.PerPost, a.AdjgRefNbr, a.AdjgSub,
        GETDATE(), @ProgID, @Sol_User, (a.CuryAdjdAmt) * -1, (a.CuryAdjdBkupWthld) * -1, a.CuryAdjdCuryId,
	(a.CuryAdjdDiscAmt) * -1, a.CuryAdjdMultDiv, a.CuryAdjdRate, (a.CuryAdjgAmt * -1), (a.CuryAdjgBkupWthld * -1), (a.CuryAdjgDiscAmt * -1),
	(a.CuryRGOLAmt * -1), t.trandate, GETDATE(), @ProgID, @Sol_User, t.perpost, '', '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
        '', '', 0, 0, '', '', '', '', a.VendId
FROM WrkRelease w inner loop join  APTran t
	on t.BatNbr = w.BatNbr and t.DRCR = 'V'
inner join APAdjust a
	on t.RefNbr = a.AdjgRefNbr AND a.AdjgAcct = t.Acct AND a.AdjgSub = t.Sub
WHERE w.Module = 'AP' AND
	w.UserAddress =  @UserAddress
IF @@ERROR < > 0 GOTO ABORT

/***** update the apadjust record to adjust PrePay records for rounding *****/
UPDATE APAdjust SET
	CuryAdjdAmt = CASE WHEN j.CuryAdjdMultDiv='M' AND c.CuryMultDiv='M' AND
	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)*convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)/convert(dec(19,9),c.CuryRate),cc.DecPl)<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)+convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
	OR j.CuryAdjdMultDiv='D' AND c.CuryMultDiv='M' AND
	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)/convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)/convert(dec(19,9),c.CuryRate),cc.DecPl)<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)+convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
	OR j.CuryAdjdMultDiv='M' AND c.CuryMultDiv='D' AND
	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)*convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)*convert(dec(19,9),c.CuryRate),cc.DecPl)<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)+convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
	OR j.CuryAdjdMultDiv='D' AND c.CuryMultDiv='D' AND
	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)/convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)*convert(dec(19,9),c.CuryRate),cc.DecPl)<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)+convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
	THEN ROUND(convert(dec(28,3),d.CuryDocBal)-convert(dec(28,3),j.CuryAdjdDiscAmt),cd.DecPl) ELSE CuryAdjdAmt END
FROM WrkRelease w
INNER JOIN APAdjust j on j.AdjBatNbr = w.BatNbr AND w.Module = 'AP'
INNER JOIN APDoc d on d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType
INNER JOIN Currncy cd ON cd.CuryID=d.CuryID
INNER JOIN APCheck c on c.CheckNbr = j.AdjgRefNbr AND c.CheckType = j.AdjgDocType AND j.AdjgAcct = c.Acct AND j.AdjgSub = c.Sub
INNER JOIN Currncy cc ON cc.CuryID=c.CuryID
WHERE d.DocType = 'PP' AND w.UserAddress = @UserAddress AND c.CuryID <> d.CuryID

IF @@ERROR < > 0 GOTO ABORT

/***** update the apadjust record to adjust Pre Pay records for rounding *****/
UPDATE APAdjust SET
	CuryAdjdAmt = CASE WHEN j.CuryAdjdMultDiv='M' AND c.CuryMultDiv='M' AND
	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)*convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)/convert(dec(19,9),c.CuryRate),cc.DecPl)<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)+convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
	OR j.CuryAdjdMultDiv='D' AND c.CuryMultDiv='M' AND
	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)/convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)/convert(dec(19,9),c.CuryRate),cc.DecPl)<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)+convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
	OR j.CuryAdjdMultDiv='M' AND c.CuryMultDiv='D' AND
	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)*convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)*convert(dec(19,9),c.CuryRate),cc.DecPl)<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)+convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
	OR j.CuryAdjdMultDiv='D' AND c.CuryMultDiv='D' AND
	ROUND(ROUND(convert(dec(28,3),d.CuryDocBal)/convert(dec(19,9),j.CuryAdjdRate),@BaseDecPl)*convert(dec(19,9),c.CuryRate),cc.DecPl)<=ROUND(convert(dec(28,3),j.CuryAdjgAmt)+convert(dec(28,3),j.CuryAdjgDiscAmt),cc.DecPl)
	THEN ROUND(convert(dec(28,3),d.CuryDocBal)-convert(dec(28,3),j.CuryAdjdDiscAmt),cd.DecPl) ELSE CuryAdjdAmt END
FROM WrkRelease w
INNER JOIN APAdjust j on j.AdjBatNbr = w.BatNbr AND w.Module = 'AP'
INNER JOIN APDoc d on d.RefNbr = j.AdjdRefNbr AND j.AdjdDocType = d.DocType
INNER JOIN Currncy cd ON cd.CuryID=d.CuryID
INNER JOIN APDoc c on c.refnbr = j.AdjgRefNbr AND c.DocType = j.AdjgDocType AND j.AdjgAcct = c.Acct AND j.AdjgSub = c.Sub
INNER JOIN Currncy cc ON cc.CuryID=c.CuryID
WHERE d.DocType = 'PP' AND w.UserAddress = @UserAddress AND c.CuryID <> d.CuryID

IF @@ERROR < > 0 GOTO ABORT


/****************************************/
/***** APDoc Records - Void Checks ******/
/****************************************/

INSERT APDoc (Acct, BatNbr, BatSeq, BWAmt, ClearAmt, ClearDate, CurrentNbr, CuryBWAmt, CuryDiscBal, CuryDiscTkn, CuryDocBal,
	CuryEffDate, CuryId, CuryMultDiv, CuryOrigDocAmt, CuryPmtAmt, CuryRate, CuryRateType, CuryTaxTot00,
	CuryTaxTot01, CuryTaxTot02, CuryTaxTot03, CuryTxblTot00, CuryTxblTot01, CuryTxblTot02, CuryTxblTot03,
	Cycle, DirectDeposit, DiscBal, DiscDate, DiscTkn, Doc1099, DocBal, DocClass, DocDate, DocDesc,
	DocType, DueDate, InvcDate, InvcNbr, LineCntr, NbrCycle, NoteID, OpenDoc, OrigDocAmt, PayDate,
	PerClosed, PerEnt, PerPost, PmtAmt, PONbr, RefNbr, RGOLAmt, Rlsed, Selected, Status, Sub, SubContract, TaxCntr00,
	TaxCntr01, TaxCntr02, TaxCntr03, TaxId00, TaxId01, TaxId02, TaxId03, TaxTot00, TaxTot01, TaxTot02,
	TaxTot03, Terms, TxblTot00, TxblTot01, TxblTot02, TxblTot03, User1, User2, User3, User4, User5, User6,
	User7, User8, VendId, VendName, AddlCost, ApplyAmt, ApplyDate, ApplyRefnbr, CashAcct, CashSub, CpnyId,
        Crtd_DateTime, Crtd_Prog, Crtd_User, DfltDetail, Econfirm, Estatus, InstallNbr,
        LUpd_DateTime, LUpd_Prog, LUpd_User, MasterDocNbr, PayHoldDesc, PC_Status, PmtID, PmtMethod, Prepay_RefNbr,
	ProjectID, Retention, S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12)
SELECT d.Acct, t.BatNbr, d.BatSeq, d.BWAmt, d.ClearAmt, d.ClearDate, d.CurrentNbr, d.CuryBWAmt, d.CuryDiscBal, d.CuryDiscTkn, d.CuryDocBal,
	d.CuryEffDate, d.CuryId, d.CuryMultDiv, d.CuryOrigDocAmt, d.CuryPmtAmt, d.CuryRate, d.CuryRateType, d.CuryTaxTot00,
	d.CuryTaxTot01, d.CuryTaxTot02, d.CuryTaxTot03, d.CuryTxblTot00, d.CuryTxblTot01, d.CuryTxblTot02, d.CuryTxblTot03,
	d.Cycle, d.DirectDeposit, d.DiscBal, d.DiscDate, d.DiscTkn, d.Doc1099, d.DocBal, d.DocClass, t.TranDate, d.DocDesc,
	'VC', d.DueDate, d.InvcDate, d.InvcNbr, d.LineCntr, d.NbrCycle, d.NoteID, d.OpenDoc, d.OrigDocAmt, d.PayDate,
	t.PerPost, b.PerEnt, b.PerPost, d.PmtAmt, d.PONbr, d.RefNbr, d.RGOLAmt, 0, d.Selected, 'V', d.Sub, ' ', d.TaxCntr00,
	d.TaxCntr01, d.TaxCntr02, d.TaxCntr03, d.TaxId00, d.TaxId01, d.TaxId02, d.TaxId03, d.TaxTot00, d.TaxTot01, d.TaxTot02,
	d.TaxTot03, d.Terms, d.TxblTot00, d.TxblTot01, d.TxblTot02, d.TxblTot03, d.User1, d.User2, d.User3, d.User4, d.User5, d.User6,
	d.User7, d.User8, d.VendId, d.VendName, d.AddlCost, d.ApplyAmt, d.ApplyDate , d.ApplyRefnbr, d.CashAcct, d.CashSub, d.CpnyId,
        GETDATE(), @ProgID, @Sol_User, d.DfltDetail, d.Econfirm, d.Estatus, d.InstallNbr, GETDATE(), @ProgID, @Sol_User,
        d.MasterDocNbr, d.PayHolddesc, D.PC_Status, d.PmtID, d.PmtMethod, '', d.ProjectId, d.Retention,
        '', '', 0, 0, 0, 0, '', '', 0, 0, '', ''
FROM WrkRelease w inner loop join Batch b
	ON b.Batnbr = w.Batnbr AND b.Module = 'AP'
inner join APTran t
	ON t.BatNbr = b.BatNbr AND t.DRCR = 'V'
inner join APDoc d
	ON  t.RefNbr = d.RefNbr AND d.Acct = t.Acct AND d.Sub = t.Sub
WHERE w.Module = 'AP' AND w.UserAddress = @UserAddress AND
	d.DocType IN ('HC', 'EP', 'CK', 'ZC')

IF @@ERROR < > 0 GOTO ABORT

/****************************************/
/***** APTran Records - Void Checks *****/
/****************************************/

/***** Debit Cash ******/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,

	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, rcptnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT t.Acct, t.AcctDist, '', o.BatNbr, t.BoxNbr, t.CostType, t.CpnyId, t.CuryId, t.CuryMultDiv, t.CuryRate,
	t.CuryTaxAmt00, t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03, t.CuryTranAmt, t.CuryTxblAmt00,
	t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice, 'D', t.Employee,
	t.EmployeeID, t.Excpt, t.ExtRefNbr, o.FiscYr, t.JobRate, t.JrnlType, t.Labor_Class_Cd,
	t.LineId, o.LineNbr, t.NoteID, t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, t.PerPost, t.ProjectID, t.Qty,
	t.RefNbr, 0, t.Sub, t.TaskID, t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,
	t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03, t.TaxIdDflt, t.TranAmt, t.TranClass,
	o.TranDate, t.TranDesc, 'VC', t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03, t.UnitDesc, t.UnitPrice, t.User1, t.User2,
	t.User3, t.User4, t.VendId, '', '', GETDATE(), @ProgID, @Sol_user, t.installnbr, '', '', '',
        GETDATE(), @ProgID, @Sol_User, t.MasterDocNbr, t.PmtMethod, '', '', '', '', 0, 0, 0, 0, '', '', 0, 0,
	'', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w inner loop join APTran o
	ON o.BatNbr = w.BatNbr AND o.DRCR = 'V'
inner loop join APTran t
	ON o.RefNbr = t.RefNbr AND o.Acct = t.Acct AND o.Sub = t.Sub AND t.DrCr = 'C'
WHERE  w.Module = 'AP' AND w.UserAddress = @UserAddress
	and t.TranType in ('CK', 'HC', 'EP', 'ZC')

IF @@ERROR < > 0 GOTO ABORT

/***** Debit Discount - Void Check ******/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, rcptnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT  distinct @DiscTknAcct, t.AcctDist, '', o.BatNbr, t.BoxNbr, t.CostType,
        t.CpnyId, t.CuryId, t.CuryMultDiv, t.CuryRate,
	t.CuryTaxAmt00, t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03,
	CASE WHEN a.CuryAdjdCuryId = t.curyid THEN
		a.CuryAdjdDiscAmt * CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	ELSE
		a.CuryAdjgDiscAmt	* CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	END,
	t.CuryTxblAmt00,
	t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice, 'D', t.Employee,
	t.EmployeeID, t.Excpt, t.ExtRefNbr, o.FiscYr, t.JobRate, t.JrnlType, t.Labor_Class_Cd,
	t.LineId, o.LineNbr + 2, t.NoteID, t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, t.PerPost, t.ProjectID, t.Qty,
	t.RefNbr, 0, @DiscTknSub, t.TaskID, t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,
	t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03, t.TaxIdDflt,
	CASE WHEN a.CuryAdjdCuryId = o.curyid THEN
		a.CuryAdjgDiscAmt * CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	ELSE
	  CASE WHEN a.CuryAdjdMultDiv = 'M' THEN
		ROUND(a.CuryAdjdDiscAmt	*a.CuryAdjdRate,@BaseDecPl ) * CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	  ELSE
		ROUND(a.CuryAdjdDiscAmt	/a.CuryAdjdRate,@BaseDecPl ) * CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	  END
	END,
		t.TranClass,
	o.TrANDate, t.TrANDesc, 'VC', t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03, t.UnitDesc, t.UnitPrice, t.User1, t.User2,
	t.User3, t.User4, t.VendId, '', '', GETDATE(), @ProgID, @Sol_user, t.InstallNbr, '', '', '', GETDATE(),
	@ProgID, @Sol_user, t.MasterDocNbr, t.PmtMethod, '', '', a.adjdrefnbr, '', 0, 0, 0, 0, '', '', 0, 0,
	'', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w inner loop join APTran o
	ON o.BatNbr = w.BatNbr AND o.DRCR = 'V'
inner join APTran t
	ON o.RefNbr = t.RefNbr AND o.Acct = t.Acct AND o.Sub = t.Sub AND t.DrCr = 'C'
inner join APAdjust a
	ON a.AdjgAcct = o.Acct AND a.AdjgSub = o.Sub  AND
	a.AdjgRefnbr = o.RefNbr AND a.AdjgDocType = o.TranType
WHERE w.Module = 'AP' AND w.UserAddress = @UserAddress AND
	 a.AdjDiscAmt > 0 and t.TranType in ('CK', 'HC', 'EP', 'ZC')

IF @@ERROR < > 0 GOTO ABORT

/***** Debit Backup Withholding - Void Check ******/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, rcptnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT  distinct @BkupWthldAcct, t.AcctDist, '', o.BatNbr, t.BoxNbr, t.CostType,
        t.CpnyId, t.CuryId, t.CuryMultDiv, t.CuryRate,
	t.CuryTaxAmt00, t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03,
	CASE WHEN a.CuryAdjdCuryId = t.curyid THEN
		a.CuryAdjdBkupWthld * CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	ELSE
		a.CuryAdjgBkupWthld	* CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	END,
	t.CuryTxblAmt00,
	t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice, 'D', t.Employee,
	t.EmployeeID, t.Excpt, t.ExtRefNbr, o.FiscYr, t.JobRate, t.JrnlType, t.Labor_Class_Cd,
	t.LineId, o.LineNbr + 2, t.NoteID, t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, t.PerPost, t.ProjectID, t.Qty,
	t.RefNbr, 0, @BkupWthldSub, t.TaskID, t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,
	t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03, t.TaxIdDflt,
	CASE WHEN a.CuryAdjdCuryId = o.curyid THEN
		a.CuryAdjgBkupWthld * CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	ELSE
	  CASE WHEN a.CuryAdjdMultDiv = 'M' THEN
		ROUND(a.CuryAdjdBkupWthld	*a.CuryAdjdRate,@BaseDecPl ) * CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	  ELSE
		ROUND(a.CuryAdjdBkupWthld	/a.CuryAdjdRate,@BaseDecPl ) * CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	  END
	END,
		t.TranClass,
	o.TrANDate, t.TrANDesc, 'VC', t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03, t.UnitDesc, t.UnitPrice, t.User1, t.User2,
	t.User3, t.User4, t.VendId, '', '', GETDATE(), @ProgID, @Sol_user, t.InstallNbr, '', '', '', GETDATE(),
	@ProgID, @Sol_user, t.MasterDocNbr, t.PmtMethod, '', '', a.adjdrefnbr, '', 0, 0, 0, 0, '', '', 0, 0,
	'', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w inner loop join APTran o
	ON o.BatNbr = w.BatNbr AND o.DRCR = 'V'
inner join APTran t
	ON o.RefNbr = t.RefNbr AND o.Acct = t.Acct AND o.Sub = t.Sub AND t.DrCr = 'C'
inner join APAdjust a
	ON a.AdjgAcct = o.Acct AND a.AdjgSub = o.Sub  AND
	a.AdjgRefnbr = o.RefNbr AND a.AdjgDocType = o.TranType
WHERE w.Module = 'AP' AND w.UserAddress = @UserAddress AND
	 a.AdjBkupWthld > 0 and t.TranType in ('CK', 'HC', 'EP', 'ZC')

IF @@ERROR < > 0 GOTO ABORT

/***** Credit AP - Void Check ******/
INSERT  APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,
	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TranDate, TranDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, rcptnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT  DISTINCT d.Acct, t.AcctDist, '', o.BatNbr, t.BoxNbr, t.CostType,
	d.CpnyId, t.CuryId, t.CuryMultDiv, t.CuryRate,
	t.CuryTaxAmt00, t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03,
	CASE WHEN a.CuryAdjdCuryId = t.curyid  THEN
		 (a.curyAdjdAmt+a.curyAdjdDiscAmt+a.CuryAdjdBkupWthld)* CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	ELSE
	    -- If the cury and the non-cury amount are different with different curyID, then
            -- Use the adjustment amount to calculate curytran amt.
	    case when a.curyAdjdAmt <> a.CuryAdjgAmt then

	  	 (a.CuryAdjgAmt+a.CuryAdjgDiscAmt+a.CuryAdjdBkupWthld)* CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END
	    else
		-- If the both the adjusting and adjusted amounts are 0 then this is a PrePayment line and
                -- the calculation will set the amount to 0.
	        case when a.curyAdjdAmt <> 0 and a.CuryAdjgAmt <> 0 and t.CuryRate <> 1 then
			-- otherwise need to use the check tran cury amount because it is a base prepaymnent
			-- paid with a currency check, set the cury adjustment amounts to base.
			-- and the currency amount is needed here.
			t.curytranamt
		else
			(a.CuryAdjgAmt+a.CuryAdjgDiscAmt+a.CuryAdjdBkupWthld)* CASE WHEN a.AdjdDocType = 'AD' then -1 ELSE 1 END

		end
	    end
	END,
	t.CuryTxblAmt00,
	t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice, 'C', t.Employee,
	t.EmployeeID, t.Excpt, d.RefNbr, o.FiscYr, t.JobRate, t.JrnlType, t.Labor_Class_Cd,
	t.LineId, o.LineNbr + 4, t.NoteID, t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, t.PerPost, t.ProjectID, t.Qty,
	t.RefNbr, 0, d.Sub, t.TaskID, t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,
	t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03, t.TaxIdDflt, (a.AdjAmt+a.AdjDiscAmt+a.AdjBkupWthld)* CASE WHEN a.AdjdDocType = 'AD' THEN -1 ELSE 1 END, t.TranClass,
	o.TranDate, t.TranDesc, 'VC', t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03, t.UnitDesc, t.UnitPrice, t.User1, t.User2,
	t.User3, t.User4, t.VendId, '', '', GETDATE(), @ProgID, @Sol_user, d.installnbr, '', '', '', GETDATE(),
	@ProgID, @Sol_user, d.MasterDocNbr, d.PmtMethod, '', '', '', '', 0, 0, 0, 0, '', '', 0, 0,
	'', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w inner loop join APTran o
	ON o.BatNbr = w.BatNbr AND o.DrCr = 'V'
inner join APTran t
	ON o.RefNbr = t.RefNbr AND o.Acct = t.Acct AND o.Sub = t.Sub AND t.DrCr = 'C'
inner join APAdjust a
	ON a.AdjgAcct = o.Acct AND a.AdjgSub = o.Sub and a.AdjgRefnbr = o.RefNbr
	AND a.AdjgDocType = o.TranType
inner join APDoc d
	ON d.RefNbr = a.AdjdRefNbr AND d.DocType = a.AdjdDocType
WHERE w.Module = 'AP' AND w.UserAddress = @UserAddress AND
	 t.TranType in ('CK', 'HC', 'EP', 'ZC')


IF @@ERROR < > 0 GOTO ABORT

/***** Adjust AP RGOL - Void Check ******/
INSERT APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,

	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, rcptnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT t.Acct, t.AcctDist, '', o.BatNbr, t.BoxNbr, t.CostType, t.CpnyId, t.CuryId, t.CuryMultDiv, t.CuryRate,
	t.CuryTaxAmt00, t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03, t.CuryTranAmt, t.CuryTxblAmt00,
	t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice, CASE WHEN t.TranType = 'RG' then 'D' ELSE 'C' END, t.Employee,
	t.EmployeeID, t.Excpt, t.ExtRefNbr, o.FiscYr, t.JobRate, t.JrnlType, t.Labor_Class_Cd,
	t.LineId, o.LineNbr, t.NoteID, t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, t.PerPost, t.ProjectID, t.Qty,
	t.RefNbr, 0, t.Sub, t.TaskID, t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,
	t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03, t.TaxIdDflt, t.TranAmt, t.TranClass,
	o.TranDate, t.TranDesc, CASE WHEN t.TranType = 'RG' then 'RG' ELSE 'RL' END, t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03, t.UnitDesc, t.UnitPrice, t.User1, t.User2,
	t.User3, t.User4, t.VendId, '', '', GETDATE(), @ProgID, @Sol_user, t.installnbr, '', '', '',
        GETDATE(), @ProgID, @Sol_User, t.MasterDocNbr, t.PmtMethod, '', '', '', '', 0, 0, 0, 0, '', '', 0, 0,
	'', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM  WrkRelease w inner loop join APTran o
	ON o.BatNbr = w.BatNbr AND o.DRCR = 'V'
inner join APDoc c
	ON c.refnbr = o.refnbr AND c.Acct = o.Acct AND c.Sub = o.Sub
inner join APTran t
	ON t.RefNbr = c.RefNbr AND t.batnbr = c.batnbr AND t.TranType in ('RG', 'RL')
WHERE  w.Module = 'AP' AND w.UserAddress = @UserAddress

IF @@ERROR < > 0 GOTO ABORT

--- There can be cases where the RGOL was created with the voucher instead of the check
--- This is when RGOL is generated when a pre-payment is applied to a voucher
/***** Adjust AP RGOL - Void Check ******/
INSERT  APTran (Acct, AcctDist, Applied_PPrefNbr, BatNbr, BoxNbr, CostType, CpnyId, CuryId, CuryMultDiv, CuryRate,
	CuryTaxAmt00, CuryTaxAmt01, CuryTaxAmt02, CuryTaxAmt03, CuryTranAmt, CuryTxblAmt00,

	CuryTxblAmt01, CuryTxblAmt02, CuryTxblAmt03, CuryUnitPrice, DrCr, Employee,
	EmployeeID, Excpt, ExtRefNbr, FiscYr, JobRate, JrnlType, Labor_Class_Cd, LineId,
	LineNbr, NoteID, PC_Flag, PC_ID, PC_Status, PerEnt, PerPost, ProjectID, Qty, RefNbr,
	Rlsed, Sub, TaskID, TaxAmt00, TaxAmt01, TaxAmt02, TaxAmt03, TaxCalced,
	TaxCat, TaxId00, TaxId01, TaxId02, TaxId03, TaxIdDflt, TranAmt, TranClass,
	TrANDate, TrANDesc, TranType, TxblAmt00, TxblAmt01, TxblAmt02, TxblAmt03, UnitDesc,
	UnitPrice, User1, User2, User3, User4, VendId,
        Component, CostTypeWo, Crtd_DateTime, Crtd_Prog, Crtd_User, installNbr, InvcTypeID,
        Lineref, LineType, LUpd_dateTime, LUpd_prog, LUpd_User, MasterDocNbr,
        PmtMethod, POLineRef, rcptnbr,
        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
        S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, ServiceDate,
        User5, User6, User7, User8,
	AlternateID, BOMLineRef, CuryPOExtPrice, CuryPOUnitPrice, CuryPPV, InvtID, POExtPrice,
	PONbr, POQty, POUnitPrice, PPV, QtyVar, RcptLineRef, RcptQty,
	SiteId, SoLineRef, SOOrdNbr, SOTypeID, WONbr, WOStepNbr)

SELECT distinct t.Acct, t.AcctDist, '', o.BatNbr, t.BoxNbr, t.CostType, t.CpnyId, t.CuryId, t.CuryMultDiv, t.CuryRate,
	t.CuryTaxAmt00, t.CuryTaxAmt01, t.CuryTaxAmt02, t.CuryTaxAmt03, t.CuryTranAmt, t.CuryTxblAmt00,
	t.CuryTxblAmt01, t.CuryTxblAmt02, t.CuryTxblAmt03, t.CuryUnitPrice, CASE WHEN t.TranType = 'RG' then 'D' ELSE 'C' END, t.Employee,
	t.EmployeeID, t.Excpt, t.ExtRefNbr, o.FiscYr, t.JobRate, t.JrnlType, t.Labor_Class_Cd,
	t.LineId, o.LineNbr, t.NoteID, t.PC_Flag, t.PC_ID, t.PC_Status, t.PerEnt, t.PerPost, t.ProjectID, t.Qty,
	o.RefNbr, 0, t.Sub, t.TaskID, t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxCalced,
	t.TaxCat, t.TaxId00, t.TaxId01, t.TaxId02, t.TaxId03, t.TaxIdDflt, t.TranAmt, t.TranClass,
	o.TranDate, t.TranDesc, CASE WHEN t.TranType = 'RG' then 'RG' ELSE 'RL' END, t.TxblAmt00, t.TxblAmt01, t.TxblAmt02, t.TxblAmt03, t.UnitDesc, t.UnitPrice, t.User1, t.User2,
	t.User3, t.User4, t.VendId, '', '', GETDATE(), @ProgID, @Sol_user, t.installnbr, '', '', '',
        GETDATE(), @ProgID, @Sol_User, t.MasterDocNbr, t.PmtMethod, '', '', '', '', 0, 0, 0, 0, '', '', 0, 0,
	'', '', '', '', '', '', '',
	'','',0,0,0,'',0,'',0,0,0,0,'',0,'','','','','',''
FROM WrkRelease w inner loop join  APTran o
	on o.BatNbr = w.BatNbr AND o.DRCR = 'V'
inner join APDoc c
	ON c.refnbr = o.refnbr AND c.Acct = o.Acct AND c.Sub = o.Sub
inner join Apadjust j
	ON j.adjbatnbr = o.batnbr
	and j.adjgrefnbr = o.refnbr
	and j.adjgacct = o.acct
	and j.adjgsub = o.sub
	and j.adjgdoctype = 'VC'
inner join APTran t
	ON t.vendid = j.vendid AND t.RefNbr = j.AdjdRefNbr
WHERE   w.Module = 'AP' AND w.UserAddress = @UserAddress
	and j.s4future11 <> 'V'
	AND t.TranType in ('RG', 'RL')
	and j.adjddoctype in ('VO', 'AC')
	and exists
	(select j2.adjbatnbr from apadjust j2 where j2.adjddoctype = 'PP' and
	j2.adjgrefnbr = j.adjgrefnbr and j2.adjgdoctype = j.adjgdoctype and
	j2.adjgacct = j.adjgacct and j2.adjgsub = j.adjgsub)
	IF @@ERROR < > 0 GOTO ABORT

---mark voided apadjust records so they can be identified (especially when a pre-pay check is voided)
UPDATE APAdjust
	Set s4future11 = 'V'
FROM APAdjust a, APTran t, WrkRelease w
WHERE t.DRCR = 'V' AND t.RefNbr = a.AdjgRefNbr AND t.BatNbr = w.BatNbr AND w.Module = 'AP' AND
	w.UserAddress = @UserAddress AND a.AdjgAcct = t.Acct AND a.AdjgSub = t.Sub
IF @@ERROR < > 0 GOTO ABORT

SELECT @Result = 1
GOTO FINISH

ABORT:
SELECT @Result = 0

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_03400adj] TO [MSDSL]
    AS [dbo];

