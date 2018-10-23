function [OA, OB, AB] = edges(instance, first, second)
    OA = norm(instance.centroid - instance.stars(first).center);
    OB = norm(instance.centroid - instance.stars(second).center);
    AB = norm(instance.stars(first).center - instance.stars(second).center);
end