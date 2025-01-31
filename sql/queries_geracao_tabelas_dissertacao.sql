

SELECT sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, ROUND(epb.sigma_u/59.68, 3) as 'NUS_2A', ROUND(epb.w_max/38.0533,3) as 'NMD_2A' 
FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa on epb.stiffened_plate_analysis_id = spa.id 
INNER JOIN constructal_automate_results.csg_stiffenedplate sp on spa.stiffened_plate_id = sp.id
WHERE ;

-- Casos onde a performance foi inferior a placa sem enrijecedores
SELECT *
FROM (
    SELECT sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
           ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
) subquery
WHERE NUS_2A < 1;

-- Melhor e Pior Desempenho
SELECT *
FROM (
    SELECT sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
           ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
) subquery
WHERE sigma_u IN (
    SELECT MIN(epb.sigma_u) FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    UNION
    SELECT MAX(epb.sigma_u) FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
);

-- Melhores desempenhos agrupados por N_ls e N_ts

SELECT sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
       ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A
FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
    ON epb.stiffened_plate_analysis_id = spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
    ON spa.stiffened_plate_id = sp.id
WHERE ROUND(epb.sigma_u / 59.68, 3) IN (
    SELECT MAX(ROUND(e.sigma_u / 59.68, 3))
    FROM constructal_automate_results.cbeb_elastoplasticbuckling e
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis sa 
        ON e.stiffened_plate_analysis_id = sa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate s 
        ON sa.stiffened_plate_id = s.id
    GROUP BY s.N_ls, s.N_ts
);

-- Piores desempenhos agrupados por N_ls e N_ts

SELECT sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
       ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A
FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
    ON epb.stiffened_plate_analysis_id = spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
    ON spa.stiffened_plate_id = sp.id
WHERE ROUND(epb.sigma_u / 59.68, 3) IN (
    SELECT MIN(ROUND(e.sigma_u / 59.68, 3))
    FROM constructal_automate_results.cbeb_elastoplasticbuckling e
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis sa 
        ON e.stiffened_plate_analysis_id = sa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate s 
        ON sa.stiffened_plate_id = s.id
    GROUP BY s.N_ls, s.N_ts
);



-- Casos com Problema no NMD
SELECT *
FROM (
    SELECT spa.id as SPA_ID, sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
           ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
           ROUND(epb.w_max / 38.0533, 3) AS NMD_2A
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
) subquery
WHERE NMD_2A BETWEEN 2 AND 5 and SPA_ID <=129;

SELECT SP_ID
FROM (
    SELECT sp.id as SP_ID, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
           ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
           ROUND(epb.w_max / 38.0533, 3) AS NMD_2A
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
) subquery
WHERE NMD_2A > 5;

SELECT *
FROM (
    SELECT spa.id, sp.id as SP_ID, spa.buckling_load_type_id as BUCKLING_LOAD_TYPE, sp.N_ls, sp.N_ts, epb.n_u ,epb.sigma_u, epb.w_max, 
           ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
           ROUND(epb.w_max / 38.0533, 3) AS NMD_2A
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
) subquery
WHERE SP_ID IN (5, 55, 63, 75, 77, 78, 97, 128) AND BUCKLING_LOAD_TYPE = 2;

SELECT x.* FROM constructal_automate_results.cbeb_elastoplasticbuckling x

5, 259, 55, 260, 63, 261, 75, 262, 77, 263, 78, 264, 97, 265, 128, 266
