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
        function instance = Constellation(image, name)
            
            warning('off','all');

            instance.image = image;
            if  nargin > 1
                %name property set by file name
                instance.name = char(name);
            end

            %populate the constellation with stars
            max_radius = 50;
            instance.stars = StarFinder.process(instance, max_radius);
        end
    end
end