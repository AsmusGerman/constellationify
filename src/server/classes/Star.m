classdef Star
    properties
        center;
        radius;
    end
    methods
        function instance = Star(center, radius)
            instance.center = center;
            instance.radius = radius;
        end
    end
end