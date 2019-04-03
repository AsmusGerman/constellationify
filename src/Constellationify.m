classdef Constellationify
    properties
        application;
    end
    methods (Access = public)
        function output = Constellationify(path)
            try
                output = [];
                context = Constellationify.boot();
                instance.application = Application(context);
                instance.application.start();
                if nargin == 1
                    output.data = instance.application.compare(path);
                end
            catch exception
                disp(['error: ', exception.message])
            end
        end
    end

    methods (Static, Access = private)
        function context = boot()
            try
                clc; clear;
                warning('off','all');
                format short;
    
                %loads project directories (use '/' at the end)
                Constellationify.addSubFolders('./');
                Constellationify.addSubFolders('vendors/');
                Constellationify.addSubFolders('database/');
    
                context.configuration = loadjson('config.json');
                context.messages = loadjson('messages.json');
    
                if(exist('resources/images') == 0)
                    disp('unzipping resources');
                    unzip('resources.zip', 'resources/');
                end
    
                if(exist(context.configuration.results) == 0)
                    mkdir(context.configuration.results);
                    disp('unzipping results');
                    unzip('results.zip',context.configuration.results);
                end
                
                if(context.configuration.octave)
                    pkg load image;
                end
            catch exception
                disp(exception);
            end
        end
        
        function addSubFolders(directory)
            %search for dirs but ./ ../
            dirs = dir([directory, '*']);
            dirs = dirs([dirs.isdir] > 0);
            for index = 1:length(dirs)
                folder = [directory, dirs(index).name];
                disp(['loading: ', folder]);
                addpath(folder);
            end
        end
    end
end