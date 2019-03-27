classdef Application < Scoped
    methods (Static, Access = public)
        function output = start(context)
            %set actual context as application scope
            Application.scope(context);

            PresentationTools.present();

            [constellations, imported] = Controller.import();

            if ~imported
               constellations = Controller.process(constellations);
            end

            output.(Application.scope.configuration.algorithm.name) = constellations;

            Logger.success(context.messages.success.ready);
        end

        function output = compare(file, constellations)
            %create the new constellation
            target = Controller.create(file);
            nConstellations = length(constellations);
            for index = 1 : nConstellations
                output(index) = target.distance(constellations(index));
            end 
            struct2table(output);
        end
    end
end