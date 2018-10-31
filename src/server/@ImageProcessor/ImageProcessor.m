classdef ImageProcessor
    methods(Static)
        
       function name = getName(file)
            name = strsplit(char(file),'.');
            name = name(1); %file name without extension
        end

        function url = getFullName(file)
            url = strcat(Constellationify.set, file); %full name
        end

        function image = process(image)
            %read the file by its full name
            image = imread(char(image));
            image = ImageProcessor.processData(image);
        end
        
        function image = processData(image)
                    
            % split the chanels
            [red, green, blue] = split(image);

            % the points color range
            rRange = [170 180];
            gRange = [70 74];
            bRange = [15 20];
            
            % get the mask
            mRed = ranged(red, rRange);
            mGreen = ranged(green, gRange);
            mBlue = ranged(blue, bRange);
            mask = mRed & mGreen & mBlue;

            % for the three chanells
            % paint in white all colors of the mask
            red(mask) = 253;
            green(mask) = 255;
            blue(mask) = 255;

            % merge the chanels
            image = cat(3, red, green, blue);
            image = sharp(image);            
        end
    end
end

function [red, green, blue] = split(image)
    red = image(:,:,1);
    green = image(:,:,2);
    blue = image(:,:,3);
end

function selection = ranged(source, range)
    below = (source < range(1));
    above = (source > range(2));
    selection = or(below,above);
end


function image = sharp(image)
    % set the image colormap to grayscale
    image = rgb2gray(image);
                
    % noise removal
    % see: http://www.mathworks.com/help/images/noise-removal.html
    image = imnoise(image, 'salt & pepper', 0.02);
    image = medfilt2(image);
    
    %color to bw
    image = im2bw(image);
    image = imcomplement(image);
end