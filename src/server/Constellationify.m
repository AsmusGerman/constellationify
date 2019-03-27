classdef Constellationify
    methods (Access = public)
        function  output = Constellationify(constellation)
            context = Constellationify.boot();
            output = Application.start(context);
            if nargin == 1
                output = Application.compare(constellation, output);
            end
        end
    end

    methods (Static, Access = private)
        function context = boot()
            clc; clear;
            warning('off','all');

            %loads project directories (use '/' at the end)
            Constellationify.addSubFolders('./');
            Constellationify.addSubFolders('vendors/');

            context.configuration = loadjson('config.json');
            context.messages = loadjson('messages.json');

            if(context.configuration.octave)
                pkg load image;
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