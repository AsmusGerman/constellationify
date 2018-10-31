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
            
            warning('off','all');

            if  nargin > 1
                %name property set by file name
                instance.name = char(name);
                
                %image property set by processing the file
                instance.image = ImageProcessor.process(file);
            else
                %some strange and random name...
                instance.name = char(randi([65,90],[1 50]));
                
                %image property set by processing the file
                instance.image = ImageProcessor.processData(file);
            end

            %populate the constellation with stars
            max_radius = 100;
            instance.stars = StarFinder.process(instance, max_radius);
        end
    end
end