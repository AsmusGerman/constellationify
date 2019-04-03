classdef Repository
    properties
        context;
    end
    methods
        function instance = Repository()
            instance.context = DBContext();
        end
        function insert(instance, constellation)
            instance.context.insert('insert', constellation); 
        end
        function output = getAll(instance)
            output = instance.context.get('getAll');
        end
        function output = compare(instance, constellation, neighbours)
            output = instance.context.execute('obtenerNConstelacionesMasCercanas', constellation, neighbours);
        end
    end
end