-------FINAL QUERY----------
select vw_bot20.cName,vw_bot20.totalCases, vw_top20.cName,vw_top20.totalCases,totalNum.case_type,totalNum.case_count,vw_newdata.cName,vw_newdata.newCases,vw_newdata.newDeaths
from vw_bot20   join vw_top20
on vw_bot20.ids = vw_top20.ids 
 left join totalNum
on
vw_top20.ids= totalNum.ids
left join vw_newdata
on
vw_top20.ids=vw_newdata.ids;



    with remres as (
    SELECT 2 ids,'TotalCases' tc , 'Deaths' d , 'Recovered ' r from dual
    union
    SELECT 3,''||totalCases(), ''||totalDeaths() , ''|| totalRecovered() from dual
    union
    SELECT 5 ids,'Total Active Cases :' tc , ''||totalactiveCases() , 'Total Closed Cases: '||''||(totalCases() - totalactiveCases())  from dual
    union 
    SELECT 6, 'Mild Cases: ' || ''||totalmildCases || '('|| ROUND((totalmildCases()/totalactiveCases())*100,1) ||'%)',
    'Serious or critical :' || ''||totalSerious ||'('|| Round(totalSerious()/totalactiveCases()*100,1) ||'%)', 
     'Recovered/Discharged: '||''||totalRecovered || '('|| Round(totalRecovered()/(totalDeaths()+totalRecovered())*100) ||'%)' ||' Deaths:' ||''||totalDeaths ||'('|| Round(totalDeaths()/(totalCases() - totalactiveCases())*100) ||'%)'
    FROM DUAL
    
   union 
   select 10, country, cases,deaths from vw_newdata
    
    ) select vw_bot20.cName "TOP" ,vw_bot20.totalCases "20",remres.tc,remres.d,remres.r, vw_top20.cName "BOTTOM" ,vw_top20.totalCases " 20"
from vw_bot20    left join remres
on vw_bot20.ids=remres.ids
 left join vw_top20
on vw_bot20.ids = vw_top20.ids ;
   


--

--CREATE OR REPLACE VIEW vw_newdata as
--select  'NEPAL Position:'|| ''||rankFinder('NEPAL') country,'Total:'||ci.totalcases ||' New:'|| nc.newCases cases,'Total Deaths:'||ci.totaldeaths ||' New Deaths:'|| nc.newDeaths deaths from newcovidInfo nc
--inner join covidInfo ci
--on
--nc.cName = ci.cName
--where upper(nc.cName)='NEPAL';
----select * from vw_newdata;
--select 20,country,datas from vw_newdata;