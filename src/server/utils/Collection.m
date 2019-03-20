classdef Collection
   properties
      value
   end
   methods
        function instance = Collection(object)
            if nargin > 0
                instance.value = object;
            end
        end

        function instance = add(instance, object)
            if(isempty([instance.value]))
                instance = Collection(object);
            else
                instance = [instance, Collection(object)];
            end
        end
   end
end