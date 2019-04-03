classdef DBContext
    properties (Access = private)
        user;
        password;
        url
    end
    methods (Access = public)
        function instance = DBContext()
            addpath('commands');
            addpath('scripts');
            % Add jar file to classpath
            javaaddpath('database/postgresql-42.2.5.jar');
            instance.user = input('postgress username: ', "s");
            instance.password = input('postgress password: ', "s");
            instance.url = 'jdbc:postgresql://localhost:5432/Constellationify';
        end

        function insert(instance, command, entity)
            connection = DBContext.connect(instance.url, instance.user, instance.password);
            feval(command, connection, entity);
            connection.close();
        end

        function output = get(instance, command)
            connection = DBContext.connect(instance.url, instance.user, instance.password);
            output = feval(command, connection);
            connection.close();
        end

        function output = execute(instance, command, entity, neighbours)
            connection = DBContext.connect(instance.url, instance.user, instance.password);
            output = feval(command, connection, entity, neighbours);
            connection.close();
        end

        function connection = connection(instance)
            try
                credentials = javaObject('java.util.Properties');
                credentials.setProperty("user", instance.user);
                credentials.setProperty("password", instance.password);
                
                driver = javaObject('org.postgresql.Driver');
                
                connection = driver.connect(instance.url, credentials);
            catch exception
                disp(exception.message);
            end
        end
    end
    
    methods (Access = private)
        function code = validate(instance)
            code = 0;
        
            sql = fileread('scripts\validate_db_state.sql');
            connection = DBContext.connect(instance.url, instance.username, instance.password);
            statement = connection.prepareStatement(sql);
            result = statement.executeQuery();
            if(result.next())
                code = result.getInt(1);
            end

            DBContext.handleCode(code);

            result.close();
            statement.close();
            connection.close();
        end

    end

    methods (Static, Access = private)
        function connection = connect(url, user, password)
            try
                credentials = javaObject('java.util.Properties');
                credentials.setProperty("user", user);
                credentials.setProperty("password", password);
                
                driver = javaObject('org.postgresql.Driver');
                
                connection = driver.connect(url, credentials);
            catch exception
                disp(exception.message);
            end
        end

        function result = handleCode(code)
            switch code
                case 0
                    disp('everything OK');
                case 1
                    disp('database has not the table "constellation"')
                otherwise
                    disp(['db error, no handler for code: ', code]);
            end
        end
    end
end