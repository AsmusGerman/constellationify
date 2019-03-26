classdef Bootstrapper
    methods (Static)
        %returns the bootstrapped instance of the application
        function application = boot()
            clc;
            clear;         
            warning('off','all');

            %loads project dirs
            addpath('algorithms');
            addpath('classes');
            addpath('tools');
            addpath('resources');

            %loads vendor libraries
            addpath('vendors/jsonlab');
            addpath('vendors/struct2table');

            %loads the messages
            application.messages = loadjson('messages.json');

            %loads the configuration from config.json
            application.configuration = loadjson('config.json');

            if(application.configuration.octave)
                pkg load image;
            end
        end
    end
end