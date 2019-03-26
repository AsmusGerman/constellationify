classdef PresentationTools
    methods (Static)
        function present()
            signature0 = fileread('resources/signature.0.txt');
            signature1 = fileread('resources/signature.1.txt');

            for index = 1:10
                clc;
                if rem(index, 2) == 0
                    disp(signature0);
                else
                    disp(signature1);
                end
                pause(0.2);
            end
        end

        function loader(value, total)
            percent = (value * 100)/ total;
            fprintf(['\b\b\b', char(178), '%*.0f%%'], 2, percent);
        end
    end
end