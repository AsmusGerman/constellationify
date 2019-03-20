function [OA, OB] = edges(first, second)
    %centroid to first
    OA = stars(first).center - centroid;

    %centroid to second
    OB = stars(second).center - centroid;
end