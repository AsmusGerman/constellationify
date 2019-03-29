classdef Database
    methods (Static)
        function test(user, password)                
            % ----- PostgreSQL with JDBC  ----
            % Add jar file to classpath
            javaaddpath('postgresql-42.2.5.jar');

            % Username and password you chose when installing postgres
            props=javaObject('java.util.Properties');
            props.setProperty("user", user);
            props.setProperty("password", password);

            % Create database connection
            driver = javaObject('org.postgresql.Driver');
            url = 'jdbc:postgresql://localhost:5432/Constellationify';
            conn = driver.connect(url, props);

            % Test query
            sql = 'SELECT a.x FROM generate_series(1, 1000) as a(x)'
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            % Retrieve results into  array
            while rs.next()
                rs.getString(1)
            end
        end
    end
end