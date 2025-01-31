-- Melhores performances com relação a NMD
SELECT sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
       ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
       ROUND(epb.w_max / 38.0533, 3) AS NMD_2A
FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
    ON epb.stiffened_plate_analysis_id = spa.id
INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
    ON spa.stiffened_plate_id = sp.id
WHERE spa.buckling_load_type_id = 2 
  AND epb.id NOT BETWEEN 259 AND 266
  and ROUND(epb.w_max / 38.0533, 3)<0.05;
  
 
 -- Melhores performances com relação a NMD
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
  AND sp.t_s in (10, 15, 20)
  AND sp.N_ls = 4 and sp.N_ts = 2;
  -- order by sp.t_s;
  
 
 -- Melhores performances para NMD com relação a Nls e Nts
  WITH RankedValues AS (
    SELECT sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
           ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
           ROUND(epb.w_max / 38.0533, 3) AS NMD_2A,
           ROW_NUMBER() OVER (PARTITION BY sp.N_ls, sp.N_ts ORDER BY ROUND(epb.w_max / 38.0533, 3) ASC) AS RowNum
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
    WHERE spa.buckling_load_type_id = 2 
      AND epb.id NOT BETWEEN 259 AND 266
      AND sp.t_s IN (10, 15, 20)
)
SELECT N_ls, N_ts, k, h_s, t_s, sigma_u, w_max, NUS_2A, NMD_2A
FROM RankedValues
WHERE RowNum = 1;

 -- Piores performances para NMD com relação a Nls e Nts
  WITH RankedValues AS (
    SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
           ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
           ROUND(epb.w_max / 38.0533, 3) AS NMD_2A,
           ROW_NUMBER() OVER (PARTITION BY sp.N_ls, sp.N_ts ORDER BY ROUND(epb.w_max / 38.0533, 3) DESC) AS RowNum
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
    WHERE spa.buckling_load_type_id = 2 
      AND epb.id NOT BETWEEN 259 AND 266
)
SELECT id, N_ls, N_ts, k, h_s, t_s, sigma_u, w_max, NUS_2A, NMD_2A
FROM RankedValues
WHERE RowNum = 1;

-- Melhores agruapdos por N_ls:

WITH RankedValues AS (
    SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
           ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
           ROUND(epb.w_max / 38.0533, 3) AS NMD_2A,
           ROW_NUMBER() OVER (PARTITION BY sp.N_ls ORDER BY ROUND(epb.w_max / 38.0533, 3) ASC) AS RowNum
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
    WHERE spa.buckling_load_type_id = 2 
      AND epb.id NOT BETWEEN 259 AND 266
      AND sp.t_s IN (10, 15, 20)
)
SELECT id, N_ls, N_ts, k, h_s, t_s, sigma_u, w_max, NUS_2A, NMD_2A
FROM RankedValues
WHERE RowNum = 1;


-- Melhores agruapdos por N_ts:

WITH RankedValues AS (
    SELECT sp.id, sp.N_ls, sp.N_ts, sp.k, sp.h_s, sp.t_s, epb.sigma_u, epb.w_max, 
           ROUND(epb.sigma_u / 59.68, 3) AS NUS_2A, 
           ROUND(epb.w_max / 38.0533, 3) AS NMD_2A,
           ROW_NUMBER() OVER (PARTITION BY sp.N_ts ORDER BY ROUND(epb.w_max / 38.0533, 3) ASC) AS RowNum
    FROM constructal_automate_results.cbeb_elastoplasticbuckling epb
    INNER JOIN constructal_automate_results.cbeb_stiffenedplateanalysis spa 
        ON epb.stiffened_plate_analysis_id = spa.id
    INNER JOIN constructal_automate_results.csg_stiffenedplate sp 
        ON spa.stiffened_plate_id = sp.id
    WHERE spa.buckling_load_type_id = 2 
      AND epb.id NOT BETWEEN 259 AND 266
      AND sp.t_s IN (10, 15, 20)
)
SELECT id, N_ls, N_ts, k, h_s, t_s, sigma_u, w_max, NUS_2A, NMD_2A
FROM RankedValues
WHERE RowNum = 1;




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
  and ROUND(epb.w_max / 38.0533, 3)=0.382;