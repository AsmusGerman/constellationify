function show(instance)
   imshow(instance.image);
    
    %get every star center
    [centers, radius] = instance.centers()

    nCenters = numel(centers);
    %every star radius = 5
    viscircles(centers, radius,'EdgeColor','b');

    %centroid radius = 2
    viscircles(instance.centroid, 2,'EdgeColor','r');
end