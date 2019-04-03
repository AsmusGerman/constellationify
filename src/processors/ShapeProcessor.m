classdef ShapeProcessor
    methods (Static, Access = public)
        function shapes = execute(image, params)
            %max radius = 50
            radius = params.maxRadius;
            [centers, radii, ~] = imfindcircles(image, [1 radius],'ObjectPolarity','dark');
            [nCenters, ~] = size(centers);
            for index = 1 : nCenters
                shape.x = centers(index, 1);
                shape.y = centers(index, 2);
                shapes(index) = Tools.struct2class('Star', shape);
            end
        end
    end
end