classdef Constellationify
    properties
        data;
    end
    methods (Access = private)
        function instance = Constellationify()
            application = Bootstrapper.boot();
            instance.data.application = application

            PresentationTools.present();

            constellations = ConstellationController(application).load();
            algorithm = DynamicLoader.instance(application).load();

            for index = 1:length(constellations)
                constellation = constellations(index);
                constellation = Tools.struct2class('Constellation', constellation);
                %constellation = typecast(output.constellations(index), 'Constellation');
                constellation.features = algorithm.execute(constellation, application.configuration.algorithm.params);
                instance.data.(application.configuration.algorithm.name).(constellation.file.name(1:end-4)) = constellation;
            end
        end
    end

    methods (Static)
        function instance = instance()
            persistent singleton
            if isempty(singleton)
                instance = Constellationify();
                singleton = instance;
             else
                instance = singleton;
             end
        end
    end

    methods (Access = public)   

        function features(instance, constellation)
            instance.data.ALR3AllAgainstAll.(constellation).features'
        end

        function output = query(url)
            nAngles = 18;
            nProportions = 10;

            constellation = ConstellationBuilder.build(url,'')
            constellation.features =  ALR3.run(constellation, nAngles, nProportions);

            % load the constellations from the 'results' folder
            targets = main(nAngles, nProportions);
            nTargets = length(targets);
            for i = 1 : nTargets
               output(i) = constellation.compare(targets(i));
            end
        end
    end
end

% application: {
%   configuration: {
%       algorithm: {
%           name: string,
%           params: {}
%       },
%       assets: {
%           images: { 
%               directory: string,
%               extension: string 
%           }
%       },
%       extensions: [
%          ..., string 
%       ],
%       processes: {
%           ImageProcessor: { rRange: [number, number], bRange: [number, number], gRange: [number, number]}
%       },
%       constellations: string,
%       output: string
%   },
%   messages: {
%       errors: {
%           ...,
%           id: { message, id }
%       }
%   }
% }