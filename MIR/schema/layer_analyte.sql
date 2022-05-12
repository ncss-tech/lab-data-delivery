CREATE TABLE layer_analyte 
( `lay_analyte_id` REAL,
	`lay_id` REAL,
	`analyte_id` REAL,
	`proced_id` REAL,
	`master_prep_id` REAL,
	`size_frac` TEXT,
	`instr_set_id` REAL,
	`lab_id` REAL,
	`calc_value` TEXT,
	`num_obs` REAL,
	`std_dev` REAL,
	`reliability` INTEGER,
	`initial_calc_date` TEXT,
	`last_recalc_date` TEXT 
)
