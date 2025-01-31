
UPDATE constructal_automate_results.cbeb_elastoplasticbuckling epb
SET epb.id = epb.id + 1000
WHERE epb.id BETWEEN 142 AND 208;

UPDATE constructal_automate_results.cbeb_elastoplasticbuckling epb
SET epb.id = epb.id - 1001
WHERE epb.id BETWEEN 1142 AND 1208;

-- Primeiro intervalo
UPDATE constructal_automate_results.cbeb_elasticbuckling eb
SET eb.id = eb.id + 1000
WHERE eb.id BETWEEN 207 AND 256;

UPDATE constructal_automate_results.cbeb_elasticbuckling eb
SET eb.id = eb.id - 998
WHERE eb.id BETWEEN 1207 AND 1256;

-- Segundo intervalo
UPDATE constructal_automate_results.cbeb_elasticbuckling eb
SET eb.id = eb.id + 1000
WHERE eb.id BETWEEN 140 AND 206;

UPDATE constructal_automate_results.cbeb_elasticbuckling eb
SET eb.id = eb.id - 999
WHERE eb.id BETWEEN 1140 AND 1206;