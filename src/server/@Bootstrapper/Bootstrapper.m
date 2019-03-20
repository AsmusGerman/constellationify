classdef bootstrapper
    methods (static)
        %returns the bootstrapped instance of the application
        function application = boot(application)
                        
            warning('off','all');

            %loads project dirs
            addpath('controllers');
            addpath('algorithms');
            
            %loads vendor libraries
            addpath('vendor\jsonlab');

            %loads the messages
            application.messages = loadjson('resources\messages.json');

            %loads the configuration from config.json
            application.configuration = loadjson('resources\config.json');
        end
    end
end