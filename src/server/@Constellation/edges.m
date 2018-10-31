function [OA, OB] = edges(instance, first, second)
    %centroid to first
    OA = instance.stars(first).center - instance.centroid;
    %OA = OA/norm(OA)

    %centroid to second
    OB = instance.stars(second).center - instance.centroid;
    %OB = OB/norm(OB)
end