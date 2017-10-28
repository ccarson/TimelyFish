CREATE VIEW _hypmv_0   AS SELECT  [dbo].[cftpiggroup].[taskid] as _hypmv_0_col_1,  [dbo].[cftpiggroup].[projectid] as _hypmv_0_col_2,  [dbo].[cftpiggroup].[sitecontactid] as _hypmv_0_col_3,  [dbo].[cftcontact].[contactid] as _hypmv_0_col_4,  [dbo].[cftpiggroup].[piggroupid] as _hypmv_0_col_5,  
[dbo].[cftpiggroup].[pgstatusid] as _hypmv_0_col_6,  [dbo].[cftpginvtran].[reversal] as _hypmv_0_col_7,  [dbo].[cftpginvtran].[acct] as _hypmv_0_col_8,  [dbo].[cftpginvtran].[trandate] as _hypmv_0_col_9,  
[dbo].[cftcontactaddress].[addresstypeid] as _hypmv_0_col_10,  
[dbo].[cftpiggroup].[pigprodphaseid] as _hypmv_0_col_11,  [dbo].[cftpginvtran].[inveffect] as _hypmv_0_col_12,  [dbo].[cftpstype].[descr] as _hypmv_0_col_13,  [dbo].[cftcontact].[contactname] as _hypmv_0_col_14,  
SUM([dbo].[cftPGInvTran].[Qty]) as _hypmv_0_col_15, SUM([dbo].[cftPGInvTran].[TotalWgt]) as _hypmv_0_col_16, 
SUM([dbo].[cftPGInvTran].[Qty]*[dbo].[cftPGInvTran].[InvEffect]) as _hypmv_0_col_17, SUM([dbo].[cftPGInvTran].[TotalWgt]*[dbo].[cftPGInvTran].[InvEffect]) as _hypmv_0_col_18, count_big(*) as _hypmv_0_col_19 FROM  [dbo].[cftpigprodphase],  
[dbo].[cftpigsale],  [dbo].[pjptdsum],  
[dbo].[cftcontact],  [dbo].[cftpiggroup],  [dbo].[cftsite],  [dbo].[cftpginvtran],  [dbo].[cftcontactaddress],  [dbo].[cftpstype]   
WHERE ( [dbo].[cftpigprodphase].[pigprodphaseid] = [dbo].[cftpiggroup].[pigprodphaseid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) 
AND ( [dbo].[cftpigsale].[refnbr] = [dbo].[cftpginvtran].[sourcerefnbr] ) AND ( [dbo].[cftpigsale].[batnbr] = [dbo].[cftpginvtran].[sourcebatnbr] ) AND ( [dbo].[cftpigsale].[saletypeid] = [dbo].[cftpstype].[salestypeid] ) 
AND (( [dbo].[pjptdsum].[project] = [dbo].[cftpiggroup].[projectid] ) AND ( [dbo].[pjptdsum].[pjt_entity] = [dbo].[cftpiggroup].[taskid] )) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) AND ( [dbo].[cftpiggroup].[sitecontactid] = [dbo].[cftsite].[contactid] ) 
AND ( [dbo].[cftcontact].[contactid] = [dbo].[cftpiggroup].[sitecontactid] ) 
AND ( [dbo].[cftcontact].[contactid] = [dbo].[cftcontactaddress].[contactid] ) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[sourcepiggroupid] ) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) 
AND ( [dbo].[cftpiggroup].[piggroupid] = [dbo].[cftpginvtran].[piggroupid] ) 
GROUP BY  [dbo].[cftpiggroup].[taskid],  [dbo].[cftpiggroup].[projectid],  [dbo].[cftpiggroup].[sitecontactid],  [dbo].[cftcontact].[contactid],  
[dbo].[cftpiggroup].[piggroupid],  [dbo].[cftpiggroup].[pgstatusid],  [dbo].[cftpginvtran].[reversal],  
[dbo].[cftpginvtran].[acct],  [dbo].[cftpginvtran].[trandate],  [dbo].[cftcontactaddress].[addresstypeid],  
[dbo].[cftpiggroup].[pigprodphaseid],  [dbo].[cftpginvtran].[inveffect],  [dbo].[cftpstype].[descr],  [dbo].[cftcontact].[contactname] 



 