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
    end
end