% singleton class
% resolve the fullname of a class and return an instance of it
classdef DynamicLoader
    properties (Access = private)
        application
    end

    methods (Access = private)
        function instance = DynamicLoader(application)
            instance.application = application;
        end 
    end

    methods (Static)
      function instance = instance(application)
         persistent singleton
         if isempty(singleton)
            instance = DynamicLoader(application);
            singleton = instance;
         else
            instance = singleton;
         end
      end
   end

    methods (Access = public)
        function algorithm = load(instance, reference)
            algorithm = eval(instance.application.configuration.algorithm.name);
        end
    end
end