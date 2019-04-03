classdef Constellationify
    properties
        application;
    end
    methods (Access = public)
        function instance = Constellationify(path)
            context = Constellationify.boot();
            instance.application = Application(context);
            instance.application.start();
            if nargin == 1
                instance.application.compare(path);
            end
        end
    end

    methods (Static, Access = private)
        function context = boot()
            try
                clc; clear;
                warning('off','all');
                format long;
    
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