classdef AlgorithmController
    methods (Static)
        function algorithm = load(name)
            algorithm = eval(name);
        end
    end
end