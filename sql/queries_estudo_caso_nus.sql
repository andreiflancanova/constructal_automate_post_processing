-- EC 2A - NUS

-- Casos com Problema Desconsiderando o reprocess
SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.n_u, epb.sigma_u, epb.w_max, epb.w_dist_img_path, round(epb.w_max/38.0533,3) FROM constructal_automate_results.cbeb_elastoplasticbuckling as epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis as spa on epb.stiffened_plate_analysis_id=spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate as sp on spa.stiffened_plate_id=sp.id
WHERE spa.buckling_load_type_id = 2 and epb.id not between 259 and 266 and
sp.id in (14, 22, 37, 46, 69, 79, 94, 101, 105, 107,113, 121, 128, 129);


-- Reexecutados para validar valores
SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.n_u, epb.sigma_u, epb.w_max, epb.w_dist_img_path, round(epb.w_max/38.0533,3) FROM constructal_automate_results.cbeb_elastoplasticbuckling as epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis as spa on epb.stiffened_plate_analysis_id=spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate as sp on spa.stiffened_plate_id=sp.id
WHERE spa.buckling_load_type_id = 2 and epb.id not between 259 and 266 and
sp.id in (22, 79, 94, 101, 105, 113, 129);



-- Registros que precisaram ser corrigidos
SELECT spa.analysis_dir_path, REGEXP_SUBSTR(epb.w_dist_img_path, '[^/]+(?=_w_dist)') as analysis_file_name, REPLACE(spa.analysis_lgw_file_path, 'txt','db') as analysis_db_path FROM constructal_automate_results.cbeb_elastoplasticbuckling as epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis as spa on epb.stiffened_plate_analysis_id=spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate as sp on spa.stiffened_plate_id=sp.id
WHERE
spa.buckling_load_type_id = 2 and
epb.id not between 259 and 266 and
sp.id in (14, 22, 37, 46, 69, 79, 94, 101, 105, 107,113, 121, 128, 129);


-- Melhores performances com relação a NUS
SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
       ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
       ROUND(epb.w_max / 38.0533, 3) AS NMD_2A
FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
    ON epb.stiffened_plate_analysis_id = spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
    ON spa.stiffened_plate_id = sp.id
WHERE spa.buckling_load_type_id = 2 
  AND epb.id NOT BETWEEN 259 AND 266
  AND (epb.sigma_u, sp.N_ls, sp.N_ts) IN (
    SELECT MAX(epb.sigma_u), sp.N_ls, sp.N_ts
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
    WHERE spa.buckling_load_type_id = 2 
      AND epb.id NOT BETWEEN 259 AND 266
    GROUP BY sp.N_ls, sp.N_ts
  );
 
 -- Piores performances com relação a NUS
 SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
       ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
       ROUND(epb.w_max / 38.0533, 3) AS NMD_2A
FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
    ON epb.stiffened_plate_analysis_id = spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
    ON spa.stiffened_plate_id = sp.id
WHERE spa.buckling_load_type_id = 2 
  AND epb.id NOT BETWEEN 259 AND 266
  AND (epb.sigma_u, sp.N_ls, sp.N_ts) IN (
    SELECT MIN(epb.sigma_u), sp.N_ls, sp.N_ts
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
    WHERE spa.buckling_load_type_id = 2 
      AND epb.id NOT BETWEEN 259 AND 266
    GROUP BY sp.N_ls, sp.N_ts
  );

  SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
       ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
       ROUND(epb.w_max / 38.0533, 4) AS NMD_2A
FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
    ON epb.stiffened_plate_analysis_id = spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
    ON spa.stiffened_plate_id = sp.id
WHERE spa.buckling_load_type_id = 2 
  AND epb.id NOT BETWEEN 259 AND 266
  AND (epb.sigma_u, sp.N_ls, sp.N_ts) IN (
    SELECT MAX(epb.sigma_u), sp.N_ls, sp.N_ts
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
    WHERE spa.buckling_load_type_id = 2 AND sp.id !=1
      AND epb.id NOT BETWEEN 259 AND 266
    GROUP BY sp.N_ls, sp.N_ts
  );
 
  -- Melhores performances com relação a NUS para N_ts
 SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
       ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
       ROUND(epb.w_max / 38.0533, 3) AS NMD_2A
FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
    ON epb.stiffened_plate_analysis_id = spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
    ON spa.stiffened_plate_id = sp.id
WHERE spa.buckling_load_type_id = 2 
  AND epb.id NOT BETWEEN 259 AND 266
  AND (epb.sigma_u, sp.N_ls, sp.N_ts) IN (
    SELECT MAX(epb.sigma_u), sp.N_ls, sp.N_ts
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
    WHERE spa.buckling_load_type_id = 2 AND sp.id !=1 and sp.N_ls =5
      AND epb.id NOT BETWEEN 259 AND 266
    GROUP BY sp.N_ls, sp.N_ts
  );

 -- Melhores performances com relação a NUS para N_ts
 SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
       ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
       ROUND(epb.w_max / 38.0533, 3) AS NMD_2A
FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
    ON epb.stiffened_plate_analysis_id = spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
    ON spa.stiffened_plate_id = sp.id
WHERE spa.buckling_load_type_id = 2 
  AND epb.id NOT BETWEEN 259 AND 266
  AND (epb.sigma_u, sp.N_ls, sp.N_ts) IN (
    SELECT MAX(epb.sigma_u), sp.N_ls, sp.N_ts
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
    WHERE spa.buckling_load_type_id = 2 AND sp.id !=1 and sp.N_ts =5
      AND epb.id NOT BETWEEN 259 AND 266
    GROUP BY sp.N_ls, sp.N_ts
  );
 