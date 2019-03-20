classdef FileTools
    methods (Static)
        function save(name, data)
            name = strcat(name,'.mat');
            save(name,'data');
        end

        function data = load(name)
            name = strcat(name,'.mat');
            data = importdata(name);
        end
    end
end