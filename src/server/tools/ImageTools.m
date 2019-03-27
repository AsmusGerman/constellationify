classdef ImageTools
    methods (Static)
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

            saltpepper = load("resources/saltpepper.data").saltpepper;
            image = [image saltpepper];
            image = medfilt2(image);
        end         
    end
end