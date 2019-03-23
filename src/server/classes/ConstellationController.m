classdef ConstellationController
    properties (Access=private)
        application
    end
    methods (Access = public)

        function instance = ConstellationController(application)
            instance.application = application;
        end

        function constellations = load(instance)
            try
                Logger.info('Importing constellations');
                constellations = instance.import();
                Logger.success('Import succeed');
            catch exception
                Logger.warning(['Import failed. Inner exception: ', exception.message]);
                
                Logger.info('Reconstructing constellations');
                constellations = instance.construct();
                Logger.success('reconstruction succeed'),
                %saves the constellations to an isolated file
                for index = 1:length(constellations)
                    data(index) = constellations(index);
                end
                Logger.info('Saving reconstructed constellations');
                FileTools.save(instance.application.configuration.constellations, data);
            end
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

    methods (Access = private)
    
        function constellations = import(instance)
            %checks if there is a seved file
            if(exist(instance.application.configuration.constellations) ~= 2)
                error(instance.application.messages.errors.A1.message, instance.application.messages.errors.A1.id)
            else
                %imports the file
                constellations = FileTools.load(instance.application.configuration.constellations).data;
            end
        end

        function constellations = construct(instance)
            %get all the file names from the images directory
            images = instance.application.configuration.assets.images;
            files = dir(strcat(images.directory,'/*.', images.extension));
            nFiles = length(files);
            for index = 1 : nFiles
                constellations(index) = Constellation(instance.application, files(index));
            end
        end
    end
end