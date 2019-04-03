function output = insert(connection, constellation)
    sql = fileread('scripts\insert.sql');
    statement = connection.prepareStatement(sql);

    statement.setString(1, constellation.name);
    
    nStars = length(constellation.stars);
    stars = javaArray("org.postgresql.geometric.PGpoint", nStars);
    for index = 1:nStars        
        stars(index) = javaObject("org.postgresql.geometric.PGpoint", constellation.stars(index).x, constellation.stars(index).y);
    end
    statement.setArray(2, connection.createArrayOf('point', stars));
    
    nFeatures = length(constellation.features);

    features = javaArray("java.lang.Float", nFeatures);
    for index = 1:nFeatures
        features(index) = javaObject("java.lang.Float", constellation.features(index));
    end 
    statement.setArray(3, connection.createArrayOf('float', constellation.features));

    output = statement.executeUpdate();
end