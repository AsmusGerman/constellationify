classdef MatFileController
    
    properties(Constant)
        set = './assets/images/';
        extension = 'png';
    end

    methods(Static)       
        function save(name, data)
            name = strcat(name,'.mat');
            save(name,'data');
        end

        function data = import(name)
            name = strcat(name,'.mat');
            data = importdata(name);
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
    end
end

