CREATE TABLE physical 
( `labsampnum` TEXT,
	`result_source_key` REAL,
	`prep_code` TEXT,
	`texture_lab` TEXT,
	`particle_size_method` TEXT,
	`clay_total` REAL,
	`silt_total` REAL,
	`sand_total` REAL,
	`clay_fine` REAL,
	`clay_caco3` REAL,
	`silt_fine` REAL,
	`silt_coarse` REAL,
	`sand_very_fine` REAL,
	`sand_fine` REAL,
	`sand_medium` REAL,
	`sand_coarse` REAL,
	`sand_very_coarse` REAL,
	`frag_2_5_mm_wt_pct_lt_75` REAL,
	`frag__2_20_mm_wt_pct_lt_75` REAL,
	`frag_5_20_mm_wt_pct_lt_75` REAL,
	`frag_20_75_mm_wt_pct_lt_75` REAL,
	`total_frag_wt_pct_gt_2_mm_ws` REAL,
	`wt_pct_1_tenth_to_75_mm` REAL,
	`bulk_density_tenth_bar` REAL,
	`bulk_density_tenth_bar_method` TEXT,
	`bulk_density_third_bar` REAL,
	`bulk_density_third_bar_method` TEXT,
	`bulk_density_oven_dry` REAL,
	`bulk_density_oven_dry_method` TEXT,
	`bulk_density_lt_2_mm_air_dry` REAL,
	`bulk_density_air_dry_method` TEXT,
	`bd_third_bar_lt2_reconstituted` REAL,
	`bd_thirdbar_reconstituted_method` TEXT,
	`bulk_den_ovendry_reconstituted` REAL,
	`bulk_de_odreconstituted_method` TEXT,
	`bulk_density_field_moist` REAL,
	`bulk_density_field_moist_metho` TEXT,
	`particle_density_less_than_2mm` REAL,
	`particle_density_lt_2mm_method` TEXT,
	`particle_density_gt_2_mm` REAL,
	`particle_density_gt_2mm_method` TEXT,
	`cole_whole_soil` REAL,
	`cole_whole_soil_method` INTEGER,
	`le_third_fifteen_lt2_mm` REAL,
	`le_third_fifteen_lt2_metho` TEXT,
	`le_third_ovendry_lt_2_mm` REAL,
	`le_third_ovendry_lt_2_mm_metho` INTEGER,
	`le_field_moist_to_oben_dry` REAL,
	`le_fm_to_od_method` INTEGER,
	`water_retention_0_bar_sieve` REAL,
	`water_retention_0_bar_method` TEXT,
	`water_retention_6_hundredths` REAL,
	`water_retention_6_hund_method` TEXT,
	`water_retention_10th_bar` REAL,
	`water_retention_10th_bar_meth` TEXT,
	`water_retention_third_bar` REAL,
	`water_retention_thirdbar_metho` TEXT,
	`water_retention_1_bar` REAL,
	`water_retention_1_bar_method` TEXT,
	`water_retention_2_bar` REAL,
	`water_retention_2_bar_method` TEXT,
	`water_retention_3_bar_sieve` REAL,
	`water_retention_3_bar_method` TEXT,
	`water_retention_5_bar_sieve` REAL,
	`water_retention_5_bar_method` TEXT,
	`water_retention_15_bar` REAL,
	`water_retention_15_bar_method` TEXT,
	`water_retention_field_state` REAL,
	`water_retention_field_state_me` TEXT,
	`airdry_ovendry_ratio` REAL,
	`atterberg_liquid_limit` TEXT,
	`atterberg_liquid_limit_method` TEXT,
	`atterberg_plasticity_index` TEXT,
	`plastic_limit` TEXT,
	`plastic_limit_method` TEXT,
	`aggregate_stability_05_2_mm` REAL,
	`aggregate_stability_05_2_metho` TEXT,
	`le_to_clay_third_bar_to_ovendr` REAL,
	`water_15_bar_to_clay_ratio` REAL,
	`cec7_clay_ratio` REAL,
	`effective_cec_to_clay_ratio` REAL,
	`psda_ethanol_dispersion_method` TEXT,
	`sand_total_ethanol_dispersible` REAL,
	`silt_total_ethanol_dispersible` REAL,
	`clay_total_ethanol_dispersible` REAL,
	`sand_very_fine_ethanol_dispers` REAL,
	`sand_fine_ethanol_dispersible` REAL,
	`sand_medium_ethanol_dispersibl` REAL,
	`sand_coarse_ethanol_dispersibl` REAL,
	`sand_very_coarse_ethanol_disp` REAL,
	`water_dispersible_fraction_method` TEXT,
	`clay_tot_h2o_dispersible` REAL,
	`clay_fine_h2o_dispersible` REAL,
	`clay_co3_h2o_dispersible` REAL,
	`silt_total_h2o_dispersible` REAL,
	`silt_fine_h2o_dispersible` REAL,
	`silt_coarse_h2o_dispersible` REAL,
	`sand_total_h2o_dispersible` REAL,
	`sand_vf_h2o_dispersible` REAL,
	`sand_fine_h2o_dispersible` REAL,
	`sand_medium_h2o_dispersible` REAL,
	`sand_coarse_h2o_dispersible` REAL,
	`sand_vc_h2o_dispersible` REAL,
	`color_pyrophosphate_extract` TEXT,
	`color_pyrophosphate_method` TEXT,
	`bd_thirdbar_before_rewet_organ` REAL,
	`bd_before_rewet_organic_method` TEXT,
	`bd_thirdbar_rewet_organic_soil` REAL,
	`bd_third_rewet_organic_method` TEXT,
	`bulk_den_rewet_oven_dry` REAL,
	`bulk_den_rewet_oven_dry_method` TEXT,
	`mineral_content_loss_on_igniti` REAL,
	`mineral_content_loi_method` TEXT,
	`estimated_organic_matter` REAL,
	`estimated_om_plus_mineral` REAL,
	`fiber_analysis_method` TEXT,
	`fiber_unrubbed` REAL,
	`fiber_rubbed` REAL,
	`decomposition_state` TEXT,
	`limnic_material_type` TEXT 
)
