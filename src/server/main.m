function constellations = main()
    tic;
    dir = './assets/images/';
    %read all the image names
    files = ls (strcat(dir,'*.png'));
    files = cellstr(files);
    %create the constellations
    for i = 1 : length(files)
        name = strsplit(char(files(i)),'.');
        name = name(1);

        %get the image files
        file = strcat(dir,files(i))
        c = constellation(file, name);
        c.features = ALR3(c, 10, 10);
        constellations(i) = c;
    end
    toc
end
