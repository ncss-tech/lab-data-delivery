USE [master]
GO
ALTER DATABASE [ncsslabdata] SET COMPATIBILITY_LEVEL = 130
GO

SELECT @@VERSION AS SQL_Server_Version

USE ncsslabdata
go


	  DROP TABLE IF exists result_light
	  DROP TABLE IF EXISTS #tempXX
	  DROP TABLE IF EXISTS SDA_Mineralogy_Glass_Count


	  CREATE TABLE result_light(result_key INT NOT NULL  , result_source_key INT, 
	  prep_key int,  result_type VARCHAR(128), result_reliability VARCHAR(20), 
	  analyte_key int, procedure_key int, source_system_key int, result_value VARCHAR(128) , 
	  prep_code VARCHAR(64) , proced_code VARCHAR(12), analyzed_size_frac VARCHAR(128)
	   CONSTRAINT pk_result_light PRIMARY KEY CLUSTERED (result_key)
	  )
	  go

	  INSERT INTO result_light 
	  SELECT result_key, result_source_key, r.prep_key,  result_type, result_reliability, r.analyte_key, r.procedure_key, r.source_system_key,   result_value,  ISNULL(p.prep_code, 
						 CASE WHEN r.analyte_key IN (1125,1126,1127,1185,1186,1187) THEN 'N'
							  WHEN r.analyte_key IN (1434,1435,1436,1437,1438,1439) THEN 'GP'
																							 ELSE 'S' END) AS prep_code  , ISNULL(b.proced_code, '') AS procedure_code, analyzed_size_frac
FROM  dbo.layer AS l 
INNER JOIN dbo.result  AS r ON l.layer_key = r.result_source_key 
INNER JOIN dbo.analyte AS a ON r.analyte_key = a.analyte_key 
LEFT JOIN dbo.preparation AS p ON r.prep_key = p.prep_key 
LEFT JOIN dbo.bridge_proced_ss AS b ON r.procedure_key = b.procedure_key AND 
                         r.source_system_key = b.source_system_key
            WHERE  (r.analyte_key IN (80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 817, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 
                         112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 
                         145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 
                         178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 
                         211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 463, 464, 465, 466, 467, 
                         468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 808, 1243, 1261, 1259, 1260, 1262, 1771, 644, 645, 646, 1080, 1081, 1082, 1125, 1126, 1127, 1437, 1438, 1439,
						 1148, 1185, 1434, 1149, 1186, 1435, 1150, 1187, 1436, 823)) AND (r.result_reliability IS NULL OR
                         r.result_reliability = '0')

	CREATE INDEX  result_light_idx1c ON  result_light (analyte_key, result_type, result_source_key,  result_reliability) INCLUDE (result_value, proced_code,prep_code)
	CREATE INDEX  result_light_idx1b ON  result_light (analyte_key,  result_reliability)
	CREATE INDEX  result_light_result_source_key_idx2 ON  result_light (result_source_key )
	CREATE INDEX result_light_prep_key_idx3 ON  result_light (prep_key)
	CREATE INDEX result_source_system_key_idx4 ON result_light (source_system_key)
	CREATE INDEX result_light_prep_code_idx5 ON  result_light (prep_code)


GO
SET STATISTICS IO ON
GO


