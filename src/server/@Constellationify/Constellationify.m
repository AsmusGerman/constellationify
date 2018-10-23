classdef Constellationify
    
    properties(Constant)
        set = './assets/images/';
        extension = 'png';
    end

    methods(Static)
        function constellations = init()
            %read all the image names from the directory set
            files = Constellationify.read(Constellationify.set, Constellationify.extension);

            constellations = Collection();

            nFiles = length(files);
            %create the constellations
            for i = 1 : nFiles
                % get the file name and full name
                [name, url] = Constellationify.fileinfo(files(i).value);

                constellation = Constellation(url, name);
                constellations = constellations.add(constellation);
            end
        end

        function files = read(directory, extension)
            files = Collection();
            
            reads = ls(strcat(directory,'/*.',extension));
            reads = cellstr(reads);
            nReads = length(reads);

            for i = 1 : nReads
                files = files.add(reads(i));
            end
        end

        function [name, url] = fileinfo(file)
            name = strsplit(char(file),'.');
            name = name(1); %file name without extension

            url = strcat(Constellationify.set, file); %full name
        end
    end
end

