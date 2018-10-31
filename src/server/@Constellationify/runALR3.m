function constellations = runALR3(constellations, nAngles, nProportions)
    nConstellations = numel(constellations);

    for i = 1 : nConstellations
        constellations(i).features = ALR3.run(constellations(i), nAngles, nProportions);
    end

    
end