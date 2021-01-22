USE ncsslabdata
GO

SET QUOTED_IDENTIFIER on

------ remove data 
TRUNCATE TABLE lab_webmap

------ add data
INSERT INTO lab_webmap

 SELECT 
CASE WHEN [corr_name] IS NULL THEN   UPPER(LEFT([samp_name],1))+LOWER(SUBSTRING([samp_name],2,LEN([samp_name]))) ELSE  UPPER(LEFT([corr_name],1))+LOWER(SUBSTRING([corr_name],2,LEN([corr_name]))) END AS [Series],
[upedonid] AS [User_Pedon_ID], 
 [pedon_key] AS [Pedon_Key],
 [pedoniid]  AS [peiid],
CASE WHEN [corr_classification_name] IS NULL THEN [samp_classification_name] ELSE [corr_classification_name] END AS [Soil_Classification],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=1&submit1=Get+Report') AS [Primary_Lab_Report],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=3&submit1=Get+Report') AS [Taxonomy_Report],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=2&submit1=Get+Report') AS [Supplementary_Lab_Report],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=6&submit1=Get+Report') AS [Water_Retention_Report],
CONCAT ('https://ncsslabdatamart.sc.egov.usda.gov/rptExecute.aspx?p=', [pedon_key] , '&r=7&submit1=Get+Report') AS [Correlation_Report],
CONCAT ('https://nasis.sc.egov.usda.gov/NasisReportsWebSite/limsreport.aspx?report_name=Pedon_Site_Description_usepedonid&pedon_id=', [upedonid] ) AS [Pedon_Description_Report],
CONCAT ('https://nasis.sc.egov.usda.gov/NasisReportsWebSite/limsreport.aspx?report_name=WEB-profiles-by-PEIID&pedon_peiid=', [pedoniid] ) AS [Soil_Profile],
CONCAT ('https://casoilresource.lawr.ucdavis.edu/gmap/?loc=', [latitude_decimal_degrees], ',' , [longitude_decimal_degrees]  ) AS [Soil_Web],
[latitude_decimal_degrees] AS lat,
[longitude_decimal_degrees] AS long,
geometry ::Point([longitude_decimal_degrees], [latitude_decimal_degrees] , 4326) AS latlong
  FROM [ncsslabdata].[dbo].[combine_nasis_ncss] WHERE CASE WHEN  [latitude_decimal_degrees] IS NULL THEN 2 WHEN [longitude_decimal_degrees] IS NULL THEN 2 ELSE 1 END = 1


 GO
