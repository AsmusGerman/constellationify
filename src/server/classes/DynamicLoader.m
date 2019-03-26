% singleton class
% resolve the fullname of a class and return an instance of it
classdef DynamicLoader
    methods (Static)
      function algorithm = resolve(reference)
        algorithm = eval(reference);
    end
   end
end