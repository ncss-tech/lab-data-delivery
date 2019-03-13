USE [SSL_Repo]
GO

/****** Object:  View [dbo].[Combine_NASIS_NCSS_View]    Script Date: 10/26/2016 8:18:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[Combine_NASIS_NCSS_View]
AS
SELECT     ped_data.pedon_key, ped_data.site_key, ped_data.lab_ped_smp_num, NULL AS pedoniid, ped_data.user_pedon_id, NULL AS labdatadescflag, NULL AS pedobjupdate, NULL AS siteobjupdate, NULL 
                      AS priority, NULL AS priority2, taxo_data.samp_as_name, taxo_data.samp_class_type, taxo_data.samp_classdate, taxo_data.samp_classification_name, 
                      taxo_data.samp_taxorder, taxo_data.samp_taxsuborder, taxo_data.samp_taxgrtgroup, taxo_data.samp_taxsubgrp, taxo_data.samp_taxpartsize, 
                      taxo_data.samp_taxpartsizemod, taxo_data.samp_taxfamhahatmatcl, taxo_data.samp_taxceactcl, taxo_data.samp_taxreaction, taxo_data.samp_taxtempcl, taxo_data.samp_taxmoistscl, 
                      taxo_data.samp_taxtempregime, taxo_data.samp_taxminalogy, taxo_data.samp_taxother, NULL AS samp_osdtypelocflag, taxo_data.corr_as_name, 
                      taxo_data.corr_class_type, taxo_data.corr_classdate, taxo_data.corr_classification_name, taxo_data.corr_taxorder, taxo_data.corr_taxsuborder, 
                      taxo_data.corr_taxgrtgroup, taxo_data.corr_taxsubgrp, taxo_data.corr_taxpartsize, taxo_data.corr_taxpartsizemod, taxo_data.corr_taxfamhahatmatcl, taxo_data.corr_taxceactcl, 
                      taxo_data.corr_taxreaction, taxo_data.corr_taxtempcl, taxo_data.corr_taxmoistscl, taxo_data.corr_taxtempregime, taxo_data.corr_taxminalogy, 
                      taxo_data.corr_taxother, NULL AS corr_osdtypelocflag, taxo_data.SSL_as_name, taxo_data.SSL_class_type, taxo_data.SSL_classdate, 
                      taxo_data.SSL_classification_name, taxo_data.SSL_taxorder, taxo_data.SSL_taxsuborder, taxo_data.SSL_taxgrtgroup, taxo_data.SSL_taxsubgrp, 
                      taxo_data.SSL_taxpartsize, taxo_data.SSL_taxpartsizemod, taxo_data.SSL_taxfamhahatmatcl, taxo_data.SSL_taxceactcl, taxo_data.SSL_taxreaction, taxo_data.SSL_taxtempcl, 
                      taxo_data.SSL_taxmoistscl, taxo_data.SSL_taxtempregime, taxo_data.SSL_taxminalogy, taxo_data.SSL_taxother, NULL AS SSL_osdtypelocflag, NULL AS siteiid, 
                      site_data.user_site_id, ped_data.observation_date, site_data.latitude_std_decimal_degrees, site_data.longitude_std_decimal_degrees, site_area.country_key, 
                      site_area.state_admindiv_key, site_area.county_key, site_area.mlra_key, site_area.ssa_key, site_area.npark_key, site_area.nforest_key, 
                      'NCSS dated ' + CAST(GETDATE() AS VARCHAR) AS note
FROM         (SELECT     pedon_key, natural_key AS lab_ped_smp_num, user_pedon_id, site_key, observation_date
                       FROM          dbo.pedon
                       WHERE      (NOT (natural_key IS NULL))) AS ped_data INNER JOIN
                          (SELECT     site_key, user_site_id, latitude_std_decimal_degrees, longitude_std_decimal_degrees
                            FROM          dbo.site) AS site_data ON ped_data.site_key = site_data.site_key INNER JOIN
                          (SELECT     site_key,
                                                       (SELECT     TOP (1) area_key
                                                         FROM          dbo.site_area_listing AS sa
                                                         WHERE      (area_type = 'country') AND (site_key = qa.site_key)) AS country_key,
                                                       (SELECT     TOP (1) area_key
                                                         FROM          dbo.site_area_listing AS sa
                                                         WHERE      (area_type = 'state_admin_div') AND (site_key = qa.site_key)) AS state_admindiv_key,
                                                       (SELECT     TOP (1) area_key
                                                         FROM          dbo.site_area_listing AS sa
                                                         WHERE      (area_type = 'county') AND (site_key = qa.site_key)) AS county_key,
                                                       (SELECT     TOP (1) area_key
                                                         FROM          dbo.site_area_listing AS sa
                                                         WHERE      (area_type = 'mlra') AND (site_key = qa.site_key)) AS mlra_key,
                                                       (SELECT     TOP (1) area_key
                                                         FROM          dbo.site_area_listing AS sa
                                                         WHERE      (area_type = 'ssa') AND (site_key = qa.site_key)) AS ssa_key,
                                                       (SELECT     TOP (1) area_key
                                                         FROM          dbo.site_area_listing AS sa
                                                         WHERE      (area_type = 'national_park_system_land') AND (site_key = qa.site_key)) AS npark_key,
                                                       (SELECT     TOP (1) area_key
                                                         FROM          dbo.site_area_listing AS sa
                                                         WHERE      (area_type = 'National_Forest_System_Land') AND (site_key = qa.site_key)) AS nforest_key
                            FROM          dbo.site_area_listing AS qa
                            GROUP BY site_key) AS site_area ON site_data.site_key = site_area.site_key LEFT OUTER JOIN
                          (SELECT     pedon_key,
                                                       (SELECT     TOP (1) taxon_name
                                                         FROM          dbo.pedon_tax_hist
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_as_name,
                                                       (SELECT     TOP (1) taxon_kind
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_50
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_class_type,
                                                       (SELECT     TOP (1) class_date_key
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_49
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_classdate,
                                                       (SELECT     TOP (1) class_name
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_48
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_classification_name,
                                                       (SELECT     TOP (1) tax_order
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_47
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxorder,
                                                       (SELECT     TOP (1) suborder
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_46
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxsuborder,
                                                       (SELECT     TOP (1) great_group
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_45
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxgrtgroup,
                                                       (SELECT     TOP (1) subgroup
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_44
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxsubgrp,
                                                       (SELECT     TOP (1) fam_part_size
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_43
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxpartsize,
                                                       (SELECT     TOP (1) fam_part_size_mod
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_42a
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxpartsizemod,
                                                       (SELECT     TOP (1) fam_haht_mat_class
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_42b
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxfamhahatmatcl,
                                                       (SELECT     TOP (1) fam_c_e_act_class
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_41
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxceactcl,
                                                       (SELECT     TOP (1) fam_reaction
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_40
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxreaction,
                                                       (SELECT     TOP (1) fam_temp_class
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_39
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxtempcl,
                                                       (SELECT     TOP (1) moist_subclass
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_38
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxmoistscl,
                                                       (SELECT     TOP (1) temp_regime
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_37
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxtempregime,
                                                       (SELECT     TOP (1) dbo.TaxMinString(taxon_hist_key) AS Expr1
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_36
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxminalogy,
                                                       (SELECT     TOP (1) dbo.TaxOthString(taxon_hist_key) AS Expr1
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_61
                                                         WHERE      (class_type = 'sampled as') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS samp_taxother,
                                                       (SELECT     TOP (1) taxon_name
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_34
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_as_name,
                                                       (SELECT     TOP (1) taxon_kind
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_33
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_class_type,
                                                       (SELECT     TOP (1) class_date_key
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_32
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_classdate,
                                                       (SELECT     TOP (1) class_name
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_31
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_classification_name,
                                                       (SELECT     TOP (1) tax_order
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_30
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxorder,
                                                       (SELECT     TOP (1) suborder
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_29
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxsuborder,
                                                       (SELECT     TOP (1) great_group
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_28
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxgrtgroup,
                                                       (SELECT     TOP (1) subgroup
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_27
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxsubgrp,
                                                       (SELECT     TOP (1) fam_part_size
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_26
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxpartsize,
                                                       (SELECT     TOP (1) fam_part_size_mod
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_25a
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxpartsizemod,
                                                       (SELECT     TOP (1) fam_haht_mat_class
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_25b
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxfamhahatmatcl,
                                                       (SELECT     TOP (1) fam_c_e_act_class
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_24
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxceactcl,
                                                       (SELECT     TOP (1) fam_reaction
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_23
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxreaction,
                                                       (SELECT     TOP (1) fam_temp_class
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_22
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxtempcl,
                                                       (SELECT     TOP (1) moist_subclass
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_21
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxmoistscl,
                                                       (SELECT     TOP (1) temp_regime
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_20
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxtempregime,
                                                       (SELECT     TOP (1) dbo.TaxMinString(taxon_hist_key) AS Expr1
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_19
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxminalogy,
                                                       (SELECT     TOP (1) dbo.TaxOthString(taxon_hist_key) AS Expr1
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_61
                                                         WHERE      (class_type = 'correlated') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS corr_taxother,
                                                       (SELECT     TOP (1) taxon_name
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_17
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_as_name,
                                                       (SELECT     TOP (1) taxon_kind
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_16
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_class_type,
                                                       (SELECT     TOP (1) class_date_key
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_15
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_classdate,
                                                       (SELECT     TOP (1) class_name
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_14
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_classification_name,
                                                       (SELECT     TOP (1) tax_order
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_13
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxorder,
                                                       (SELECT     TOP (1) suborder
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_12
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxsuborder,
                                                       (SELECT     TOP (1) great_group
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_11
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxgrtgroup,
                                                       (SELECT     TOP (1) subgroup
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_10
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxsubgrp,
                                                       (SELECT     TOP (1) fam_part_size
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_9
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxpartsize,
                                                       (SELECT     TOP (1) fam_part_size_mod
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_8a
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxpartsizemod,
                                                       (SELECT     TOP (1) fam_haht_mat_class
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_8b
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxfamhahatmatcl,
                                                       (SELECT     TOP (1) fam_c_e_act_class
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_7
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxceactcl,
                                                       (SELECT     TOP (1) fam_reaction
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_6
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxreaction,
                                                       (SELECT     TOP (1) fam_temp_class
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_5
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxtempcl,
                                                       (SELECT     TOP (1) moist_subclass
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_4
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxmoistscl,
                                                       (SELECT     TOP (1) temp_regime
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_3
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxtempregime,
                                                       (SELECT     TOP (1) dbo.TaxMinString(taxon_hist_key) AS Expr1
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_2
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxminalogy,
                                                       (SELECT     TOP (1) dbo.TaxOthString(taxon_hist_key) AS Expr1
                                                         FROM          dbo.pedon_tax_hist AS pedon_tax_hist_61
                                                         WHERE      (class_type = 'SSL') AND (pedon_key = q1.pedon_key)
                                                         ORDER BY class_date_key DESC) AS SSL_taxother, NULL AS tail_column
                            FROM          dbo.taxonomy_data AS q1
                            GROUP BY pedon_key) AS taxo_data ON ped_data.pedon_key = taxo_data.pedon_key



GO

