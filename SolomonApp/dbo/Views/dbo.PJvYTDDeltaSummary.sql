
CREATE VIEW PJvYTDDeltaSummary
as
select PJYTDAIC_delta.acct, PJYTDAIC_delta.project, PJYTDAIC_delta.pjt_entity, PJYTDAIC_delta.fsyear_num,
       PJYTDAIC_delta.rate_01, PJYTDAIC_delta.rate_02, PJYTDAIC_delta.rate_03, PJYTDAIC_delta.rate_04, PJYTDAIC_delta.rate_05,
       PJYTDAIC_delta.rate_06, PJYTDAIC_delta.rate_07, PJYTDAIC_delta.rate_08, PJYTDAIC_delta.rate_09, PJYTDAIC_delta.rate_10,
       PJYTDAIC_delta.rate_11, PJYTDAIC_delta.rate_12, PJYTDAIC_delta.rate_13, PJYTDAIC_delta.rate_14, PJYTDAIC_delta.rate_15,
       PJYTDAIC_delta.BegAmt, ytd_01, ytd_02, ytd_03, ytd_04, ytd_05, ytd_06, ytd_07, ytd_08, ytd_09, ytd_10, ytd_11, ytd_12, 
       PJYTDAIC_delta.ytd_01 'amount_01',
       -- using max_period prevents a large negative for the delta of the period after the last one processed
       case when PJYTDAIC_delta.max_period >= '02' then PJYTDAIC_delta.ytd_02 - PJYTDAIC_delta.ytd_01 else 0 end 'amount_02',
       case when PJYTDAIC_delta.max_period >= '03' then PJYTDAIC_delta.ytd_03 - PJYTDAIC_delta.ytd_02 else 0 end 'amount_03',
       case when PJYTDAIC_delta.max_period >= '04' then PJYTDAIC_delta.ytd_04 - PJYTDAIC_delta.ytd_03 else 0 end 'amount_04',
       case when PJYTDAIC_delta.max_period >= '05' then PJYTDAIC_delta.ytd_05 - PJYTDAIC_delta.ytd_04 else 0 end 'amount_05',
       case when PJYTDAIC_delta.max_period >= '06' then PJYTDAIC_delta.ytd_06 - PJYTDAIC_delta.ytd_05 else 0 end 'amount_06',
       case when PJYTDAIC_delta.max_period >= '07' then PJYTDAIC_delta.ytd_07 - PJYTDAIC_delta.ytd_06 else 0 end 'amount_07',
       case when PJYTDAIC_delta.max_period >= '08' then PJYTDAIC_delta.ytd_08 - PJYTDAIC_delta.ytd_07 else 0 end 'amount_08',
       case when PJYTDAIC_delta.max_period >= '09' then PJYTDAIC_delta.ytd_09 - PJYTDAIC_delta.ytd_08 else 0 end 'amount_09',
       case when PJYTDAIC_delta.max_period >= '10' then PJYTDAIC_delta.ytd_10 - PJYTDAIC_delta.ytd_09 else 0 end 'amount_10',
       case when PJYTDAIC_delta.max_period >= '11' then PJYTDAIC_delta.ytd_11 - PJYTDAIC_delta.ytd_10 else 0 end 'amount_11',
       case when PJYTDAIC_delta.max_period >= '12' then PJYTDAIC_delta.ytd_12 - PJYTDAIC_delta.ytd_11 else 0 end 'amount_12',
       case when PJYTDAIC_delta.max_period >= '13' then PJYTDAIC_delta.ytd_13 - PJYTDAIC_delta.ytd_12 else 0 end 'amount_13',
       case when PJYTDAIC_delta.max_period >= '14' then PJYTDAIC_delta.ytd_14 - PJYTDAIC_delta.ytd_13 else 0 end 'amount_14',
       case when PJYTDAIC_delta.max_period  = '15' then PJYTDAIC_delta.ytd_15 - PJYTDAIC_delta.ytd_14 else 0 end 'amount_15',
       Isnull(PJPTDSUM.eac_amount, 0) 'EAC_Amt'
