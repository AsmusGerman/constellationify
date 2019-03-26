classdef Constellationify < Scoped
    properties
        data;
    end
    methods (Access = private)
        function instance = Constellationify()
            Constellationify.scope(Bootstrapper.boot());
            
            PresentationTools.present();

            [constellations, imported] = ConstellationController.load();

            if ~imported
               constellations = ConstellationController.process(constellations);
            end

            instance.data.(Constellationify.scope.configuration.algorithm.name) = constellations;

            Logger.success('Done!')
        end
    end

    methods (Static)
        function instance = instance()
            persistent singleton
            if isempty(singleton)
                singleton = Constellationify();
            end
            instance = singleton;            
        end
    end

    methods (Access = public)
        function output = compare(instance, file)
            %create the new constellation
            target = ConstellationController.create(file);

            % load the constellations from the 'results' folder
            constellations = instance.data.(Constellationify.scope.configuration.algorithm.name);
            nConstellations = length(constellations);
            for index = 1 : nConstellations
                constellation = constellations(index);
                output(index) = struct('name', constellation.name, 'distance', norm(constellation.features - target.features));
            end
            struct2table(output);
        end
    end
end