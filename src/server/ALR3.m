function features = ALR3(constellation, nProportions, nAngules)
    stars = length(constellation.stars);
    
    histogram = zeros(nAngules, nProportions);
    angles = [0:180/nAngules:180];
    proportions = [0:1/nProportions:1];

    for i = 1 : stars
        for j = i + 1 : stars
            
            %by the law of cosines
            [OA, OB, AB] = edges(constellation.centroid, constellation.stars(i).center, constellation.stars(j).center);
            angle = acosd((OA^2 + OB^2 - AB^2)/(2*OA*OB));
            
            proportion = min([OA, OB])/max([OA, OB]);

            angleRangeInterval = find(angles <= angle);
            %as the array is sorted, the maximum angle is the last one
            angleRangeInterval = angleRangeInterval(end);

            proportionRangeInterval = find(proportions <= proportion);
            %same, the maximum proportion is the last of the array
            proportionRangeInterval = proportionRangeInterval(end);

            histogram(angleRangeInterval, proportionRangeInterval) = 1 + histogram(angleRangeInterval, proportionRangeInterval);
        end
    end
    % Normalization
    features = histogram(:);
    features = features.*norm(features);
end

function [OA, OB, AB] = edges(vertex, first, second)
    OA = norm(vertex-first);
    OB = norm(vertex-second);
    AB = norm(first - second);
end