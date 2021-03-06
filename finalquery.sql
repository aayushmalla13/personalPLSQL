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
            SELECT 2 ids,'TotalCases:' E ,' ' F, ' ' G,' ' H,  'Deaths:' d ,' ' M, 'Recovered: ' N, ' ' O from dual
            union
            SELECT 3 ids,''||totalCases() ,' ' F, ' ' G,' ' H, ''||totalDeaths(),' ' M, ''||totalRecovered(), ' ' O from dual    
            union
            SELECT 4 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
             SELECT 5 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
             SELECT 6 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
             SELECT 7 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
            SELECT 8 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, 'Closed Cases ' N, ' ' O from dual
            union
            SELECT 9 ids,'Active' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
            SELECT 10 ids,'Cases' E ,' ' F, ''||totalactiveCases(),' ' H,  ' ' d ,' ' M, ''||(totalCases() - totalactiveCases()), ' ' O from dual
            union
            SELECT 11 ids,' ' E ,' ' F, 'Currently Infected Patients ' G,' ' H,  ' ' d ,' ' M, 'Cases which has an outcome' N, ' ' O from dual
            union
            SELECT 12 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
            SELECT 13 ids,' ' E ,' ' F, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from dual
            union
            SELECT 14 ids,' ' E ,''||totalmildCases || '('|| ROUND((totalmildCases()/totalactiveCases())*100,1) ||'%)' , ' ' G,''||totalSerious ||'('|| Round(totalSerious()/totalactiveCases()*100,1) ||'%)',  ' ' d ,
            ''||totalRecovered || '('|| Round(totalRecovered()/(totalDeaths()+totalRecovered())*100) ||'%)' , ' ' N, 
            ''||totalDeaths ||'('|| Round(totalDeaths()/(totalCases() - totalactiveCases())*100) ||'%)' from dual
            union
            SELECT 15 ids,' ' E ,'in Mild Condition' , ' ' G,' Serious or Critical ' ,  ' ' d ,'Recovered/Discharged ' , ' ' N, 'Deaths '  from dual
            union
            SELECT 16 ids,' ' E , nepal, ' ' G,' ' H,  ' ' d ,' ' M, ' ' N, ' ' O from vw_newdata
    
            )select vw_bot20.cName "TOP" ,vw_bot20.totalCases "20",remres.E,remres.F,remres.G,remres.H,remres.d,remres.M,remres.N,remres.O, vw_top20.cName "BOTTOM" ,vw_top20.totalCases " 20"
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