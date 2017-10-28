


-- ---------------------------------------------------
-- Created 2/5/2016 by John Maas/Brian Diehl
-- Purpose: Use this view as a audit mechanism to ensure SBF pigs are credited and paid for properly.
-- ---------------------------------------------------

CREATE View [dbo].[cfvPIGSALE_AR_DETAIL]
AS
select 
       ar.BatNbr
      ,ar.RefNbr
      ,ar.DrCr
      ,ar.TranType
      ,case when ar.DrCr='D' then ar.TranAmt else ar.TranAmt*(-1) end as AR_TranAmt
      ,case when r2.OrigRefNbr=ar.RefNbr then 'Orig'
             when ps.DocType = 'RE' then 'Rev'
              else '' 
       end Reversal
      ,case when r2.OrigRefNbr=ar.RefNbr then r2.BatNbr
                  when ps.DocType = 'RE' then r3.BatNbr
              else '' 
       end RelatedBatNbr
      ,case when r2.OrigRefNbr=ar.RefNbr then r2.RefNbr
              when ps.DocType = 'RE' then ps.OrigRefNbr
              else '' 
       end RelatedRefNbr
      --CASE statements are used to change the sign on Headcounts,Weights and dollars on the Reversal (DocType='RE') rows.       
      ,case when ps.DocType='SR' then ps.AmtCheck
              when ps.DocType='RE' then ps.AmtCheck * (-1)
              else ps.AmtCheck 
       end as PS_AmtCheck
      ,ps.DocType
      --This is where we make the CFF/SBF determination based on if the SalesOrder starts with the 'SBF' naming convention.      
      ,case when o.Descr like 'SBF%' then 'SBF'
              else 'CFF' 
       end as 'Entity_SalesOrd'
      --This is where we make the CFF/SBF determination based on if the Site is in the cftSBFSiteLookup table and within the effective date.
      ,case when sbf.ContactID is null then 'CFF' else 'SBF' end as 'Entity_Site'    
      ,ar.LUpd_DateTime AR_Date
      ,pm.MovementDate PM_Date
      ,ps.SaleDate as PS_SaleDate
      ,ps.KillDate as PS_KillDate
      ,cp.ContactName as Packer
      ,ps.SiteContactID
      ,s.ContactName Site
      ,ps.BarnNbr
      ,pm.PMLoadID,ps.TaskID
      --,ps.HeadCount
        ,case when ps.DocType='SR' then ps.HeadCount
                  when ps.DocType='RE' then ps.HeadCount * (-1)
                  else ps.HeadCount 
                  end as HeadCount
      --,ps.HCTot
        ,case when ps.DocType='SR' then ps.HCTot
                  when ps.DocType='RE' then ps.HCTot * (-1)
                  else ps.HCTot 
                  end as HCTot           
      ,rtrim(mst.Description) AS 'LoadType'
      ,ps.SaleBasis
      ,ps.SaleTypeID
      ,ps.AvgWgt

        ,case when ps.DocType='SR' then ps.DelvLiveWgt
                  when ps.DocType='RE' then ps.DelvLiveWgt * (-1)
                  else ps.DelvLiveWgt 
                  end as DelvLiveWgt      
        ,case when ps.DocType='SR' then ps.DelvCarcWgt
                  when ps.DocType='RE' then ps.DelvCarcWgt * (-1)
                  else ps.DelvCarcWgt 
                  end as DelvCarcWgt      
      ,ps.BasePrice
       ,case when ps.DocType='SR' then ps.AmtBaseSale
                  when ps.DocType='RE' then ps.AmtBaseSale * (-1)
                  else ps.AmtBaseSale 
                  end as AmtBaseSale      
        ,case when ps.DocType='SR' then ps.AmtSortLoss * (-1)  --Flip sign for presentation purposes
                  when ps.DocType='RE' then ps.AmtSortLoss
                  else ps.AmtSortLoss * (-1)
                  end as AmtSortLoss      
        ,case when ps.DocType='SR' then ps.AmtGradePrem
                  when ps.DocType='RE' then ps.AmtGradePrem * (-1)
                  else ps.AmtGradePrem 
                  end as AmtGradePrem       
        ,case when ps.DocType='SR' then ps.AmtNPPC * (-1)  --Flip sign for presentation purposes
                  when ps.DocType='RE' then ps.AmtNPPC
                  else ps.AmtNPPC * (-1)
                  end as AmtNPPC       
        ,case when ps.DocType='SR' then ps.AmtTruck * (-1)  --Flip sign for presentation purposes
                  when ps.DocType='RE' then ps.AmtTruck
                  else ps.AmtTruck * (-1)
                  end as AmtTruck       
        ,case when ps.DocType='SR' then ps.AmtScale * (-1)  --Flip sign for presentation purposes
                  when ps.DocType='RE' then ps.AmtScale
                  else ps.AmtScale * (-1)
                  end as AmtScale      
        ,case when ps.DocType='SR' then ps.AmtOther * (-1)  --Flip sign for presentation purposes
                  when ps.DocType='RE' then ps.AmtOther
                  else ps.AmtOther * (-1)
                  end as AmtOther      
      ,ps.TattooNbr
      ,rtrim(t.ShortName) AS 'Trucker'
      ,o.Descr as SaleOrdDescr
      ,ps.Project
       ,case when ps.DocType='SR' then isnull(deads.DT,0)
                  when ps.DocType='RE' then isnull(deads.DT,0) * (-1)  --Flip sign for presentation purposes
                  else isnull(deads.DT,0) 
                  end as 'DOT'        
        ,case when ps.DocType='SR' then isnull(deads.DY,0)
                  when ps.DocType='RE' then isnull(deads.DY,0) * (-1)  --Flip sign for presentation purposes
                  else isnull(deads.DY,0) 
                  end as 'DIY'      
        ,case when ps.DocType='SR' then isnull(deads.CD,0)
                  when ps.DocType='RE' then isnull(deads.CD,0) * (-1)  --Flip sign for presentation purposes
                  else isnull(deads.CD,0) 
                  end as 'CON'      
    from cftPigSale ps
      INNER join ARTran ar on ar.BatNbr=ps.ARBatNbr and ar.RefNbr=ps.ARRefNbr and ar.Acct='10300' and ar.LUpd_DateTime >= '2016/01/17' and ar.TranType in ('IN','CM') and ar.Rlsed='1'
      --We join to the cftPigSale to so that we can see the original entries that were reversed out.
      LEFT JOIN cftPigSale AS r2 ON ps.RefNbr=r2.OrigRefNbr
      --We join to the cftPigSale again so that we can see the Related BatNbr on the Reversal entries.
      LEFT JOIN cftPigSale AS r3 ON ps.OrigRefNbr=r3.RefNbr      
            left join cftPM pm on pm.PMID=ps.PMLoadId
      left join cftContact s on s.ContactID=ps.SiteContactID
      --This joins to the cftSBFSiteLookup table to specifically tag those rows where they are SBF sites AND the Movement date was within the effective date.
      left join CentralData.dbo.cftSBFSiteLookup sbf on sbf.ContactID=ps.SiteContactID
              and (pm.MovementDate between sbf.EffectiveDate and (ISNULL(sbf.EndDate,'12/31/2020')))
      left join cftContact cp on cp.ContactID=ps.PkrContactID
      left join cftcontact t on pm.truckercontactid=t.contactid
      left join cftmarketsaletype mst on pm.marketsaletypeid=mst.marketsaletypeid
      left join cftPSOrdHdr o on o.OrdNbr=ps.OrdNbr
      left join 
              (Select batnbr, refnbr, sum(DT) 'DT', sum(DY) 'DY', sum(CD) 'CD'
                 From (
                              select batnbr, refnbr, 
                                       Case when DetailTypeID='DT' then isnull(Qty,0) else 0 end 'DT',
                                       Case when DetailTypeID='DY' then isnull(Qty,0) else 0 end 'DY',
                                       Case when DetailTypeID='CD' then isnull(Qty,0) else 0 end 'CD'
                                from cftPSDetail          
                               where DetailTypeID in ('DT','DY','CD')
                          ) psd
               group by batnbr, refnbr) deads on ps.batnbr=deads.batnbr and ps.refnbr=deads.refnbr
              
where pm.MovementDate >='1/17/2016' 
  and ar.CustId in (select distinct CustID from cftPigSale)
  and ps.OrdNbr<>'005605' --This takes out the Hog inventories that are being input via PigSale to close the PigGroups that SBF purchased on 3/7/2016

