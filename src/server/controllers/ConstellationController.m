classdef ConstellationController
    methods
        function constellations = load()
            try
                constellations = import();
            catch
                constellations = build();
                %saves the constellations to an isolated file
                MatFileController.save(application.configuration.constellations, constellations);
            end
        end
        function show(constellation)
            imshow(image);
    
            %get every star center
            [centers, radius] = centers()

            %every star with each radius
            viscircles(centers, radius,'EdgeColor','b');

            %centroid with radius = 2
            viscircles(centroid, 2,'EdgeColor','r');
        end
    end

    methods (private)
        function constellations = import()
            %checks if there is a seved file
            if(exist(application.configuration.constellations) ~= 2)
                error(application.messages.errors.A1.message., application.messages.errors.A1.id)
            else
                %imports the file
                constellations = MatFileController.import(application.configuration.constellations);
            end
        end
        function constellations = build()
            %get all the file names from the images directory
            files = dir(strcat(application.configuration.assets.images.directory,'/*.', application.configuration.assets.images.extension));
            nFiles = length(files);
            constellations(1: nFiles) = Constellation(file(1:nFiles));
        end
    end
end