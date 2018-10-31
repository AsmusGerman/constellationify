classdef Test
    methods(Static)
        %test for 18 angle ranges and 10 proportion ranges
        output = A18P10()

        function output = compare(constellation, targets)
            nTargets = length(targets);
            for i = 1 : nTargets
                output(i) = constellation.compare(targets(i));
            end
        end
        
        function showDistancesAsTable(constellation)
            disp(constellation.name)
            struct2table(constellation.distances)
        end
    end
    
end