classdef Controller < Scoped
properties
    repository;
end
    methods (Access = public)
        function instance = Controller()
            instance.repository = Repository();
        end

        function constellations = import(instance)
            try
                constellations = [];
                Logger.info('Importing constellations');
                constellations = instance.repository.getAll();
                
%{
 if isempty(constellations)
                    constellations = FileTools.import([Scoped.scope.configuration.results, Scoped.scope.configuration.processors.FeatureProcessor.params.algorithm.name, '.data']).data;
                end 
%}

            catch exception
                Logger.error(['Import failed. Inner exception: ', exception.message]);
            end               
        end

        function constellations = reconstruct(instance)
            try
                Logger.info('Reconstructing constellations');
                %get images form assets/images directory
                Logger.info(['... reconstructing ']);
                files = dir(Scoped.scope.configuration.assets.images);
                nFiles = length(files);
                for index = 1 : nFiles
                    PresentationTools.loader(index, nFiles);
                    constellations(index) = Constellation(files(index));
                end
            catch exception
                Logger.error([char(10), 'Reconstruct failed. Inner exception: ', exception.message]);   
            end
        end

        function process(instance, constellations)
            try
                processors = Scoped.scope.configuration.processors;
                nConstellations = length(constellations);
                %if processed images dosn't exist
                Logger.info('... processing');
                if(exist(processors.images) == 0)
                    instance.reprocess(constellations);
                else
                    instance.readAndProcess(constellations);
                end
            catch exception
                Logger.error(['Process failed. Inner exception: ', exception.message]);
            end
        end

        function output = compare(instance, constellation, neighbours)
            try
                output = instance.repository.compare(constellation, neighbours);                
            catch exception
                Logger.error(['Compare failed. Inner exception: ', exception.message]);                
            end
        end

        function constellation = create(instance, file)
            constellation = Constellation(file);

            processors = Scoped.scope.configuration.processors;
            constellation.image = ImageProcessor.execute(constellation.image, processors.ImageProcessor.params);
            constellation.stars = ShapeProcessor.execute(constellation.image, processors.ShapeProcessor.params);
            constellation.features = FeatureProcessor.execute(constellation, processors.FeatureProcessor.params);
        end
    end

    methods (Access = private)
        function constellations = reprocess(instance, constellations)
            processors = Scoped.scope.configuration.processors;
            nConstellations = length(constellations);
            for index = 1:nConstellations
                PresentationTools.loader(index, nConstellations);
                constellations(index).image = ImageProcessor.execute(constellations(index).image, processors.ImageProcessor.params);
                constellations(index).stars = ShapeProcessor.execute(constellations(index).image, processors.ShapeProcessor.params);
                constellations(index).features = FeatureProcessor.execute(constellations(index), processors.FeatureProcessor.params);
                instance.repository.insert(constellations(index));
            end
        end

        function constellations = readAndProcess(instance, constellations)
            processors = Scoped.scope.configuration.processors;
            nConstellations = length(constellations);
            for index = 1:nConstellations
                PresentationTools.loader(index, nConstellations);
                constellations(index).image = imread([processors.images, constellations(index).name, '.png']);
                constellations(index).stars = ShapeProcessor.execute(constellations(index).image, processors.ShapeProcessor.params);
                constellations(index).features = FeatureProcessor.execute(constellations(index), processors.FeatureProcessor.params);
                instance.repository.insert(constellations(index));
            end
        end
    end
end