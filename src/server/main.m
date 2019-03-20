
function output = main()
    % aplication: {
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
    global application = Boostrapper.boot(application);
    output.constellations = ConstellationController.load();
    algorithm = AlgorithmController.load(application.configuration.algorithm.name);
    output.(application.configuration.algorithm.name) = algorithm.execute(output.constellations);
end