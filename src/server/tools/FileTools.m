classdef FileTools
    methods (Static)
        function save(name, data)
            Logger.info(['saving into file: ', name, '.mat']);     
            save('-mat',strcat(name,'.mat'), 'data');
        end

        function data = load(name)     
            Logger.info(['loading file: ', name, '.mat']);
            data = load('-mat',strcat(name,'.mat')); 
        end
    end
end