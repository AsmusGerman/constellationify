classdef StarFinder
    methods(Static)
        function stars = process(constellation, radius)
            stars = Collection();

            [centers, radii, ~] = imfindcircles(constellation.image, [1 radius]);
            nCenters = length(centers);

            for i = 1 : nCenters
                star = Star(centers(i, :), radii(i, :));
                stars.add(star);
            end
        end
    end
end