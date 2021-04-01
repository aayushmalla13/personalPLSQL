
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
    
            ) select * from remres; 