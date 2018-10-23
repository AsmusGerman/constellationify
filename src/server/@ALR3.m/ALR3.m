classdef ALR3

    methods(Static)
        function features = Run(constellation, nAngules, nProportions)
            nStars = length(constellation.stars);
            
            histogram = zeros(nAngules, nProportions);
            angles = [0:180/nAngules:180];
            proportions = [0:1/nProportions:1];

            for i = 1 : nStars
                for j = i + 1 : nStars
                    
                    %by the law of cosines
                    [OA, OB, AB] = constellation.edges(i, j);
                    angle = acosd((OA^2 + OB^2 - AB^2)/(2*OA*OB));
                    
                    proportion = min([OA, OB])/max([OA, OB]);

                    angleRangeInterval = find(angles < angle);
                    %as the array is sorted, the maximum angle is the last one
                    angleRangeInterval = angleRangeInterval(end);

                    proportionRangeInterval = find(proportions < proportion);
                    %same, the maximum proportion is the last of the array
                    proportionRangeInterval = proportionRangeInterval(end);

                    histogram(angleRangeInterval, proportionRangeInterval) = 1 + histogram(angleRangeInterval, proportionRangeInterval);
                end
            end
            % Normalization
            features = histogram(:);
            features_norm = norm(features);
            
            if(features_norm > 0)
                features = features/features_norm;
            end
        end
    end
end