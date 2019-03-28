classdef Controller < Scoped
    methods (Static, Access = public)
        function constellations = import()
            try
                constellations = [];
                Logger.info('Importing constellations');
                constellations =  FileTools.import([Scoped.scope.configuration.results, Scoped.scope.configuration.processors.FeatureProcessor.params.algorithm.name, '.data']).data;
            catch exception
                Logger.error(['Import failed. Inner exception: ', exception.message]);
            end               
        end

        function constellations = reconstruct()
            try
                Logger.info('Reconstructing constellations');
                Logger.info('loading constellations dataset');
                
                %get images form assets/images directory
                Logger.info(['... reconstructing ']);
                files = dir(Scoped.scope.configuration.assets.images);
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

        function output = process(constellations)
            try
                processors = Scoped.scope.configuration.processors;
                nConstellations = length(constellations);
                %if processed images dosn't exist
                if(exist(processors.images) == 0)
                    Logger.info('... processing images and shapes');
                    for index = 1:nConstellations
                        PresentationTools.loader(index, nConstellations);
                        constellations(index).image = ImageProcessor.execute(constellations(index).image, processors.ImageProcessor.params);
                        constellations(index).stars = ShapeProcessor.execute(constellations(index).image, processors.ShapeProcessor.params);
                    end
                else
                    Logger.info('... reading images and processing shapes');
                    for index = 1:nConstellations
                        PresentationTools.loader(index, nConstellations);
                        constellations(index).image = imread([processors.images, constellations(index).name, '.png']);
                        constellations(index).stars = ShapeProcessor.execute(constellations(index).image, processors.ShapeProcessor.params);
                    end
                end
                Logger.log('');
                output = FeatureProcessor.execute(constellations, processors.FeatureProcessor.params);

                if(~isempty(output))
                    Logger.info('Saving features');
                    FileTools.export([Scoped.scope.configuration.results, processors.FeatureProcessor.params.algorithm.name, '.data'], output);
                else
                    Logger.warning('No data found, constellations features are empty...');
                end
            catch exception
                Logger.error(['Process failed. Inner exception: ', exception.message]);
            end
        end

        function constellation = create(file)
            constellation = Constellation(file);

            processors = Scoped.scope.configuration.processors;
            constellation.image = ImageProcessor.execute(constellation.image, processors.ImageProcessor.params);
            constellation.stars = ShapeProcessor.execute(constellation.image, processors.ShapeProcessor.params);

            processor = Scoped.scope.configuration.processors.FeatureProcessor;
            data = FeatureProcessor.execute(constellation, processor.params);
            constellation.features = data.features;
        end
    end
end