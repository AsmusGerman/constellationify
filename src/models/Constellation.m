classdef Constellation < Scoped
    properties
        id;
        name;
        stars;
        features;
        image;
    end
   
    methods (Access = public)
        % constructor
        function instance = Constellation(file)
            if  nargin > 0
                instance.name = file.name(1:end-4);
                instance.image = imread([file.folder,'\', instance.name,'.png']);
            end
        end

        function object = distance(instance, constellation)
            object.name = constellation.name;
            object.distance = norm(constellation.features - instance.features);
        end
    end
end