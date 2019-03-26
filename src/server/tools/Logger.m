 classdef Logger
    methods (Static, Access = public)
        function error(message)
            Logger.log(["\a", '#ERROR: ', message])
        end
        function info(message)
            Logger.log(['#INFO: ', message])
        end
        function success(message)
            Logger.log(['#SUCCESS: ', message])
        end
        function warning(message)
            Logger.log(['#WARNING: ', message])
        end
        function log(message)
            disp([char(10) message]);
        end
    end
end