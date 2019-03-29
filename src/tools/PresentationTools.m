classdef PresentationTools
    methods (Static)
        function signature(presentation)
            if (presentation.enabled)
                eval(presentation.animations.signature);
            end
        end

        function loader(value, total)
            percent = (value * 100)/ total;
            fprintf(['\b\b\b', char(178), '%*.0f%%'], 2, percent);
        end
    end
end