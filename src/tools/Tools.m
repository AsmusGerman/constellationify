classdef Tools
    methods (Static)
        function object = struct2class(classname, s)
            %converts structure s to an object of class classname.
            %assumes classname has a constructor which takes no arguments
            object = eval(classname);  %create object
            for fn = fieldnames(s)'    %enumerat fields
                try
                    object.(fn{1}) = s.(fn{1});   %and copy
                catch
                    warning('Could not copy field %s', fn{1});
                end
            end
        end
        function output = cast(type, object)
            %create object
            output = eval(type);
            for field = fieldnames(object) 
                try
                    output.(field{1}) = object.(field{1});
                catch
                    warning('Could not cast object field %s', field{1});
                end
            end
        end
    end
end