function output = obtenerNConstelacionesMasCercanas(connection, constellation, neighbours)
    output = [];
    sql = fileread('scripts\obtenerNConstelacionesMasCercanas.sql');
    statement = connection.prepareStatement(sql);


    nStars = length(constellation.stars);
    stars = javaArray("org.postgresql.geometric.PGpoint", nStars);
    for index = 1:nStars
        stars(index) = javaObject("org.postgresql.geometric.PGpoint", constellation.stars(index).x, constellation.stars(index).y);
    end
    statement.setArray(1, connection.createArrayOf('point', stars));
    
    nFeatures = length(constellation.features);

    features = javaArray("java.lang.Float", nFeatures);
    for index = 1:nFeatures
        features(index) = javaObject("java.lang.Float", constellation.features(index));
    end 
    statement.setArray(2, connection.createArrayOf('float', constellation.features));

    statement.setInt(3, neighbours);

    result = statement.executeQuery();
    while result.next()
        k.id = result.getInt(1);
        k.distance = result.getFloat(2);
        output = [output, k];
    end
end