classdef (Abstract) Scoped < handle
    methods (Static)
      function out = scope(data)
         persistent scope;
         if nargin
            scope = data;
         end
         out = scope;
      end
   end
end