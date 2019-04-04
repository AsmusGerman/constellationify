classdef Application < Scoped
    properties
        controller;
    end
    methods (Access = public)
        function instance = Application(context)
            Scoped.scope(context);
            PresentationTools.signature(Scoped.scope.configuration.presentation);   
            instance.controller = Controller();
        end

        function output = start(instance)
            output = [];
            output = instance.controller.import();

            if isempty(output)
                constellations = instance.controller.reconstruct();
                instance.controller.process(constellations);
                output = instance.controller.import();
            end
           
            Logger.success(Scoped.scope.messages.success.ready);
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

        function output = compare(instance, path)
            try
                %create the new constellation
                file = dir(path);
                constellation = instance.controller.create(file);
                output = instance.controller.compare(constellation, 5);
                for index = 1 : length(output)
                    disp(index)
                    output(index).name
                    output(index).id
                    output(index).distance
                    disp('---')
                end
%{

                cells = struct2cell(output); %converts struct to cell matrix
                sortvals = cells(2,1,:); % gets the values of just the first field
                mat = cell2mat(sortvals); % converts values to a matrix
                mat = squeeze(mat); %removes the empty dimensions for a single vector
                [sorted,ix] = sort(mat); %sorts the vector of values
                output = output(ix); %rearranges the original array

                struct2table(output);
                
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
%}

            catch exception
                Logger.error(['oops', exception.message]);
            end
        end
    end
end