from (select left(period, 4) 'fsyear_num', acct, project, pjt_entity, max(RIGHT(period, 2)) 'max_period', max(amount_bf) as 'BegAmt',
             sum(case RIGHT(period, 2)
                     when '01' then amount_01 else 0
                 end) 'ytd_01',
             sum(case RIGHT(period, 2)
                     when '02' then amount_01 + amount_02 else 0
                 end) 'ytd_02',
             sum(case RIGHT(period, 2)
                     when '03' then amount_01 + amount_02 + amount_03 else 0
                 end) 'ytd_03',
             sum(case RIGHT(period, 2)
                     when '04' then amount_01 + amount_02 + amount_03 + amount_04 else 0
                 end) 'ytd_04',
             sum(case RIGHT(period, 2)
                     when '05' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 else 0
                 end) 'ytd_05',
             sum(case RIGHT(period, 2)
                     when '06' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 else 0
                 end) 'ytd_06',
             sum(case RIGHT(period, 2)
                     when '07' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 + amount_07 else 0
                 end) 'ytd_07',
             sum(case RIGHT(period, 2)
                     when '08' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 + amount_07 + amount_08 else 0
                 end) 'ytd_08',
             sum(case RIGHT(period, 2)
                     when '09' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 + amount_07 + amount_08 + amount_09 else 0
                 end) 'ytd_09',
             sum(case RIGHT(period, 2)
                     when '10' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 + amount_07 + amount_08 + amount_09 + amount_10 else 0
                 end) 'ytd_10',
             sum(case RIGHT(period, 2)
                     when '11' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 + amount_07 + amount_08 + amount_09 + amount_10 + amount_11 else 0
                 end) 'ytd_11',
             sum(case RIGHT(period, 2)
                     when '12' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 + amount_07 + amount_08 + amount_09 + amount_10 + amount_11 + amount_12 else 0
                 end) 'ytd_12',
             sum(case RIGHT(period, 2)
                     when '13' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 + amount_07 + amount_08 + amount_09 + amount_10 + amount_11 + amount_12 + amount_13 else 0
                 end) 'ytd_13',
             sum(case RIGHT(period, 2)
                     when '14' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 + amount_07 + amount_08 + amount_09 + amount_10 + amount_11 + amount_12 + amount_13 + amount_14 else 0
                 end) 'ytd_14',
             sum(case RIGHT(period, 2)
                     when '15' then amount_01 + amount_02 + amount_03 + amount_04 + amount_05 + amount_06 + amount_07 + amount_08 + amount_09 + amount_10 + amount_11 + amount_12 + amount_13 + amount_14 + amount_15 else 0
                 end) 'ytd_15',
             max(case RIGHT(period, 2) when '01' then rate else 0 end) 'rate_01',
             max(case RIGHT(period, 2) when '02' then rate else 0 end) 'rate_02',
             max(case RIGHT(period, 2) when '03' then rate else 0 end) 'rate_03',
             max(case RIGHT(period, 2) when '04' then rate else 0 end) 'rate_04',
             max(case RIGHT(period, 2) when '05' then rate else 0 end) 'rate_05',
             max(case RIGHT(period, 2) when '06' then rate else 0 end) 'rate_06',
             max(case RIGHT(period, 2) when '07' then rate else 0 end) 'rate_07',
             max(case RIGHT(period, 2) when '08' then rate else 0 end) 'rate_08',
             max(case RIGHT(period, 2) when '09' then rate else 0 end) 'rate_09',
             max(case RIGHT(period, 2) when '10' then rate else 0 end) 'rate_10',
             max(case RIGHT(period, 2) when '11' then rate else 0 end) 'rate_11',
             max(case RIGHT(period, 2) when '12' then rate else 0 end) 'rate_12',
             max(case RIGHT(period, 2) when '13' then rate else 0 end) 'rate_13',
             max(case RIGHT(period, 2) when '14' then rate else 0 end) 'rate_14',
             max(case RIGHT(period, 2) when '15' then rate else 0 end) 'rate_15'
      from PJYTDAIC
      group by left(period, 4), acct, project, pjt_entity) PJYTDAIC_delta
left join PJPTDSUM
    on PJPTDSUM.project = PJYTDAIC_delta.project
    and PJPTDSUM.pjt_entity = PJYTDAIC_delta.pjt_entity
    and PJPTDSUM.acct = PJYTDAIC_delta.acct
    

