classdef ALR3AllAgainstAll
    methods(Static)
        function features = execute(constellation, params)
            nStars = length(constellation.stars);
        
            histogram = zeros(params.angles, params.proportions);
            angles = [0:180/params.angles:180];
            angles(end) = [];

            proportions = [0:1/params.proportions:1];
            proportions(end) = [];

            table = [];
            for centroid = 1 : nStars
                for j = 1 : nStars
                    for k = 1 : nStars - 1
                        if centroid ~= j && centroid~=k && j~=k
                            %si no existe la terna en la tabla
                            if sum(ismember(table,  [centroid, j, k], 'rows')) < 1
                                %se agrega la terna
                                table = [table; [centroid, j, k]];

                                %non normalized vectors
                                [OA, OB] = constellation.edgesFrom(j, k, centroid);
                            
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