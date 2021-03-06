classdef ALR3Centroid
    methods(Static)
        function features = execute(constellation, params)
            nStars = length(constellation.stars);
        
            histogram = zeros(params.angles, params.proportions);
            angles = [0:180/params.angles:180];
            angles(end) = [];

            proportions = [0:100/params.proportions:100];
            proportions(end) = [];

            for i = 1 : nStars
                for j = 1 : nStars
                    if i ~= j
                        %non normalized vectors
                        [OA, OB] = ALR3Centroid.edges(constellation, i, j);
                        
                        nOA = norm(OA);
                        nOB = norm(OB);

                        %angle = acos(min(1,max(-1, OA(:).' * OB(:) /nOA / nOB )))
                        angle = acosd(dot(OA,OB)/(nOA*nOB));

                        proportion = nOA/nOB;

                        if proportion > 1
                            proportion = 1/proportion;
                        end

                        proportion = proportion * 100;

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

    methods (Static, Access = private)
        function value = centroid(constellation)
            value.x = mean([constellation.stars(1:end).x]);
            value.y = mean([constellation.stars(1:end).y]);
        end

        function [OA, OB] = edges(constellation, first, second)
            centroid = ALR3Centroid.centroid(constellation);
             %centroid to first
             OA = Star.vector(constellation.stars(first), centroid);
             %centroid to second
             OB = Star.vector(constellation.stars(second), centroid);
        end
    end
end