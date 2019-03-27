function output = Constellationify(constellation)
    context = boot();
    output = Application.start(context);
    if nargin == 1
        constellations = output.(Application.scope.configuration.algorithm.name);
        Application.compare(constellation, constellations);
    end
end

function context = boot()
    clc; clear;
    warning('off','all');

    %loads project dirs
    addpath('./algorithms/')
    addpath('./classes/');
    addpath('./tools/');
    addpath('./resources/');

    %loads vendor libraries
    addpath('vendors/jsonlab');
    addpath('vendors/struct2table');

    context.configuration = loadjson('config.json');
    context.messages = loadjson('messages.json');

    if(context.configuration.octave)
        pkg load image;
    end
end