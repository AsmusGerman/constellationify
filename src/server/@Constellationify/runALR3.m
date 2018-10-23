function constellations = runByARL3(nAngles, nProportions)
    constellations = Collection();
    
    nConstellations = length(instance.constellations);
    for i = 1 : nConstellations
        constellation = ALR3.Run(constellations(i), nAngles, nProportions);
        constellations = constellations.add(constellation);
    end
end