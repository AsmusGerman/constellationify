classdef FileTools
    methods (Static)
        function export(name, data)
            Logger.info(['saving into file: ', name]);
            save(name, 'data');
        end

        function data = import(name)     
            Logger.info(['loading file: ', name]);
            data = load(name,'data');
        end
    end
end