SELECT  natural_key AS labsampnum, result_source_key,  prep_code, [analyzed_size_frac],
       (SELECT        TOP (1) ISNULL(dbo.bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            result_light INNER JOIN
                                                         dbo.preparation ON result_light.prep_key = dbo.preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result_light.procedure_key = dbo.bridge_proced_ss.procedure_key AND 
                                                         result_light.source_system_key = dbo.bridge_proced_ss.source_system_key
                               WHERE        (result_light.result_type = 'layer analyte') AND (result_light.result_value <> '') AND (NOT (result_light.result_value IS NULL)) AND 
                                                         (result_light.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (result_light.result_reliability IS NULL OR
                                                         result_light.result_reliability = '0') AND (analyzed_size_frac = q1.analyzed_size_frac)
														 AND (result_light.analyte_key IN (80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 817, 1243, 1261))) AS Glass_Count_Method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_19.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_19 INNER JOIN
                                                         dbo.preparation AS preparation_14 ON result_19.prep_key = preparation_14.prep_key
                               WHERE        (result_19.result_type = 'layer analyte') AND (result_19.result_source_key = q1.result_source_key) AND (preparation_14.prep_code = q1.prep_code) 
                                                         AND (result_19.analyzed_size_frac = q1.analyzed_size_frac) AND (result_19.analyte_key = 80)) AS BG_Basic_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_18.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_18 INNER JOIN
                                                         dbo.preparation AS preparation_13 ON result_18.prep_key = preparation_13.prep_key
                               WHERE        (result_18.result_type = 'layer analyte') AND (result_18.result_source_key = q1.result_source_key) AND (preparation_13.prep_code = q1.prep_code) 
                                                         AND (result_18.analyzed_size_frac = q1.analyzed_size_frac) AND (result_18.analyte_key = 81)) AS DI_Diatoms_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_17.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_17 INNER JOIN
                                                         dbo.preparation AS preparation_12 ON result_17.prep_key = preparation_12.prep_key
                               WHERE        (result_17.result_type = 'layer analyte') AND (result_17.result_source_key = q1.result_source_key) AND (preparation_12.prep_code = q1.prep_code) 
                                                         AND (result_17.analyzed_size_frac = q1.analyzed_size_frac) AND (result_17.analyte_key = 82)) AS GA_Glass_Aggregates_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_16.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_16 INNER JOIN
                                                         dbo.preparation AS preparation_11 ON result_16.prep_key = preparation_11.prep_key
                               WHERE        (result_16.result_type = 'layer analyte') AND (result_16.result_source_key = q1.result_source_key) AND (preparation_11.prep_code = q1.prep_code) 
                                                         AND (result_16.analyzed_size_frac = q1.analyzed_size_frac) AND (result_16.analyte_key = 83)) AS GS_Glass_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_15.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_15 INNER JOIN
                                                         dbo.preparation AS preparation_10 ON result_15.prep_key = preparation_10.prep_key
                               WHERE        (result_15.result_type = 'layer analyte') AND (result_15.result_source_key = q1.result_source_key) AND (preparation_10.prep_code = q1.prep_code) 
                                                         AND (result_15.analyzed_size_frac = q1.analyzed_size_frac) AND (result_15.analyte_key = 84)) AS FG_Glass_Coated_Feldspar_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_14.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_14 INNER JOIN
                                                         dbo.preparation AS preparation_9 ON result_14.prep_key = preparation_9.prep_key
                               WHERE        (result_14.result_type = 'layer analyte') AND (result_14.result_source_key = q1.result_source_key) AND (preparation_9.prep_code = q1.prep_code) 
                                                         AND (result_14.analyzed_size_frac = q1.analyzed_size_frac) AND (result_14.analyte_key = 85)) AS GC_Glass_Coated_Grain_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_13.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_13 INNER JOIN
                                                         dbo.preparation AS preparation_8 ON result_13.prep_key = preparation_8.prep_key
                               WHERE        (result_13.result_type = 'layer analyte') AND (result_13.result_source_key = q1.result_source_key) AND (preparation_8.prep_code = q1.prep_code) 
                                                         AND (result_13.analyzed_size_frac = q1.analyzed_size_frac) AND (result_13.analyte_key = 86)) AS HG_Glass_Coated_Hornblende_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_12.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_12 INNER JOIN
                                                         dbo.preparation AS preparation_7 ON result_12.prep_key = preparation_7.prep_key
                               WHERE        (result_12.result_type = 'layer analyte') AND (result_12.result_source_key = q1.result_source_key) AND (preparation_7.prep_code = q1.prep_code) 
                                                         AND (result_12.analyzed_size_frac = q1.analyzed_size_frac) AND (result_12.analyte_key = 87)) AS OG_Glass_Coated_Opaques_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_11.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_11 INNER JOIN
                                                         dbo.preparation AS preparation_6 ON result_11.prep_key = preparation_6.prep_key
                               WHERE        (result_11.result_type = 'layer analyte') AND (result_11.result_source_key = q1.result_source_key) AND (preparation_6.prep_code = q1.prep_code) 
                                                         AND (result_11.analyzed_size_frac = q1.analyzed_size_frac) AND (result_11.analyte_key = 88)) AS QG_Glass_Coated_Quartz_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_10.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_10 INNER JOIN
                                                         dbo.preparation AS preparation_5 ON result_10.prep_key = preparation_5.prep_key
                               WHERE        (result_10.result_type = 'layer analyte') AND (result_10.result_source_key = q1.result_source_key) AND (preparation_5.prep_code = q1.prep_code) 
                                                         AND (result_10.analyzed_size_frac = q1.analyzed_size_frac) AND (result_10.analyte_key = 89)) AS GM_Glassy_Materials_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_9.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_9 INNER JOIN
                                                         dbo.preparation AS preparation_4 ON result_9.prep_key = preparation_4.prep_key
                               WHERE        (result_9.result_type = 'layer analyte') AND (result_9.result_source_key = q1.result_source_key) AND (preparation_4.prep_code = q1.prep_code) AND 
                                                         (result_9.analyzed_size_frac = q1.analyzed_size_frac) AND (result_9.analyte_key = 90)) AS OT_Other_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_8.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_8 INNER JOIN
                                                         dbo.preparation AS preparation_3 ON result_8.prep_key = preparation_3.prep_key
                               WHERE        (result_8.result_type = 'layer analyte') AND (result_8.result_source_key = q1.result_source_key) AND (preparation_3.prep_code = q1.prep_code) AND 
                                                         (result_8.analyzed_size_frac = q1.analyzed_size_frac) AND (result_8.analyte_key = 91)) AS PO_Plant_Opal_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_7.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_7 INNER JOIN
                                                         dbo.preparation AS preparation_2 ON result_7.prep_key = preparation_2.prep_key
                               WHERE        (result_7.result_type = 'layer analyte') AND (result_7.result_source_key = q1.result_source_key) AND (preparation_2.prep_code = q1.prep_code) AND 
                                                         (result_7.analyzed_size_frac = q1.analyzed_size_frac) AND (result_7.analyte_key = 92)) AS SS_Sponge_Spicule_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_6.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_6 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_6.prep_key = preparation_1.prep_key
                               WHERE        (result_6.result_type = 'layer analyte') AND (result_6.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND 
                                                         (result_6.analyzed_size_frac = q1.analyzed_size_frac) AND (result_6.analyte_key = 817)) AS AR_Weatherable_Aggregates_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_6.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_6 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_6.prep_key = preparation_1.prep_key
                               WHERE        (result_6.result_type = 'layer analyte') AND (result_6.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND 
                                                         (result_6.analyzed_size_frac = q1.analyzed_size_frac) AND (result_6.analyte_key = 1243)) AS PA_Palagonite_Glass_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_6.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_6 INNER JOIN
                                                         dbo.preparation AS preparation_1 ON result_6.prep_key = preparation_1.prep_key
                               WHERE        (result_6.result_type = 'layer analyte') AND (result_6.result_source_key = q1.result_source_key) AND (preparation_1.prep_code = q1.prep_code) AND 
                                                         (result_6.analyzed_size_frac = q1.analyzed_size_frac) AND (result_6.analyte_key = 1261)) AS PM_Pumice_Glass_Count,

                             (SELECT        TOP (1) ISNULL(dbo.bridge_proced_ss.proced_code, '') AS Expr1
                               FROM            result_light INNER JOIN
                                                         dbo.preparation ON result_light.prep_key = dbo.preparation.prep_key LEFT OUTER JOIN
                                                         dbo.bridge_proced_ss ON result_light.procedure_key = dbo.bridge_proced_ss.procedure_key AND 
                                                         result_light.source_system_key = dbo.bridge_proced_ss.source_system_key
                               WHERE        (result_light.result_type = 'layer analyte') AND (result_light.result_value <> '') AND (NOT (result_light.result_value IS NULL)) AND 
                                                         (result_light.result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (result_light.result_reliability IS NULL OR
                                                         result_light.result_reliability = '0') AND (analyzed_size_frac = q1.analyzed_size_frac)
                                                         AND (result_light.analyte_key IN (93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 
                                                         112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 
                                                         142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 
                                                         172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 
                                                         202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 
                                                         232, 233, 234, 235, 236, 237, 238, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 808, 1259, 1260, 
                                                         1262, 1080, 1081, 1082, 644, 645, 646, 1771))) AS Petro_Count_Method,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 93)) AS AC_Actinolite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 94)) AS FB_Albite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 95)) AS AM_Amphibole_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 96)) AS AE_Anatase_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 97)) AS AN_Andalusite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 98)) AS FA_Andesite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 99)) AS AY_Anhydrite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 100)) AS FN_Anorthite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 101)) AS FH_Anorthoclase_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 102)) AS AH_Anthophyllite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 103)) AS AG_Antigorite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 104)) AS AP_Apatite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 105)) AS AO_Aragonite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 106)) AS AF_Arfvedsonite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 107)) AS AU_Augite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 108)) AS BA_Barite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 109)) AS BG_Basic_Glass_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 110)) AS BY_Beryl_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 111)) AS BT_Biotite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 112)) AS BC_Biotite_Chlorite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 113)) AS BE_Bohmite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 114)) AS BZ_Bronzite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 115)) AS BK_Brookite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 116)) AS BR_Brucite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 117)) AS CA_Calcite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 118)) AS CB_Carbonate_Aggregates_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 119)) AS CT_Cassiterite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 120)) AS CD_Chert_Chalcedony_Jasper_Agate_Onyx_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 121)) AS CL_Chlorite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 122)) AS CM_Chlorite_Mica_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 123)) AS CY_Chrysotile_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 124)) AS QC_Clay_Coated_Quartz_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 125)) AS CH_Cliachite_Bauxite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 126)) AS CZ_Clinozoisite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 127)) AS CC_Coal_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 128)) AS CO_Collophane_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 129)) AS CN_Corundum_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 130)) AS CR_Cristobalite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 131)) AS DI_Diatoms_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 132)) AS DP_Diopside_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 133)) AS DL_Dolomite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 134)) AS DU_Dumortierite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 135)) AS EN_Enstatite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 136)) AS EP_Epidote_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 137)) AS FD_Feldspar_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 138)) AS FZ_Feldspathoids_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 139)) AS FM_Ferromagnesium_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 140)) AS FU_Fluorite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 141)) AS FF_Foraminifera_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 142)) AS GG_Galena_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 143)) AS GN_Garnet_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 144)) AS GI_Gibbsite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 145)) AS GA_Glass_Aggregates_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 146)) AS FG_Glass_Coated_Feldspar_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 147)) AS GC_Glass_Coated_Grain_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 148)) AS HG_Glass_Coated_Hornblende_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 149)) AS OG_Glass_Coated_Opaque_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 150)) AS QG_Glass_Coated_Quartz_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 151)) AS GS_Glass_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 152)) AS GM_Glassy_Matrials_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 153)) AS GL_Glauconite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 154)) AS GO_Glaucophane_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 155)) AS GE_Goethite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 156)) AS GD_Gold_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 157)) AS GY_Gypsum_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 158)) AS KH_Halloysite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 159)) AS HE_Hematite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 160)) AS HN_Hornblende_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 161)) AS HB_Hydrobiotite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 162)) AS ID_Iddingsite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 163)) AS QI_Iron_Oxide_Coated_Quartz_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 164)) AS FE_Iron_Oxides_Geothite_Magnetite_Hematite_Li_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 165)) AS JO_Jarosite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 166)) AS KK_Kaolinite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 167)) AS KY_Kyanite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 168)) AS FL_Labradorite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 169)) AS LA_Lamprobolite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 170)) AS LP_Lepidolite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 171)) AS LO_Lepidomelane_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 172)) AS LU_Leucoxene_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 173)) AS LM_Limonite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 174)) AS LT_Lithiophorite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 175)) AS ME_Magnesite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 176)) AS MG_Magnetite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 177)) AS MR_Marcasite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 178)) AS ML_Melilite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 179)) AS MI_Mica_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 180)) AS FC_Microcline_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 181)) AS MZ_Monazite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 182)) AS MT_Montmorillonite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 183)) AS MS_Muscovite_Petro_Coun,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 184)) AS NE_Nepheline_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 185)) AS NX_Non_Crystalline_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 186)) AS FO_Oligoclase_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 187)) AS OV_Olivine_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 188)) AS OP_Opaques_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 189)) AS FR_Orthoclase_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 190)) AS OR_Other_Resistant_Minerals_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 191)) AS OW_Other_Weatherable_Minerals_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 192)) AS OT_Other_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 193)) AS PK_Perovskite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 194)) AS PL_Phlogophit_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 195)) AS PD_Piemontite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 196)) AS FP_Plagioclase_Feldspar_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 197)) AS PO_Plant_Opal_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 198)) AS PJ_Plumbojarosite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 199)) AS PN_Pollen_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 200)) AS FK_Potassium_Feldspar_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 201)) AS PI_Pyrite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 202)) AS PU_Pyrolusite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 203)) AS PY_Pyrophyllite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 204)) AS PR_Pyroxene_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 205)) AS QZ_Quartz_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 206)) AS RA_Resistant_Aggregates_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 207)) AS MD_Resistant_Mineraloids_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 208)) AS RE_Resistant_Minerals_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 209)) AS RO_Rhodochrosite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 210)) AS RB_Riebeckite_Blue_Amphibole_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 211)) AS RU_Rutile_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 212)) AS FS_Sanidine_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 213)) AS SR_Sericite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 214)) AS SI_Siderite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 215)) AS SA_Siliceous_Aggregates_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 216)) AS SL_Sillimanite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 217)) AS SG_Sphalerite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 218)) AS SP_Sphene_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 219)) AS SN_Spinel_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 220)) AS SS_Sponge_Spicule_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 221)) AS SO_Staurolite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 222)) AS ST_Stilbite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 223)) AS SU_Sulfur_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 224)) AS TA_Talc_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 225)) AS TP_Topaz_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 226)) AS TM_Tourmaline_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 227)) AS TE_Tremolite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 228)) AS VR_Vermiculite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 229)) AS VC_Vermiculite_Chlorite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 230)) AS VH_Vermiculite_Hydrobiotite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 231)) AS VM_Vermiculite_Mica_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 232)) AS VI_Vivianite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 233)) AS WV_Wavellite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 234)) AS AR_Weatherable_Aggregates_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 235)) AS WE_Weatherable_Mineral_petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 236)) AS ZE_Zeolite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 237)) AS ZR_Zircon_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 238)) AS ZO_Zoisite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 463)) AS AI_Aegirine_Augite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 464)) AS AL_Allophane_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 465)) AS CE_Cobaltite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 466)) AS HA_Halite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 467)) AS IL_Illite_Hydromuscovite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 468)) AS LC_Analcime_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 469)) AS LE_Lepidocrocite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 470)) AS LI_Leucite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 471)) AS MC_Montmorillonite_Chlorite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 472)) AS MH_Maghemite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 473)) AS MM_Montmorillonite_Mica_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 474)) AS MV_Montmorillonite_Vermiculite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 475)) AS PA_Palagonite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 476)) AS PG_Palygorskite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 477)) AS SC_Scapolite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 478)) AS SE_Sepiolite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 479)) AS SM_Smectite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 480)) AS TD_Tridymite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 481)) AS TH_Thenardite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 808)) AS HY_Hypersthene_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 1259)) AS HS_Hydroxy_Interlayer_Smectite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light AS result_4
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 1260)) AS HV_Hydroxy_Interlayer_Vermiculite_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 1262)) AS PM_Pumice_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_type = 'layer analyte') AND (result_source_key = q1.result_source_key) AND (dbo.preparation.prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac) AND 
                                                         (analyte_key = 1771)) AS SZ_Serpentine_Petro_Count,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_light.result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            result_light INNER JOIN dbo.preparation ON  result_light.prep_key = dbo.preparation.prep_key 
                               WHERE        (result_light.result_type = 'layer analyte') AND (result_light.result_source_key = q1.result_source_key) AND (preparation.prep_code = q1.prep_code) 
                                                         AND (result_light.analyzed_size_frac = q1.analyzed_size_frac) AND (result_light.analyte_key = 823)) AS Total_Grains_Counted,
                             (SELECT        TOP (1) CAST(dbo.AsymArithRnd(result_value, '3.0') AS decimal(3, 0)) AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code, analyte_size_frac_base as analyzed_size_frac
                                                         FROM            result_light inner join dbo.analyte ON result_light.analyte_key = dbo.analyte.analyte_key 
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (result_light.analyte_key IN (644,645,646,1080,1081,1082))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code, analyte_size_frac_base as analyzed_size_frac
                                                         FROM            result_light inner join dbo.analyte ON result_light.analyte_key = dbo.analyte.analyte_key 
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (result_light.analyte_key IN (1125,1126,1127))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code, analyte_size_frac_base as analyzed_size_frac
                                                         FROM            result_light inner join dbo.analyte ON result_light.analyte_key = dbo.analyte.analyte_key 
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (result_light.analyte_key IN (1437,1438,1439))) AS result_1
                               WHERE        (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac)) AS Resistant_Minerals_Total_Mineral_Soil,
                             (SELECT        TOP (1) result_value AS Expr1
                               FROM            (SELECT        result_value, 'S' AS prep_code, analyte_size_frac_base as analyzed_size_frac
                                                         FROM            result_light inner join dbo.analyte ON result_light.analyte_key = dbo.analyte.analyte_key 
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                   AND (result_light.analyte_key IN (1148,1149,1150))
                                                         UNION
                                                         SELECT        result_value, 'N' AS prep_code, analyte_size_frac_base as analyzed_size_frac
                                                         FROM            result_light inner join dbo.analyte ON result_light.analyte_key = dbo.analyte.analyte_key 
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (result_light.analyte_key IN (1185,1186,1187))
                                                         UNION
                                                         SELECT        result_value, 'GP' AS prep_code, analyte_size_frac_base as analyzed_size_frac
                                                         FROM            result_light inner join dbo.analyte ON result_light.analyte_key = dbo.analyte.analyte_key 
                                                         WHERE        (result_type = 'layer result') AND (result_value <> '') AND (NOT (result_value IS NULL)) AND (result_source_key = q1.result_source_key) 
                                                                                  AND (result_light.analyte_key IN (1434,1435,1436))) AS result_1
                               WHERE        (prep_code = q1.prep_code) AND (analyzed_size_frac = q1.analyzed_size_frac)) AS Glass_Count_Mineral_Interpretation
