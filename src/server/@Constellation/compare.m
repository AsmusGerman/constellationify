function output = compare(constellation, target)
    output.target = target.name;
    output.distance = norm(constellation.features - target.features);
end