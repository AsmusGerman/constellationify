classdef ShapeProcessor
    methods (Static, Access = public)
        function shape = execute(image, params)
            %max radius = 50
            radius = params.maxRadius;
            [centers, radii, ~] = imfindcircles(image, [1 radius],'ObjectPolarity','dark');
            nCenters = length(centers);
            for index = 1 : nCenters
                shape.center = centers(index);
                shape.radius = radii(index);
            end
            shape
        end
    end
end