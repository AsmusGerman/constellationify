classdef (Abstract) Scoped < handle
    methods (Static)
      function output = scope(data)
         persistent scope;
         if nargin
            scope = data;
         end
         output = scope;
      end
   end
end