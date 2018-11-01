function [output, constellation] = query_test(image, isColor)

    warning('off','all');
    nAngles = 18;
    nProportions = 10;
    
    constellation = ConstellationBuilder.build(image, '', isColor);

    constellation.features =  ALR3.run(constellation, nAngles, nProportions);

    % load the constellations from the 'results' folder
    targets = main(nAngles, nProportions);
    nTargets = length(targets);
    for i = 1 : nTargets
        output(i) = constellation.compare(targets(i));
    end

end