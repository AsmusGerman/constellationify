classdef Test

    properties(Constant)
        set = './@Test/assets/images/';
        extension = 'png';
    end

    methods(Static)
        %test for 18 angle ranges and 10 proportion ranges
        output = test_18_10()

        function output = compare(constellation, targets)
            euclidean = @(A,B) norm(A-B);
            
            nTargets = length(targets);
            for i = 1 : nTargets
                output(i).target = targets(i).name;
                output(i).distance = bsxfun(euclidean, constellation.features, targets(i).features);
            end
        end
        
        function showDistancesAsTable(constellation)
            disp(constellation.name)
            struct2table(constellation.distances)
        end
    end
    
end