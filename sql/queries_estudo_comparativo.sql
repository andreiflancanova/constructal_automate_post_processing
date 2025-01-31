-- Resultados Dissertação
SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, (p.b + sp.N_ts*sp.h_s) as L, (p.b*sp.t_1+sp.N_ts*sp.h_s*sp.t_s) as A, sp.t_1, epb.n_u 
FROM constructal_automate_results.cbeb_elastoplasticbuckling as epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis as spa on epb.stiffened_plate_analysis_id=spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate as sp on spa.stiffened_plate_id=sp.id
INNER JOIN constructal_automate_results.csg_plate p on p.id = sp.plate_id 
where spa.buckling_load_type_id = 1
and sp.N_ls = 2 and sp.N_ts = 2;

-- Query para geração dos resultados de verificação da API REST.

SELECT 
    subquery.N_ls, 
    subquery.N_ts, 
    subquery.k, 
    subquery.h_s, 
    subquery.t_s, 
    subquery.L, 
    subquery.A, 
    round((subquery.N_u_1A * subquery.L / subquery.A)/186.46, 3) AS NUS_1A
FROM (
    SELECT 
    	sp.id as SP_ID,
        sp.N_ls, 
        sp.N_ts, 
        sp.k, 
        sp.h_s, 
        sp.t_s, 
        (p.b + sp.N_ls * sp.h_s) AS L, 
        (p.b * sp.t_1 + sp.N_ls * sp.h_s * sp.t_s) AS A,
        epb.n_u as N_u_1A
    FROM constructal_automate_results.cbeb_elastoplasticbuckling AS epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis AS spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate AS sp 
        ON spa.stiffened_plate_id = sp.id
    INNER JOIN constructal_automate_results.csg_plate AS p 
        ON p.id = sp.plate_id
    WHERE spa.buckling_load_type_id = 1
) subquery;


-- Query para trazer NUS_1A e NUS_2A


SELECT 
    sp.id AS SP_ID,
    sp.N_ls, 
    sp.N_ts, 
    sp.k, 
    sp.h_s, 
    sp.t_s, 
    (p.b + sp.N_ls * sp.h_s) AS L_eq, 
    (p.b * sp.t_1 + sp.N_ls * sp.h_s * sp.t_s) AS A_eq,
    ROUND((p.b * sp.t_1 + sp.N_ls * sp.h_s * sp.t_s)/(p.b + sp.N_ls * sp.h_s), 2) AS t_eq,
    ROUND((epb1.n_u * (p.b + sp.N_ls * sp.h_s) / (p.b * sp.t_1 + sp.N_ls * sp.h_s * sp.t_s)),2) as TENSAO_1A,
    ROUND((epb1.n_u * (p.b + sp.N_ls * sp.h_s) / (p.b * sp.t_1 + sp.N_ls * sp.h_s * sp.t_s)) / 186.46, 3) AS NUS_1A,
    ROUND((epb2.n_u /sp.t_1), 2) AS TENSAO_2A,
    ROUND((epb2.n_u /sp.t_1) / 59.68, 3) AS NUS_2A
FROM constructal_automate_results.csg_stiffenedplate AS sp
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis AS spa1 
    ON spa1.stiffened_plate_id = sp.id AND spa1.buckling_load_type_id = 1
INNER JOIN constructal_automate_results.cbeb_elastoplasticbuckling AS epb1 
    ON epb1.stiffened_plate_analysis_id = spa1.id
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis AS spa2 
    ON spa2.stiffened_plate_id = sp.id AND spa2.buckling_load_type_id = 2
INNER JOIN constructal_automate_results.cbeb_elastoplasticbuckling AS epb2  
    ON epb2.stiffened_plate_analysis_id = spa2.id and epb2.id not between 259 and 266
INNER JOIN constructal_automate_results.csg_plate AS p 
    ON p.id = sp.plate_id;
-- WHERE ROUND((epb1.n_u * (p.b + sp.N_ls * sp.h_s) / (p.b * sp.t_1 + sp.N_ls * sp.h_s * sp.t_s)) / 186.46, 3) > ROUND((epb2.n_u /sp.t_1) / 59.68, 3);
