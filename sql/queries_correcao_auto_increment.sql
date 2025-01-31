SET FOREIGN_KEY_CHECKS = 0;

-- TRUNCATE TABLE constructal_automate_results.csg_stiffenedplate;
-- TRUNCATE TABLE constructal_automate_results.csg_plate;
-- TRUNCATE TABLE constructal_automate_results.cbeb_stiffenedplateanalysis;
-- TRUNCATE TABLE constructal_automate_results.cbeb_elasticbuckling;
-- TRUNCATE TABLE constructal_automate_results.cbeb_elastoplasticbuckling;

SET FOREIGN_KEY_CHECKS = 1;


SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE constructal_automate_results.cbeb_stiffenedplateanalysis AUTO_INCREMENT=259;
ALTER TABLE constructal_automate_results.cbeb_elasticbuckling AUTO_INCREMENT=259;
ALTER TABLE constructal_automate_results.cbeb_elastoplasticbuckling AUTO_INCREMENT=259;
SET FOREIGN_KEY_CHECKS = 1;


use constructal_automate_results;
show table status like 'cbeb_elastoplasticbuckling';

use constructal_automate_results;
show table status like 'cbeb_stiffenedplateanalysis';