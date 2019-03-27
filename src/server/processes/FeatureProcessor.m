classdef FeatureProcessor
    methods (Static, Access = public)
        function output = execute(constellations, params)
            algorithm = DynamicLoader.resolve(params.algorithm.name);

            Logger.info('... processing features');
            nConstellations = length(constellations);
            for index = 1 : nConstellations
                PresentationTools.loader(index, nConstellations);
                constellation = Tools.struct2class('Constellation', constellations(index));
                output(index).name = constellation.name;
                output(index).features = algorithm.execute(constellation, params.algorithm.params);
            end
        end
    end
end