INTO  
#tempXX

FROM  dbo.layer 
INNER JOIN result_light AS q1 ON dbo.layer.layer_key = q1.result_source_key 





SELECT labsampnum, result_source_key,prep_code,[analyzed_size_frac], [Glass_Count_Method], [BG_Basic_Glass_Count], [DI_Diatoms_Glass_Count], [GA_Glass_Aggregates_Glass_Count], [GS_Glass_Glass_Count], [FG_Glass_Coated_Feldspar_Glass_Count], [GC_Glass_Coated_Grain_Glass_Count], [HG_Glass_Coated_Hornblende_Glass_Count], [OG_Glass_Coated_Opaques_Glass_Count], [QG_Glass_Coated_Quartz_Glass_Count], [GM_Glassy_Materials_Glass_Count], [OT_Other_Glass_Count], [PO_Plant_Opal_Glass_Count], [SS_Sponge_Spicule_Glass_Count], [AR_Weatherable_Aggregates_Glass_Count], [PA_Palagonite_Glass_Count], [PM_Pumice_Glass_Count], [Petro_Count_Method], [AC_Actinolite_Petro_Count], [FB_Albite_Petro_Count], [AM_Amphibole_Petro_Count], [AE_Anatase_Petro_Count], [AN_Andalusite_Petro_Count], [FA_Andesite_Petro_Count], [AY_Anhydrite_Petro_Count], [FN_Anorthite_Petro_Count], [FH_Anorthoclase_Petro_Count], [AH_Anthophyllite_Petro_Count], [AG_Antigorite_Petro_Count], [AP_Apatite_Petro_Count], [AO_Aragonite_Petro_Count], [AF_Arfvedsonite_Petro_Count], [AU_Augite_Petro_Count], [BA_Barite_Petro_Count], [BG_Basic_Glass_Petro_Count], [BY_Beryl_Petro_Count], [BT_Biotite_Petro_Count], [BC_Biotite_Chlorite_Petro_Count], [BE_Bohmite_Petro_Count], [BZ_Bronzite_Petro_Count], [BK_Brookite_Petro_Count], [BR_Brucite_Petro_Count], [CA_Calcite_Petro_Count], [CB_Carbonate_Aggregates_Petro_Count], [CT_Cassiterite_Petro_Count], [CD_Chert_Chalcedony_Jasper_Agate_Onyx_Petro_Count], [CL_Chlorite_Petro_Count], [CM_Chlorite_Mica_Petro_Count], [CY_Chrysotile_Petro_Count], [QC_Clay_Coated_Quartz_Petro_Count], [CH_Cliachite_Bauxite_Petro_Count], [CZ_Clinozoisite_Petro_Count], [CC_Coal_Petro_Count], [CO_Collophane_Petro_Count], [CN_Corundum_Petro_Count], [CR_Cristobalite_Petro_Count], [DI_Diatoms_Petro_Count], [DP_Diopside_Petro_Count], [DL_Dolomite_Petro_Count], [DU_Dumortierite_Petro_Count], [EN_Enstatite_Petro_Count], [EP_Epidote_Petro_Count], [FD_Feldspar_Petro_Count], [FZ_Feldspathoids_Petro_Count], [FM_Ferromagnesium_Petro_Count], [FU_Fluorite_Petro_Count], [FF_Foraminifera_Petro_Count], [GG_Galena_Petro_Count], [GN_Garnet_Petro_Count], [GI_Gibbsite_Petro_Count], [GA_Glass_Aggregates_Petro_Count], [FG_Glass_Coated_Feldspar_Petro_Count], [GC_Glass_Coated_Grain_Petro_Count], [HG_Glass_Coated_Hornblende_Petro_Count], [OG_Glass_Coated_Opaque_Petro_Count], [QG_Glass_Coated_Quartz_Petro_Count], [GS_Glass_Petro_Count], [GM_Glassy_Matrials_Petro_Count], [GL_Glauconite_Petro_Count], [GO_Glaucophane_Petro_Count], [GE_Goethite_Petro_Count], [GD_Gold_Petro_Count], [GY_Gypsum_Petro_Count], [KH_Halloysite_Petro_Count], [HE_Hematite_Petro_Count], [HN_Hornblende_Petro_Count], [HB_Hydrobiotite_Petro_Count], [ID_Iddingsite_Petro_Count], [QI_Iron_Oxide_Coated_Quartz_Petro_Count], [FE_Iron_Oxides_Geothite_Magnetite_Hematite_Li_Petro_Count], [JO_Jarosite_Petro_Count], [KK_Kaolinite_Petro_Count], [KY_Kyanite_Petro_Count], [FL_Labradorite_Petro_Count], [LA_Lamprobolite_Petro_Count], [LP_Lepidolite_Petro_Count], [LO_Lepidomelane_Petro_Count], [LU_Leucoxene_Petro_Count], [LM_Limonite_Petro_Count], [LT_Lithiophorite_Petro_Count], [ME_Magnesite_Petro_Count], [MG_Magnetite_Petro_Count], [MR_Marcasite_Petro_Count], [ML_Melilite_Petro_Count], [MI_Mica_Petro_Count], [FC_Microcline_Petro_Count], [MZ_Monazite_Petro_Count], [MT_Montmorillonite_Petro_Count], [MS_Muscovite_Petro_Coun], [NE_Nepheline_Petro_Count], [NX_Non_Crystalline_Petro_Count], [FO_Oligoclase_Petro_Count], [OV_Olivine_Petro_Count], [OP_Opaques_Petro_Count], [FR_Orthoclase_Petro_Count], [OR_Other_Resistant_Minerals_Petro_Count], [OW_Other_Weatherable_Minerals_Petro_Count], [OT_Other_Petro_Count], [PK_Perovskite_Petro_Count], [PL_Phlogophit_Petro_Count], [PD_Piemontite_Petro_Count], [FP_Plagioclase_Feldspar_Petro_Count], [PO_Plant_Opal_Petro_Count], [PJ_Plumbojarosite_Petro_Count], [PN_Pollen_Petro_Count], [FK_Potassium_Feldspar_Petro_Count], [PI_Pyrite_Petro_Count], [PU_Pyrolusite_Petro_Count], [PY_Pyrophyllite_Petro_Count], [PR_Pyroxene_Petro_Count], [QZ_Quartz_Petro_Count], [RA_Resistant_Aggregates_Petro_Count], [MD_Resistant_Mineraloids_Petro_Count], [RE_Resistant_Minerals_Petro_Count], [RO_Rhodochrosite_Petro_Count], [RB_Riebeckite_Blue_Amphibole_Petro_Count], [RU_Rutile_Petro_Count], [FS_Sanidine_Petro_Count], [SR_Sericite_Petro_Count], [SI_Siderite_Petro_Count], [SA_Siliceous_Aggregates_Petro_Count], [SL_Sillimanite_Petro_Count], [SG_Sphalerite_Petro_Count], [SP_Sphene_Petro_Count], [SN_Spinel_Petro_Count], [SS_Sponge_Spicule_Petro_Count], [SO_Staurolite_Petro_Count], [ST_Stilbite_Petro_Count], [SU_Sulfur_Petro_Count], [TA_Talc_Petro_Count], [TP_Topaz_Petro_Count], [TM_Tourmaline_Petro_Count], [TE_Tremolite_Petro_Count], [VR_Vermiculite_Petro_Count], [VC_Vermiculite_Chlorite_Petro_Count], [VH_Vermiculite_Hydrobiotite_Petro_Count], [VM_Vermiculite_Mica_Petro_Count], [VI_Vivianite_Petro_Count], [WV_Wavellite_Petro_Count], [AR_Weatherable_Aggregates_Petro_Count], [WE_Weatherable_Mineral_petro_Count], [ZE_Zeolite_Petro_Count], [ZR_Zircon_Petro_Count], [ZO_Zoisite_Petro_Count], [AI_Aegirine_Augite_Petro_Count], [AL_Allophane_Petro_Count], [CE_Cobaltite_Petro_Count], [HA_Halite_Petro_Count], [IL_Illite_Hydromuscovite_Petro_Count], [LC_Analcime_Petro_Count], [LE_Lepidocrocite_Petro_Count], [LI_Leucite_Petro_Count], [MC_Montmorillonite_Chlorite_Petro_Count], [MH_Maghemite_Petro_Count], [MM_Montmorillonite_Mica_Petro_Count], [MV_Montmorillonite_Vermiculite_Petro_Count], [PA_Palagonite_Petro_Count], [PG_Palygorskite_Petro_Count], [SC_Scapolite_Petro_Count], [SE_Sepiolite_Petro_Count], [SM_Smectite_Petro_Count], [TD_Tridymite_Petro_Count], [TH_Thenardite_Petro_Count], [HY_Hypersthene_Petro_Count], [HS_Hydroxy_Interlayer_Smectite_Petro_Count], [HV_Hydroxy_Interlayer_Vermiculite_Petro_Count], [PM_Pumice_Petro_Count], [SZ_Serpentine_Petro_Count], [Total_Grains_Counted], [Resistant_Minerals_Total_Mineral_Soil], [Glass_Count_Mineral_Interpretation]	

