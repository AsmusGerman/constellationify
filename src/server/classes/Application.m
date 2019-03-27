classdef Application < Scoped
    methods (Static, Access = public)
        function output = start(context)
            %set actual context as application scope
            Application.scope(context);

            PresentationTools.signature(Application.scope.configuration.presentation);

            constellations = Controller.import();

            if isempty(constellations)
                constellations = Controller.reconstruct();
                output = Controller.process(constellations);
            end
            
            output = constellations;
            Logger.success(context.messages.success.ready);
        end

        %{
            function view(constellation)
                imshow(constellation.image);
        
                %get every star center
                [centers, 4] = constellation.stars.center;

                %every star with each radius
                viscircles(centers, 4,'EdgeColor','b');
            end
        %}

        function output = compare(file, constellations)
            %create the new constellation
            target = Controller.create(file);
            nConstellations = length(constellations)
            for index = 1 : nConstellations
                output(index) = target.distance(constellations(index));
            end 

            cells = struct2cell(output); %converts struct to cell matrix
            sortvals = cells(2,1,:); % gets the values of just the first field
            mat = cell2mat(sortvals); % converts values to a matrix
            mat = squeeze(mat); %removes the empty dimensions for a single vector
            [sorted,ix] = sort(mat); %sorts the vector of values
            output = output(ix); %rearranges the original array

            struct2table(output);
        end
    end
end