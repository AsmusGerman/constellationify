classdef ConstellationController < Scoped
    methods (Static, Access = public)
        function [constellations, imported] = load()
            imported = true;
            constellations = [];
            try
                Logger.info('Importing constellations');
                constellations = ConstellationController.import();
                if(isempty(constellations))
                    Logger.info('Reconstructing constellations');
                    constellations = ConstellationController.reconstruct();
                    imported = false;
                end
            catch exception
                Logger.error(['Load failed. Inner exception: ', exception.message]);
            end               
        end

        function output = process(constellations)
            try
                algorithm = DynamicLoader.resolve(Constellation.scope.configuration.algorithm.name);
                nConstellations = length(constellations);
                Logger.info('... processing');
                for index = 1 : nConstellations
                    PresentationTools.loader(index, nConstellations);

                    constellation = constellations(index);
                    constellation = Tools.struct2class('Constellation', constellation);
                    constellation.features = algorithm.execute(constellation, Constellation.scope.configuration.algorithm.params);
                    output(index) = struct('name', constellation.file.name(1:end-4), 'features', constellation.features);
                end
                Logger.log('');
                if(~isempty(output))
                    Logger.info('Saving processed data');
                    FileTools.save(Constellation.scope.configuration.constellations, output);
                else
                    Logger.warning('No data found, constellations features are empty...');
                end
            catch exception
                Logger.error(['Process failed. Inner exception: ', exception.message]);
            end
        end

        function constellation = create(file)
            constellation = Constellation(file);
            algorithm = DynamicLoader.resolve(Constellation.scope.configuration.algorithm.name);
            constellation.features = algorithm.execute(constellation, Constellation.scope.configuration.algorithm.params);
        end

        function show(constellation)
            imshow(image);
    
            %get every star center
            [centers, radius] = centers();

            %every star with each radius
            viscircles(centers, radius,'EdgeColor','b');

            %centroid with radius = 2
            viscircles(centroid, 2,'EdgeColor','r');
        end
    end

    methods (Static, Access = private)
    
        function constellations = import()
            constellations = [];
            try
                constellations = FileTools.load(ConstellationController.scope.configuration.constellations);
            catch exception
                Logger.error(['Import failed. Inner exception: ', exception.message]);
            end
        end

        function constellations = reconstruct()
            try
                %get all the file names from the images directory
                images = ConstellationController.scope.configuration.assets.images;
                Logger.info(['loading constellations images from: ', images.directory]);
                files = dir(strcat(images.directory,'/*.', images.extension));
                Logger.info(['... reconstructing ']);
                nFiles = length(files);
                for index = 1 : nFiles
                    PresentationTools.loader(index, nFiles);
                    constellations(index) = Constellation(files(index));
                end
                Logger.log('');
            catch exception
                Logger.error(['Reconstruct failed. Inner exception: ', exception.message]);   
            end
        end
    end
end