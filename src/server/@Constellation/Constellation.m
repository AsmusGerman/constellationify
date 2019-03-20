classdef Constellation
    properties (Access = private)
        file
    end

    properties (Dependent = true)
        filename = strcat(file.folder, '\', file.name);      
        centroid = mean(stars.centers);
    end

    properties
        image
        stars
        features
    end
   
    methods 
        % constructor
        % creates a new constellation intance
        % by passing the file as argument
        function instance = Constellation(file)
            instance.file = file;
            instance.image = ImageProcess();
            instance.stars = FindCircles();
        end

        function distance = GetDistanceFrom(constellation)
            distance = norm(features - constellation.features);
        end
    end

    methods (Access = private)
        function image = ImageProcess()
            image = imread(char(filename));
            image = ImageTools.truecolor(image);

            % split the chanels
            [red, green, blue] = split(image);

            % get the mask
            % the points color range
            %rRange = [170 180];
            %gRange = [70 74];
            %bRange = [15 20];
            mRed = ranged(red, configurations.constellations.ImageProcessor.rRange);
            mGreen = ranged(green, configurations.constellations.ImageProcessor.gRange);
            mBlue = ranged(blue, configurations.constellations.ImageProcessor.bRange);
            mask = mRed & mGreen & mBlue;

            % for the three chanells
            % paint in white all colors of the mask
            red(mask) = 255;
            green(mask) = 255;
            blue(mask) = 255;

            % merge the chanels
            image = cat(3, red, green, blue);
            image = sharp(image);
            image = im2bw(image);
        end
        
        function stars = FindCircles()
            %max radius = 50
            radius =configuration.operations.FindCircles.radius.max;
            [centers, radii, ~] = imfindcircles(image, [1 radius],'ObjectPolarity','dark');
            nCenters = length(centers);
            stars(1:nCenters).centers = centers(1:nCenters);
            stars(1:nCenters).radiuses = radii(1:nCenters);
        end

        function centers = myFun(input)
            
        end
    end
end