classdef (Static) Loader
    methods (Static)
      function algorithm = resolve(reference)
        try
          algorithm = eval(reference);          
        catch exception
          Logger.error(exception.message);
        end
      end
   end
end