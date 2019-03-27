classdef ImageProcessor
    methods (Static, Access = public)
        function image = execute(image, params)
            image = ImageProcessor.truecolor(image);

            % split the chanels
            [red, green, blue] = ImageProcessor.split(image);

            % get the mask
            % the points color range
            mRed = ImageProcessor.ranged(red, params.rRange);
            mGreen = ImageProcessor.ranged(green, params.gRange);
            mBlue = ImageProcessor.ranged(blue, params.bRange);
            mask = mRed & mGreen & mBlue;

            % for the three chanells
            % paint in white all colors of the mask
            red(mask) = 255;
            green(mask) = 255;
            blue(mask) = 255;

            % merge the chanels
            image = cat(3, red, green, blue);
            image = ImageProcessor.sharp(image);
            image = im2bw(image);
        end
    end

    methods (Static, Access = private)
        %converts an image to truecolor
        function image = truecolor(image)
            %if is not a truecolor image
            if  size(image, 3) < 3
                %convert to truecolor
                image = demosaic(image, 'bggr');
            end
        end

        %splits an image into its rgb components
        function [red, green, blue] = split(image)
            red = image(:,:,1);
            green = image(:,:,2);
            blue = image(:,:,3);
        end
        
        function selection = ranged(source, range)
            below = (source < range(1));
            above = (source > range(2));
            selection = or(below, above);
        end
        
        function image = sharp(image)
            % set the image colormap to grayscale
            image = rgb2gray(image);
                        
            % noise removal
            % see: http://www.mathworks.com/help/images/noise-removal.html
            saltpepper = load('resources/saltpepper.data').saltpepper;
            image = image + saltpepper; 
            image = medfilt2(image);
        end
    end
end