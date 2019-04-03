    function output = getAll(connection)
    try
        output = [];
        sql = fileread('scripts\getAll.sql');
        statement = connection.prepareStatement(sql);
        result = statement.executeQuery();
        %for each row
        while result.next()
            constellation.id = result.getInt('Id');
            constellation.name = result.getString('name');
            stars = result.getArray('stars').getArray();
            for index = 1:length(stars)
                constellation.stars(index) = Tools.cast('Star', stars(index));
            end
            features = result.getArray('features').getArray();
            for index = 1:length(features)
                constellation.features(index) = int32(features(index));  
            end
            output = [output, constellation];
        end
    catch exception
        disp(exception.message)
    end    
end
