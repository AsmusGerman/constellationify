classdef Constellation < handle
    properties (Access = private)
        application
    end

    properties
        image;
        stars;
        features;
        file;
    end
   
    methods (Access = public)
        % constructor
        % creates a new constellation intance
        % by passing the file as argument
        function instance = Constellation(application, file)
            if  nargin > 0
                instance.application = application;
                instance.file = file;
                instance.image = instance.ImageProcess();
                instance.stars = instance.FindCircles();
            end
        end

        function distance = GetDistanceFrom(constellation)
            distance = norm(features - constellation.features);
        end

        function value = filename(instance)
            value = strcat(instance.file.folder, '\', instance.file.name);
        end
        function value = centroid(instance)
            value = mean(instance.stars.center);
        end

        function [OA, OB] = edges(instance, first, second)
            [OA, OB] = instance.edgesFrom(first, second, centroid);
        end
        
        %third === centroid
        function [OA, OB] = edgesFrom(instance, first, second, third)
                %centroid to first
                OA = instance.stars(first).center - third;
        
                %centroid to second
                OB = instance.stars(second).center - third;
        end

        function obj = toStruct(instance)
            obj.image = instance.image;
            obj.stars = instance.stars;
            obj.features = instance.features;
            obj.file = instance.file;
        end
    end

    methods (Static)
        function instance = import(obj)
            instance.image = obj.image;
            instance.stars = obj.stars;
            instance.features = obj.features;
            instance.file = obj.file;
        end
    end

    methods (Access = private)
        function image = ImageProcess(instance)
            configuration = instance.application.configuration.processes.ImageProcessor;
            image = imread(char(instance.filename));
            image = ImageTools.truecolor(image);

            % split the chanels
            [red, green, blue] = ImageTools.split(image);

            % get the mask
            % the points color range
            %rRange = [170 180];
            %gRange = [70 74];
            %bRange = [15 20];
            mRed = ImageTools.ranged(red, configuration.rRange);
            mGreen = ImageTools.ranged(green, configuration.gRange);
            mBlue = ImageTools.ranged(blue, configuration.bRange);
            mask = mRed & mGreen & mBlue;

            % for the three chanells
            % paint in white all colors of the mask
            red(mask) = 255;
            green(mask) = 255;
            blue(mask) = 255;

            % merge the chanels
            image = cat(3, red, green, blue);
            image = ImageTools.sharp(image);
            image = im2bw(image);
        end
        
        function stars = FindCircles(instance)
            %max radius = 50
            radius = instance.application.configuration.processes.FindCircles.maxRadius;
            [centers, radii, ~] = imfindcircles(instance.image, [1 radius],'ObjectPolarity','dark');
            nCenters = length(centers);
            for index = 1 : nCenters
                stars(index) = Star(centers(index), radii(index));
            end
        end
    end
end