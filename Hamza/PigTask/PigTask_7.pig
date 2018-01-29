pig -useHCatalog
	
pig -useHCatalog hcatalogtest.pig

A = LOAD 'kalyan.rickfactor' USING org.apache.hive.hcatalog.pig.HCatLoader();

DESCRIBE A;
 
B = FILTER A BY (int)$16>1000 AND ((int)$18<40 AND (int)$18>50);
 
STORE B INTO '/user/orienit/pig/RiskFactorFilter';

