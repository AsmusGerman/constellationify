function constellations = main(nAngles, nProportions)

    alr3_file = 'results/ALR3.A18P10';

    %if alr3_file file doesn't exists, run alr3 and save the file
    if(exist(strcat(alr3_file,'.mat')) ~= 2)
        
        constellations_file = 'results/constellations';
        %if file doesn't exists, run initial process and save the file
        if(exist(strcat(constellations_file,'.mat')) ~= 2)
            Constellationify.init();
        end

        %import the file
        constellations = MatFileController.import(constellations_file);
        constellations = ALR3(constellations, nAngles, nProportions);

        %save the alr3 result to an isolated file
        MatFileController.save(alr3_file, constellations);
    end

    constellations = MatFileController.import(alr3_file);
end

function constellations = initialize()
    %read all the image names from the directory set
    files = MatFileController.read('./assets/images/', 'png');

    constellations = Collection();

    nFiles = length(files);
    %create the constellations
    for i = 1 : nFiles
        % get the file name and full name
        name = ImageProcessor.getName(files(i).value);
        url = ImageProcessor.getFullName(files(i).value);

        constellation = Constellation(url, name);
        constellations = constellations.add(constellation);
    end

    constellations = [constellations.value];
    %save the constellations to an isolated file
    MatFileController.save('constellations', constellations);
end

function constellations = ALR3(constellations, nAngles, nProportions)
    nConstellations = numel(constellations);
    for i = 1 : nConstellations
        constellations(i).features = ALR3.run(constellations(i), nAngles, nProportions);
    end
end