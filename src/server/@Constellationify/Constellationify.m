classdef Constellationify
    
    methods(Static)       
        
        function output = query(url)
            nAngles = 18;
            nProportions = 10;

            constellation = ConstellationBuilder.build(url,'')
            constellation.features =  ALR3.run(constellation, nAngles, nProportions);

            % load the constellations from the 'results' folder
            targets = main(nAngles, nProportions);
            nTargets = length(targets);
            for i = 1 : nTargets
               output(i) = constellation.compare(targets(i));
            end
        end
    end
end

