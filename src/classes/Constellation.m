classdef Constellation < Scoped
    properties
        image;
        stars;
        features;
        file;
    end
   
    methods (Access = public)
        % constructor
        % creates a new constellation intance
        % by passing the file as argument
        function instance = Constellation(file)
            if  nargin > 0
                instance.file = file;
                instance.image = imread(instance.filename);
            end
        end

        function value = filename(instance)
            value = strcat(instance.file.folder, '\', instance.file.name);
        end

        function value = name(instance)
            value = instance.file.name(1:end-4);
        end

        function object = distance(instance, constellation)
            object.name = constellation.name;
            object.distance = norm(constellation.features - instance.features);
        end
    end
end