INTO SDA_Mineralogy_Glass_Count
FROM #tempXX 
GROUP BY labsampnum, result_source_key,prep_code,[analyzed_size_frac], [Glass_Count_Method], [BG_Basic_Glass_Count], [DI_Diatoms_Glass_Count], [GA_Glass_Aggregates_Glass_Count], [GS_Glass_Glass_Count], [FG_Glass_Coated_Feldspar_Glass_Count], [GC_Glass_Coated_Grain_Glass_Count], [HG_Glass_Coated_Hornblende_Glass_Count], [OG_Glass_Coated_Opaques_Glass_Count], [QG_Glass_Coated_Quartz_Glass_Count], [GM_Glassy_Materials_Glass_Count], [OT_Other_Glass_Count], [PO_Plant_Opal_Glass_Count], [SS_Sponge_Spicule_Glass_Count], [AR_Weatherable_Aggregates_Glass_Count], [PA_Palagonite_Glass_Count], [PM_Pumice_Glass_Count], [Petro_Count_Method], [AC_Actinolite_Petro_Count], [FB_Albite_Petro_Count], [AM_Amphibole_Petro_Count], [AE_Anatase_Petro_Count], [AN_Andalusite_Petro_Count], [FA_Andesite_Petro_Count], [AY_Anhydrite_Petro_Count], [FN_Anorthite_Petro_Count], [FH_Anorthoclase_Petro_Count], [AH_Anthophyllite_Petro_Count], [AG_Antigorite_Petro_Count], [AP_Apatite_Petro_Count], [AO_Aragonite_Petro_Count], [AF_Arfvedsonite_Petro_Count], [AU_Augite_Petro_Count], [BA_Barite_Petro_Count], [BG_Basic_Glass_Petro_Count], [BY_Beryl_Petro_Count], [BT_Biotite_Petro_Count], [BC_Biotite_Chlorite_Petro_Count], [BE_Bohmite_Petro_Count], [BZ_Bronzite_Petro_Count], [BK_Brookite_Petro_Count], [BR_Brucite_Petro_Count], [CA_Calcite_Petro_Count], [CB_Carbonate_Aggregates_Petro_Count], [CT_Cassiterite_Petro_Count], [CD_Chert_Chalcedony_Jasper_Agate_Onyx_Petro_Count], [CL_Chlorite_Petro_Count], [CM_Chlorite_Mica_Petro_Count], [CY_Chrysotile_Petro_Count], [QC_Clay_Coated_Quartz_Petro_Count], [CH_Cliachite_Bauxite_Petro_Count], [CZ_Clinozoisite_Petro_Count], [CC_Coal_Petro_Count], [CO_Collophane_Petro_Count], [CN_Corundum_Petro_Count], [CR_Cristobalite_Petro_Count], [DI_Diatoms_Petro_Count], [DP_Diopside_Petro_Count], [DL_Dolomite_Petro_Count], [DU_Dumortierite_Petro_Count], [EN_Enstatite_Petro_Count], [EP_Epidote_Petro_Count], [FD_Feldspar_Petro_Count], [FZ_Feldspathoids_Petro_Count], [FM_Ferromagnesium_Petro_Count], [FU_Fluorite_Petro_Count], [FF_Foraminifera_Petro_Count], [GG_Galena_Petro_Count], [GN_Garnet_Petro_Count], [GI_Gibbsite_Petro_Count], [GA_Glass_Aggregates_Petro_Count], [FG_Glass_Coated_Feldspar_Petro_Count], [GC_Glass_Coated_Grain_Petro_Count], [HG_Glass_Coated_Hornblende_Petro_Count], [OG_Glass_Coated_Opaque_Petro_Count], [QG_Glass_Coated_Quartz_Petro_Count], [GS_Glass_Petro_Count], [GM_Glassy_Matrials_Petro_Count], [GL_Glauconite_Petro_Count], [GO_Glaucophane_Petro_Count], [GE_Goethite_Petro_Count], [GD_Gold_Petro_Count], [GY_Gypsum_Petro_Count], [KH_Halloysite_Petro_Count], [HE_Hematite_Petro_Count], [HN_Hornblende_Petro_Count], [HB_Hydrobiotite_Petro_Count], [ID_Iddingsite_Petro_Count], [QI_Iron_Oxide_Coated_Quartz_Petro_Count], [FE_Iron_Oxides_Geothite_Magnetite_Hematite_Li_Petro_Count], [JO_Jarosite_Petro_Count], [KK_Kaolinite_Petro_Count], [KY_Kyanite_Petro_Count], [FL_Labradorite_Petro_Count], [LA_Lamprobolite_Petro_Count], [LP_Lepidolite_Petro_Count], [LO_Lepidomelane_Petro_Count], [LU_Leucoxene_Petro_Count], [LM_Limonite_Petro_Count], [LT_Lithiophorite_Petro_Count], [ME_Magnesite_Petro_Count], [MG_Magnetite_Petro_Count], [MR_Marcasite_Petro_Count], [ML_Melilite_Petro_Count], [MI_Mica_Petro_Count], [FC_Microcline_Petro_Count], [MZ_Monazite_Petro_Count], [MT_Montmorillonite_Petro_Count], [MS_Muscovite_Petro_Coun], [NE_Nepheline_Petro_Count], [NX_Non_Crystalline_Petro_Count], [FO_Oligoclase_Petro_Count], [OV_Olivine_Petro_Count], [OP_Opaques_Petro_Count], [FR_Orthoclase_Petro_Count], [OR_Other_Resistant_Minerals_Petro_Count], [OW_Other_Weatherable_Minerals_Petro_Count], [OT_Other_Petro_Count], [PK_Perovskite_Petro_Count], [PL_Phlogophit_Petro_Count], [PD_Piemontite_Petro_Count], [FP_Plagioclase_Feldspar_Petro_Count], [PO_Plant_Opal_Petro_Count], [PJ_Plumbojarosite_Petro_Count], [PN_Pollen_Petro_Count], [FK_Potassium_Feldspar_Petro_Count], [PI_Pyrite_Petro_Count], [PU_Pyrolusite_Petro_Count], [PY_Pyrophyllite_Petro_Count], [PR_Pyroxene_Petro_Count], [QZ_Quartz_Petro_Count], [RA_Resistant_Aggregates_Petro_Count], [MD_Resistant_Mineraloids_Petro_Count], [RE_Resistant_Minerals_Petro_Count], [RO_Rhodochrosite_Petro_Count], [RB_Riebeckite_Blue_Amphibole_Petro_Count], [RU_Rutile_Petro_Count], [FS_Sanidine_Petro_Count], [SR_Sericite_Petro_Count], [SI_Siderite_Petro_Count], [SA_Siliceous_Aggregates_Petro_Count], [SL_Sillimanite_Petro_Count], [SG_Sphalerite_Petro_Count], [SP_Sphene_Petro_Count], [SN_Spinel_Petro_Count], [SS_Sponge_Spicule_Petro_Count], [SO_Staurolite_Petro_Count], [ST_Stilbite_Petro_Count], [SU_Sulfur_Petro_Count], [TA_Talc_Petro_Count], [TP_Topaz_Petro_Count], [TM_Tourmaline_Petro_Count], [TE_Tremolite_Petro_Count], [VR_Vermiculite_Petro_Count], [VC_Vermiculite_Chlorite_Petro_Count], [VH_Vermiculite_Hydrobiotite_Petro_Count], [VM_Vermiculite_Mica_Petro_Count], [VI_Vivianite_Petro_Count], [WV_Wavellite_Petro_Count], [AR_Weatherable_Aggregates_Petro_Count], [WE_Weatherable_Mineral_petro_Count], [ZE_Zeolite_Petro_Count], [ZR_Zircon_Petro_Count], [ZO_Zoisite_Petro_Count], [AI_Aegirine_Augite_Petro_Count], [AL_Allophane_Petro_Count], [CE_Cobaltite_Petro_Count], [HA_Halite_Petro_Count], [IL_Illite_Hydromuscovite_Petro_Count], [LC_Analcime_Petro_Count], [LE_Lepidocrocite_Petro_Count], [LI_Leucite_Petro_Count], [MC_Montmorillonite_Chlorite_Petro_Count], [MH_Maghemite_Petro_Count], [MM_Montmorillonite_Mica_Petro_Count], [MV_Montmorillonite_Vermiculite_Petro_Count], [PA_Palagonite_Petro_Count], [PG_Palygorskite_Petro_Count], [SC_Scapolite_Petro_Count], [SE_Sepiolite_Petro_Count], [SM_Smectite_Petro_Count], [TD_Tridymite_Petro_Count], [TH_Thenardite_Petro_Count], [HY_Hypersthene_Petro_Count], [HS_Hydroxy_Interlayer_Smectite_Petro_Count], [HV_Hydroxy_Interlayer_Vermiculite_Petro_Count], [PM_Pumice_Petro_Count], [SZ_Serpentine_Petro_Count], [Total_Grains_Counted], [Resistant_Minerals_Total_Mineral_Soil], [Glass_Count_Mineral_Interpretation]	

GO
SET STATISTICS IO OFF
GO




	CREATE INDEX  SDA_Mineralogy_Glass_Count_idx1c ON  SDA_Mineralogy_Glass_Count (labsampnum, result_source_key) INCLUDE (prep_code)
	CREATE INDEX  SDA_Mineralogy_Glass_Count_result_source_key_idx2 ON  SDA_Mineralogy_Glass_Count (result_source_key )
	CREATE INDEX SDA_Mineralogy_Glass_Count_prep_code_idx5 ON  SDA_Mineralogy_Glass_Count (prep_code)