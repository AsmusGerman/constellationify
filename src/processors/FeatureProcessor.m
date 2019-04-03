classdef FeatureProcessor
    methods (Static, Access = public)
        function features = execute(constellation, params)
            algorithm = Loader.resolve(params.algorithm.name);
            features = algorithm.execute(constellation, params.algorithm.params);
        end
    end
end