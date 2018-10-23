classdef Constellation
    
    properties
        name
        image
        stars
        features
    end
   
    methods

        % constructor
        % creates a new constellation intance
        % by passing the image file name as the argument
        function instance = Constellation(file, name)
            
            %name property set by file name
            instance.name = char(name);
            
            %image property set by processing the file
            instance.image = ImageProcessor.process(file);
            
            %populate the constellation with stars
            max_radius = 100;
            instance.stars = StarFinder.process(instance, max_radius);
        end
    end
end