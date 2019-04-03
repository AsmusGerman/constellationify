-- delete if table exists
DROP TABLE IF EXISTS constellation;
-- create if table doesn't exists
CREATE TABLE IF NOT EXISTS constellation(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    stars POINT [],
    features float []
);



CREATE OR REPLACE FUNCTION distanciaEuclidiana(vector1 float[], vector2 float[])
    RETURNS float AS
$$
DECLARE
  acumuladorDeDiferencias float;
  dimensionDelVector1 INTEGER;
  dimensionDelVector2 INTEGER;
BEGIN
  acumuladorDeDiferencias := 0;
  dimensionDelVector1 = array_length(vector1,1);
  dimensionDelVector2 = array_length(vector2,1);
  
  IF (dimensionDelVector1 > 0 AND dimensionDelVector1 = dimensionDelVector2) THEN
	  FOR i IN 1..dimensionDelVector1 LOOP
		acumuladorDeDiferencias := acumuladorDeDiferencias + pow((vector1[i] - vector2[i]),2);
	  END LOOP;
	  RETURN sqrt(acumuladorDeDiferencias);
  ELSE
	  RETURN (-1);
  END IF; 
END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION constelacionVectorCaracteristico(stars point[], features float[])
    RETURNS float[] AS
$$
DECLARE vectorCaracteristico real[];
BEGIN
  --array_cat()
  RETURN array_prepend(CAST(POW(CAST(array_length(stars,1) AS float),1.5) AS float), features);
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION obtenerNConstelacionesMasCercanas(starsBusqueda point[], featuresBusqueda float[], knn integer)
    RETURNS TABLE(idConst integer, dist float) AS
$$
DECLARE
constelacionBusquedaVectorCaracteristico float[];
BEGIN	
	constelacionBusquedaVectorCaracteristico := constelacionVectorCaracteristico(starsBusqueda, featuresBusqueda);
	RETURN QUERY SELECT c.id, distanciaEuclidiana(constelacionBusquedaVectorCaracteristico,constelacionVectorCaracteristico(c.stars,c.features)) as distancia FROM Constellation as c ORDER BY distancia ASC LIMIT knn;
END;
$$
LANGUAGE plpgsql;
