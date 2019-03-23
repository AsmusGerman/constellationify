classdef ALR3

    methods(Static)
        function features = execute(constellation, nAngles, nProportions)
            nStars = length(constellation.stars);
            
            histogram = zeros(nAngles, nProportions);
            angles = [0:180/nAngles:180];
            angles(end) = [];

            proportions = [0:1/nProportions:1];
            proportions(end) = [];

            for i = 1 : nStars
                for j = 1 : nStars
                    if i ~= j
                        %non normalized vectors
                        [OA, OB] = constellation.edges(i, j);
                        
                        nOA = norm(OA);
                        nOB = norm(OB);

                        angle = acosd(dot(OA,OB)/(nOA*nOB));

                        proportion = nOA/nOB;

                        if proportion > 1
                            proportion = 1/proportion;
                        end

                        angleRangeInterval = find(angles <= angle);
                        %as the array is sorted, the maximum angle is the last one
                        angleRangeInterval = max(angleRangeInterval);

                        proportionRangeInterval = find(proportions <= proportion);
                        %same, the maximum proportion is the last of the array
                        proportionRangeInterval = max(proportionRangeInterval);

                        histogram(angleRangeInterval, proportionRangeInterval) = 1 + histogram(angleRangeInterval, proportionRangeInterval);
                    end
                end
            end
            % Normalization
            histogram;
            features = histogram(:);
            features_norm = norm(features);
            
            if(features_norm > 0)
                features = features/features_norm;
            end
        end
    end
end