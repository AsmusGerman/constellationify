classdef Star
    properties
        x;
        y;
    end
    methods (Static)
        function output = vector(from, to)
            output = [to.x - from.x, to.y - from.y];
        end
    end
end