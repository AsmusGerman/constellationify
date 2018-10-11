classdef constellation
    
    properties
        name
        image
        stars
        centroid
        features
    end
    
    methods
        % constructor
        % creates a new constellation intance
        % by passing the image file name as the argument
        function instance = constellation(file, name)
            %property initialization
            instance.name = char(name);
            instance.image = imread(char(file));
            
            %populate the constellation with stars
            radius = [1 30];
            [centers, radii, ~] = imfindcircles(instance.image, radius);
            
            for i = 1 : length(centers)
                instance.stars = [instance.stars, star(centers(i, :), radii(i, :))];
            end

            instance.centroid = mean(instance.centers());


        end
        
        % show the image
        function show(instance)
            imshow(instance.image);
            centers = instance.centers();
            radii = [instance.stars.radius]';
            viscircles(centers, radii ,'EdgeColor','b');
            viscircles(instance.centroid, 2 ,'EdgeColor','r');
        end
        
        function centers = centers(instance)
            centers =  reshape([instance.stars.center],2,[])';
        end
    end
end
