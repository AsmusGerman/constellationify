function [centers, radius] = centers(constellation)
    centers = reshape([constellation.stars.center],2,[])';
    radius = reshape([constellation.stars.radius],1,[])';
end