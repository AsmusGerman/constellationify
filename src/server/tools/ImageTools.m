classdef ImageTools
    methods (Static)    
        function saltpepper()
            saltpepper = ones(500, 700);
            saltpepper = imnoise(image, 'salt & pepper', 0.2);
            export('resources/saltpepper.data', saltpepper);
        end
    end
end