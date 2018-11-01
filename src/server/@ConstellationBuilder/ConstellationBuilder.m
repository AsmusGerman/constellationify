classdef ConstellationBuilder
    
    methods(Static)       
        
        function constellation = build(url, name, isColor)
            image = imread(char(url));
            image = ImageProcessor.truecolor(image);
            if isColor
                image = ImageProcessor.process(image);
            end

            constellation = Constellation(image, name);
        end
    end
end

