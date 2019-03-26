classdef FileTools
    methods (Static)
        function save(name, data)
            Logger.info(['saving into file: ', name]);
            save(name, 'data');
        end

        function data = load(name)     
            Logger.info(['loading file: ', name]);
            data = load(name).data;
        end
    end
end